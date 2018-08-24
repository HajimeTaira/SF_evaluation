clear all;
close all;

%input%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
dataset_name = 'SanFrancisco';

%reference models
refmod_dir = '/datagrid1new/outputs/matfiles/shortlists_with_TM/SanFrancisco';


%localized poses
locposes_matpath = 'outputs/SanFrancisco/localization_results';
mode = 6;%1:bow, 2: vlad 3: 2d3d 4: all
if mode == 1
    method(1).name = 'shortlist_disloc_original';
    method(1).leg = 'Disloc (NN)';
    method(1).matname = 'top1locposes.mat';
    method(1).marker = '-bo';
    method(2).name = 'shortlist_disloc_original_SR';
    method(2).leg = 'Disloc (SR)';
    method(2).matname = 'top1locposes.mat';
    method(2).marker = '-bx';
    method(3).name = 'shortlist_disloc_original_SR';
    method(3).leg = 'Disloc (SR-SfM)';
    method(3).matname = 'localsfmrange25locposes.mat';
    method(3).marker = '-b.';
%     method(4).name = 'shortlist_disloc_interplace';
%     method(4).leg = 'Disloc + inter place (SR)';
%     method(4).matname = 'top1locposes.mat';
%     method(4).marker = '-ro';
%     method(5).name = 'shortlist_disloc_interplace';
%     method(5).leg = 'Disloc + inter place (SR-SfM)';
%     method(5).matname = 'localsfmrangeInflocposes.mat';
%     method(5).marker = '-r.';
elseif mode == 2
    method(1).name = 'shortlist_format_2';
    method(1).leg = 'DenseVLAD (NN)';
    method(1).matname = 'top1locposes.mat';
    method(1).marker = '-ko';
    % method(2).name = 'shortlist_format_2';
    % method(2).leg = 'DenseVLAD (NN-SfM)';
    % method(2).matname = 'localsfmrange25locposes.mat';
    % method(2).marker = '-k^';
    method(2).name = 'shortlist_format_2_SR';
    method(2).leg = 'DenseVLAD (SR)';
    method(2).matname = 'top1locposes.mat';
    method(2).marker = '-kx';
    method(3).name = 'shortlist_format_2_SR';
    method(3).leg = 'DenseVLAD (SR-SfM)';
    method(3).matname = 'localsfmrange25locposes.mat';
    method(3).marker = '-k.';
    method(4).name = 'shortlist_netvlad';
    method(4).leg = 'NetVLAD (NN)';
    method(4).matname = 'top1locposes.mat';
    method(4).marker = '-mo';
    method(5).name = 'shortlist_netvlad_SR';
    method(5).leg = 'NetVLAD (SR)';
    method(5).matname = 'top1locposes.mat';
    method(5).marker = '-mx';
    method(6).name = 'shortlist_netvlad_SR';
    method(6).leg = 'NetVLAD (SR-SfM)';
    method(6).matname = 'localsfmrange25locposes.mat';
    method(6).marker = '-m.';
elseif mode == 3
    method(1).name = 'shortlist_format_2_SR';
    method(1).leg = 'DenseVLAD (SR-SfM)';
    method(1).matname = 'localsfmrange25locposes.mat';
    method(1).marker = '-k.';
%     method(2).name = 'shortlist_disloc_interplace';
%     method(2).leg = 'Disloc + inter place (SR-SfM)';
%     method(2).matname = 'localsfmrangeInflocposes.mat';
%     method(2).marker = '-r.';
    method(2).name = 'shortlist_disloc_original_SR';
    method(2).leg = 'Disloc (SR-SfM)';
    method(2).matname = 'localsfmrange25locposes.mat';
    method(2).marker = '-b.';
    method(3).name = 'shortlist_format_3';
    method(3).leg = 'Hyperpoints (3D)';
    method(3).matname = 'top1locposes.mat';
    method(3).marker = '-g.';
    method(4).name = 'shortlist_cpv_w_gps';
    method(4).leg = 'CPV w/ GPS (3D)';
    method(4).matname = 'top1locposes.mat';
    method(4).marker = '-r.';
    method(5).name = 'shortlist_cpv_wo_gps';
    method(5).leg = 'CPV w/o GPS (3D)';
    method(5).matname = 'top1locposes.mat';
    method(5).marker = '-ro';
elseif mode == 4
    method(1).name = 'shortlist_disloc_original';
    method(1).leg = 'Disloc (NN)';
    method(1).matname = 'top1locposes.mat';
    method(1).marker = '-bo';
    method(2).name = 'shortlist_disloc_original_SR';
    method(2).leg = 'Disloc (SR)';
    method(2).matname = 'top1locposes.mat';
    method(2).marker = '-bx';
    method(3).name = 'shortlist_disloc_original_SR';
    method(3).leg = 'Disloc (SR-SfM)';
    method(3).matname = 'localsfmrange25locposes.mat';
    method(3).marker = '-b.';
    method(4).name = 'shortlist_format_2';
    method(4).leg = 'DenseVLAD (NN)';
    method(4).matname = 'top1locposes.mat';
    method(4).marker = '-ko';
    method(5).name = 'shortlist_format_2_SR';
    method(5).leg = 'DenseVLAD (SR)';
    method(5).matname = 'top1locposes.mat';
    method(5).marker = '-kx';
    method(6).name = 'shortlist_format_2_SR';
    method(6).leg = 'DenseVLAD (SR-SfM)';
    method(6).matname = 'localsfmrange25locposes.mat';
    method(6).marker = '-k.';
    method(7).name = 'shortlist_netvlad';
    method(7).leg = 'NetVLAD (NN)';
    method(7).matname = 'top1locposes.mat';
    method(7).marker = '-mo';
    method(8).name = 'shortlist_netvlad_SR';
    method(8).leg = 'NetVLAD (SR)';
    method(8).matname = 'top1locposes.mat';
    method(8).marker = '-mx';
    method(9).name = 'shortlist_netvlad_SR';
    method(9).leg = 'NetVLAD (SR-SfM)';
    method(9).matname = 'localsfmrange25locposes.mat';
    method(9).marker = '-m.';
    method(10).name = 'shortlist_format_3';
    method(10).leg = 'Hyperpoints (3D)';
    method(10).matname = 'top1locposes.mat';
    method(10).marker = '-g.';
    method(11).name = 'shortlist_cpv_w_gps';
    method(11).leg = 'CPV w/ GPS (3D)';
    method(11).matname = 'top1locposes.mat';
    method(11).marker = '-r.';
    method(12).name = 'shortlist_cpv_wo_gps';
    method(12).leg = 'CPV w/o GPS (3D)';
    method(12).matname = 'top1locposes.mat';
    method(12).marker = '-ro';
elseif mode == 5
    method(1).name = 'shortlist_disloc_original_SR';
    method(1).leg = 'Disloc (SR)';
    method(1).matname = 'top1locposes.mat';
    method(1).marker = '-bx';
    method(2).name = 'shortlist_disloc_original_SR';
    method(2).leg = 'Disloc (SR-SfM)';
    method(2).matname = 'localsfmrange25locposes.mat';
    method(2).marker = '-b.';
    method(3).name = 'shortlist_format_3';
    method(3).leg = 'Hyperpoints (3D)';
    method(3).matname = 'top1locposes.mat';
    method(3).marker = '-g.';
elseif mode == 6
    method(1).name = 'shortlist_format_2_SR';
    method(1).leg = 'DenseVLAD (SR)';
    method(1).matname = 'top1locposes.mat';
    method(1).marker = '-kx';
    method(2).name = 'shortlist_format_2_SR';
    method(2).leg = 'DenseVLAD (SR-SfM)';
    method(2).matname = 'localsfmrange25locposes_colmap.mat';
    method(2).marker = '-k.';
    method(3).name = 'shortlist_disloc_original_SR';
    method(3).leg = 'Disloc (SR)';
    method(3).matname = 'top1locposes.mat';
    method(3).marker = '-bx';
    method(4).name = 'shortlist_disloc_original_SR';
    method(4).leg = 'Disloc (SR-SfM)';
    method(4).matname = 'localsfmrange25locposes_colmap.mat';
    method(4).marker = '-b.';
    method(5).name = 'shortlist_format_3';
    method(5).leg = 'Hyperpoints (3D)';
    method(5).matname = 'top1locposes.mat';
    method(5).marker = '-g.';
    method(6).name = 'shortlist_cpv_w_gps';
    method(6).leg = 'CPV w/ GPS (3D)';
    method(6).matname = 'top1locposes.mat';
    method(6).marker = '-r.';
    method(7).name = 'shortlist_cpv_wo_gps';
    method(7).leg = 'CPV w/o GPS (3D)';
    method(7).matname = 'top1locposes.mat';
    method(7).marker = '-ro';
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%load reference poses
load('reference_poses/reference_poses_addTM_all_598.mat', 'poses', 'recon_method');

%query intrinsics
read_query_list; %QList

mean_reproj_err_all = cell(1, length(method));
%for each method
for ii = 1:1:length(method)
    load(fullfile(locposes_matpath, method(ii).name, method(ii).matname));%locposes
    valuable_flag = true(1, length(locposes));
    
    this_output_dir = fullfile('outputs/SanFrancisco/reprojection_colmap', method(ii).name, method(ii).matname);
    if exist(this_output_dir, 'dir') ~= 7
        mkdir(this_output_dir);
    end
    
    this_mean_reproj_err =inf(1, length(locposes));
    for jj = 1:1:length(locposes)
        this_locpose = locposes(jj);
        this_qname = this_locpose.Query_name;
        [~, this_qbasename, ~] = fileparts(this_qname);
        
        %find reference pose
        refidx = strcmp(this_qbasename, {poses.name});
        if sum(refidx) == 0
            valuable_flag(jj) = false;
            continue;
        end
        this_recon_method = recon_method{refidx};
        
        this_output_matname = fullfile(this_output_dir, [this_qname, '.mat']);
        if exist(this_output_matname, 'file') ~= 2
        
            %find intrinsic
            KQrcn = QList(strcmp(this_qname, {QList.name})).K;
            Iqsize = size(imread(fullfile('/datagrid5new/SanFrancisco/Query/BuildingQueryImagesCartoIDCorrected-Upright', this_qname)));

            %load referenced local reconstruction
            corr_dir = 'outputs/SanFrancisco/reprojection/2d3dcorrespondences';
            corr_matname = fullfile(corr_dir, [this_qname, '.2d3d.mat']);
            if exist(corr_matname, 'file') ~= 2
                this_refmod_dir = fullfile(refmod_dir, this_qname);
                if strcmp(this_recon_method, 'colmap')
                    load(fullfile(this_refmod_dir, 'query_colmap.mat'), 'imQrcn');
                    load(fullfile(this_refmod_dir, 'Points3D_colmap.mat'), 'Points_colmap');
                    %find 2D-3D correspondences
                    iskpcorr3D = imQrcn.kp(3, :) ~= -1;
                    UV = imQrcn.kp(1:2, iskpcorr3D);
                    pointsid = imQrcn.kp(3, iskpcorr3D);
                    XYZ = zeros(3, length(pointsid));
                    for kk = 1:1:length(pointsid)
                        XYZ(:, kk) = Points_colmap([Points_colmap.points3d_id] == pointsid(kk)).X;
                    end

                    %transform to UTM coordinate
                    load(fullfile(this_refmod_dir, 'colmap2UTMtrans_PCITM.mat'), 'Rout', 'ceout', 'tout');
                    XYZ = bsxfun(@plus, ceout * Rout * XYZ, tout);

                else%vsfm
                    load(fullfile(this_refmod_dir, 'query_vsfm.mat'), 'isQrcn');
                    load(fullfile(this_refmod_dir, 'Points3D_vsfm.mat'), 'Points_vsfm');
                    this_qidx = find(isQrcn);
                    
                    %find 2D-3D correspondences
                    XYZ = Points_vsfm.X(1:3, :);
                    isVisible = false(1, size(XYZ, 2));
                    UV = nan(2, size(XYZ, 2));
                    for kk = 1:1:size(XYZ, 2)
                        isqimg = Points_vsfm.x{kk}(1, :) == this_qidx;
                        isVisible(kk) = any(isqimg);
                        if isVisible(kk)
                            UV(1, kk) = Points_vsfm.x{kk}(3, isqimg);
                            UV(2, kk) = Points_vsfm.x{kk}(4, isqimg);
                        end
                    end
                    XYZ = XYZ(:, isVisible);
                    UV = UV(:, isVisible);
                    UV = bsxfun(@plus, UV, [Iqsize(2)/2.0; Iqsize(1)/2.0]);

                    %transform to UTM coordinate
                    load(fullfile(this_refmod_dir, 'vsfm2UTMtrans_PCITM.mat'), 'Rout', 'ceout', 'tout');
                    XYZ = bsxfun(@plus, ceout * Rout * XYZ, tout);
                    
                end
                
                if exist(corr_dir, 'dir') ~= 7
                    mkdir(corr_dir);
                end
                save('-v6', corr_matname, 'XYZ', 'UV');
            else
                load(corr_matname, 'XYZ', 'UV');
            end
            
            

            %reprojection
            XYZ_proj = KQrcn * this_locpose.P * [XYZ; ones(1, size(XYZ, 2))];
            XY_proj = bsxfun(@rdivide, XYZ_proj(1:2, :), XYZ_proj(3, :));

            res = UV - XY_proj;
            err = sqrt(sum(res.^2, 1));
            
            %save results
            save('-v6', this_output_matname, 'res', 'err');
        else
            load(this_output_matname, 'res', 'err');
        end
        
        this_mean_reproj_err(jj) = mean(err);
        
%         figure();
%         imshow(imread(fullfile('/datagrid5new/SanFrancisco/Query/BuildingQueryImagesCartoIDCorrected-Upright', this_qname)));hold on;
%         scatter(UV(1, :), UV(2, :), 'filled');
%         scatter(XY_proj(1, :), XY_proj(2, :), 'filled');
%         drawnow;
%         
%         figure();
%         plot(sort(err));
%         keyboard;
        
        fprintf('method %d /%d query %d / %d done. \n', ii, length(method), jj, length(locposes));
    end
    
    this_mean_reproj_err = this_mean_reproj_err(valuable_flag);
    mean_reproj_err_all{ii} = this_mean_reproj_err;
end

%table
table_texname = 'table_repro.tex';
fid = fopen(table_texname, 'w');
fprintf(fid, 'method & 25\\%% & 50\\%% & 75\\%% \\\\ \n');
for ii = 1:1:length(method)
%     size(mean_reproj_err_all{ii})
    this_methodname = method(ii).leg;
    this_quantile = quantile(mean_reproj_err_all{ii}, [0.25, 0.5, 0.75]);
    
    fprintf(fid, '%s & %.2f & %.2f & %.2f \\\\ \n', this_methodname, this_quantile(1), this_quantile(2), this_quantile(3));
end

%% table for selected query
% % imgids = {'0112', '0645', '0172', '0544', '0699'};%sfmaccurate
% imgids = {'0128', '0199', '0002', '0000', '0431'};%3daccurate
% % imgids = {'0007', '0032', '0516', '0760', '0062'};%bothaccurate
% % imgids = {'0239', '0075', '0211', '0455', '0711'};%sfmrelevant
% % imgids = {'0267', '0298', '0476', '0379', '0802'};%3drelevant
% 
% for ii = 1:1:length(imgids)
%     this_imgid = imgids{ii};
%     this_qname = [this_imgid, '.jpg'];
%     
%     %load image
%     Iq = imread(fullfile('/datagrid5new/SanFrancisco/Query/BuildingQueryImagesCartoIDCorrected-Upright', this_qname));
%     
%     %load intrinsic
%     KQrcn = QList(strcmp(this_qname, {QList.name})).K;
%     
%     %load 2D-3D correspondences
%     corr_dir = 'outputs/SanFrancisco/reprojection/2d3dcorrespondences';
%     corr_matname = fullfile(corr_dir, [this_qname, '.2d3d.mat']);
%     load(corr_matname, 'XYZ', 'UV');
%     
%     for jj = 1:1:length(method)
%         this_method = method(jj);
%         load(fullfile(locposes_matpath, this_method.name, this_method.matname));%locposes
%         this_locpose = locposes(strcmp({locposes.Query_name}, this_qname));
%         
%         %reprojection
%         XYZ_proj = KQrcn * this_locpose.P * [XYZ; ones(1, size(XYZ, 2))];
%         XY_proj = bsxfun(@rdivide, XYZ_proj(1:2, :), XYZ_proj(3, :));
%         
%         %plot
%         Iqsize = size(Iq);
%         h1 = figure('Visible', 'off');
%         set(gcf, 'Position', [0 0 800 800/Iqsize(2)*Iqsize(1)]);
%         imshow(Iq);hold on;
%         set(gcf, 'Position', [0 0 800 800/Iqsize(2)*Iqsize(1)]);
%         set(gca, 'Position', [0 0 1 1]);
%         scatter(UV(1, :), UV(2, :), 80, 'b', 'filled');
%         scatter(XY_proj(1, :), XY_proj(2, :), 80, 'r', 'filled');
%         drawnow;
% %         keyboard;
%         
%         %output
%         output_dir = 'PAMI_figs';
%         output_imgname = fullfile(output_dir, sprintf('method%d_%s_reproj.png', jj, this_imgid));
%         h1.PaperPositionMode = 'auto';
%         saveas(h1, output_imgname);
%         close(h1);
%     end
% end
% 
% %table format
% table_texname = 'qualitative_table.tex';
% fid = fopen(table_texname, 'w');
% 
% for ii = 2:1:length(method)
%     fprintf(fid, '%s \n', method(ii).leg);
%     
%     for jj = 1:1:length(imgids)
%         fprintf(fid, '& \\includegraphics[width=0.14\\linewidth]{figs_qualitative_relPCI/method%d_%s_reproj.pdf} \n', ii, imgids{jj});
%     end
%     fprintf(fid, '\\\\ \\hline \n');
% end
% 
% fclose(fid);








