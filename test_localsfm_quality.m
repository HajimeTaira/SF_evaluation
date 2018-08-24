clear all;
close all;

dataset_name = 'SanFrancisco';

shortlist_description = 'disloc_original_SR';
range = 25;

output_dir = fullfile('outputs', dataset_name);
sfm_dir = fullfile(output_dir, 'recon_from_shortlist', ['shortlist_', shortlist_description], sprintf('range%d', range));

% sfmname_all = dir(fullfile(sfm_dir, '*.jpg'));
% sfmname_all = {sfmname_all.name};

locposes_dir = fullfile(output_dir, 'localization_results');
locpose_matname = fullfile(locposes_dir, ['shortlist_', shortlist_description], sprintf('localsfmrange%dlocposes.mat', range));
load(locpose_matname, 'locposes');


for ii = 1:1:length(locposes)
    this_locposes = locposes(ii);
    
    if ~isempty(this_locposes.P)
        this_recon_matname = fullfile(sfm_dir, this_locposes.Query_name, 'query.mat');
        if exist(this_recon_matname, 'file') == 2
            load(this_recon_matname, 'camQrcn', 'isQrcn');
            if sum(isQrcn) ~= 0
                this_qidx = find(isQrcn);
                this_points_matname = fullfile(sfm_dir, this_locposes.Query_name, 'Points3D.mat');
                load(this_points_matname, 'Points');
                
                XYZ = [[Points.X]; [Points.Y]; [Points.Z]];
                isVisible = false(1, length(Points));
                UV = nan(2, length(Points));
                for jj = 1:1:length(Points)
                    isqimg = Points(jj).imgidx == this_qidx;
                    isVisible(jj) = any(isqimg);
                    if isVisible(jj)
                        UV(1, jj) = Points(jj).u(isqimg);
                        UV(2, jj) = Points(jj).v(isqimg);
                    end
                end
                XYZ = XYZ(:, isVisible);
                UV = UV(:, isVisible);
                
                %reprojection
                XYZ_proj = bsxfun(@plus, camQrcn.R * XYZ, camQrcn.t);
                XY_proj = bsxfun(@rdivide, XYZ_proj(1:2, :), XYZ_proj(3, :));%normalized
                XY2_proj = sum(XY_proj.^2, 1);
                XYd_proj = bsxfun(@times, XY_proj, (ones(size(XY2_proj)) + camQrcn.distortion*XY2_proj));%distorted 
                XYd_proj = camQrcn.fl * XYd_proj;
                
                %reprojection error
                res = UV - XYd_proj;
                err = sqrt(sum(res.^2, 1));
%                 figure();
                plot(sort(err, 'ascend'));
                keyboard;
            end
        end
    end
end

