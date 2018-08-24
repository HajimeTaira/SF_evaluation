clear all;
close all;

%user define%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
dataset_name = 'SanFrancisco';

%current groundtruth
pass = 'pass0';
gt.dir = sprintf('/datagrid1new/results/%s/torii/SF_annotation_05-merge', dataset_name);
gt.names = num2str(transpose(0:1:802), '%04g');
gt.posematname = sprintf('%s.newrot.inl010.res003.pos010.ori015.fiveposes.mat', pass);
gt.matchesxmatname = 'matchesx.mat';

% locposes_matname = 'outputs/SanFrancisco/localization_results/shortlist_format_2/top1locposes.mat';
% locposes_matname = 'outputs/SanFrancisco/localization_results/shortlist_format_2/localsfmrange25locposes.mat';
% locposes_matname = 'outputs/SanFrancisco/localization_results/shortlist_format_2_SR/top1locposes.mat';
% locposes_matname = 'outputs/SanFrancisco/localization_results/shortlist_format_2_SR/localsfmrange25locposes.mat';
locposes_matname = 'outputs/SanFrancisco/localization_results/shortlist_format_3/top1locposes.mat';

locposes_matpath = 'outputs/SanFrancisco/localization_results';
mode = 1;%1:bow, 2: vlad 3: 2d3d 4: all
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
    method(4).name = 'shortlist_disloc_interplace';
    method(4).leg = 'Disloc (SR^*)';
    method(4).matname = 'top1locposes.mat';
    method(4).marker = '-cx';
    method(5).name = 'shortlist_disloc_interplace';
    method(5).leg = 'Disloc (SR^*-SfM)';
    method(5).matname = 'localsfmrangeInflocposes.mat';
    method(5).marker = '-c.';
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
    method(1).name = 'shortlist_format_2';
    method(1).leg = 'DenseVLAD (NN)';
    method(1).matname = 'top1locposes.mat';
    method(1).marker = '-ko';
    method(end+1).name = 'densevlad_gpsinit_uncertainty0_neighbor50';
    method(end).leg = 'DenseVLAD gps UC0m (NN)';
    method(end).matname = 'top1locposes.mat';
    method(end).marker = '--ko';
%     method(2).name = 'shortlist_format_2_SR';
%     method(2).leg = 'DenseVLAD (SR)';
%     method(2).matname = 'top1locposes.mat';
%     method(2).marker = '-kx';
    method(end+1).name = 'densevlad_gpsinit_uncertainty10_neighbor50';
    method(end).leg = 'DenseVLAD gps UC10m (NN)';
    method(end).matname = 'top1locposes.mat';
    method(end).marker = '--ko';
%     method(4).name = 'densevlad_gpsinit_uncertainty10_neighbor50_SR';
%     method(4).leg = 'DenseVLAD gps UC10m (SR)';
%     method(4).matname = 'top1locposes.mat';
%     method(4).marker = '--kx';
    method(end+1).name = 'densevlad_gpsinit_uncertainty20_neighbor50';
    method(end).leg = 'DenseVLAD gps UC20m (NN)';
    method(end).matname = 'top1locposes.mat';
    method(end).marker = '--go';
%     method(6).name = 'densevlad_gpsinit_uncertainty20_neighbor50_SR';
%     method(6).leg = 'DenseVLAD gps UC20m (SR)';
%     method(6).matname = 'top1locposes.mat';
%     method(6).marker = '--gx';
    method(end+1).name = 'densevlad_gpsinit_uncertainty30_neighbor50';
    method(end).leg = 'DenseVLAD gps UC30m (NN)';
    method(end).matname = 'top1locposes.mat';
    method(end).marker = '--ro';
%     method(8).name = 'densevlad_gpsinit_uncertainty30_neighbor50_SR';
%     method(8).leg = 'DenseVLAD gps UC30m (SR)';
%     method(8).matname = 'top1locposes.mat';
%     method(8).marker = '--rx';
    method(end+1).name = 'densevlad_gpsinit_uncertainty40_neighbor50';
    method(end).leg = 'DenseVLAD gps UC40m (NN)';
    method(end).matname = 'top1locposes.mat';
    method(end).marker = '--mo';
%     method(10).name = 'densevlad_gpsinit_uncertainty40_neighbor50_SR';
%     method(10).leg = 'DenseVLAD gps UC40m (SR)';
%     method(10).matname = 'top1locposes.mat';
%     method(10).marker = '--mx';
    method(end+1).name = 'densevlad_gpsinit_uncertainty50_neighbor50';
    method(end).leg = 'DenseVLAD gps UC50m (NN)';
    method(end).matname = 'top1locposes.mat';
    method(end).marker = '--co';
%     method(12).name = 'densevlad_gpsinit_uncertainty50_neighbor50_SR';
%     method(12).leg = 'DenseVLAD gps UC50m (SR)';
%     method(12).matname = 'top1locposes.mat';
%     method(12).marker = '--cx';
    method(end+1).name = 'densevlad_gpsinit_uncertainty75_neighbor50';
    method(end).leg = 'DenseVLAD gps UC75m (NN)';
    method(end).matname = 'top1locposes.mat';
    method(end).marker = '--kv';
%     method(14).name = 'densevlad_gpsinit_uncertainty75_neighbor50_SR';
%     method(14).leg = 'DenseVLAD gps UC75m (SR)';
%     method(14).matname = 'top1locposes.mat';
%     method(14).marker = '--ks';
    method(end+1).name = 'densevlad_gpsinit_uncertainty100_neighbor50';
    method(end).leg = 'DenseVLAD gps UC100m (NN)';
    method(end).matname = 'top1locposes.mat';
    method(end).marker = '--rv';
%     method(16).name = 'densevlad_gpsinit_uncertainty100_neighbor50_SR';
%     method(16).leg = 'DenseVLAD gps UC100m (SR)';
%     method(16).matname = 'top1locposes.mat';
%     method(16).marker = '--rs';
elseif mode == 6
    method(1).name = 'densevlad_gpsinit_uncertainty30_neighbor10';
    method(1).leg = 'DenseVLAD (NN) radious 10m';
    method(1).matname = 'top1locposes.mat';
    method(1).marker = '--ko';
    method(end+1).name = 'densevlad_gpsinit_uncertainty30_neighbor25';
    method(end).leg = 'DenseVLAD (NN) radious 25m';
    method(end).matname = 'top1locposes.mat';
    method(end).marker = '--ko';
    method(end+1).name = 'densevlad_gpsinit_uncertainty30_neighbor50';
    method(end).leg = 'DenseVLAD (NN) radious 50m';
    method(end).matname = 'top1locposes.mat';
    method(end).marker = '--ko';
    method(end+1).name = 'densevlad_gpsinit_uncertainty30_neighbor75';
    method(end).leg = 'DenseVLAD (NN) radious 75m';
    method(end).matname = 'top1locposes.mat';
    method(end).marker = '--ko';
    method(end+1).name = 'densevlad_gpsinit_uncertainty30_neighbor90';
    method(end).leg = 'DenseVLAD (NN) radious 90m';
    method(end).matname = 'top1locposes.mat';
    method(end).marker = '--ko';
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%load current groundtruth
% [ gtposes_all ] = fn_load_gtposes( gt );
% valuable_idx = logical([gtposes_all.exist]);
% gtposes_all = gtposes_all(valuable_idx);

load('reference_poses/reference_poses_addTM_all_598.mat');
gtposes_all = poses;

%%
% %evaluation
% load(locposes_matname);%locposes
% valuable_flag = ones(1, length(locposes));
% dist_err = zeros(1, length(locposes));
% angl_err = zeros(1, length(locposes));
% for i = 1:1:length(locposes)
%     %find query from valuable gtposes
%     [~, qbasename, ~] = fileparts(locposes(i).Query_name);
%     qidx = strcmp(qbasename, {gtposes_all.name});
%     if sum(qidx) == 0
%         valuable_flag(i) = 0;
%         continue;
%     end
%     thisq_gtpose = gtposes_all(qidx);
%     
%     %evaluation
%     [dist_err(i), angl_err(i)] = p2dist(locposes(i).P, thisq_gtpose.P);
% end
% 
% dist_err = dist_err(logical(valuable_flag));
% angl_err = angl_err(logical(valuable_flag));
% quantile(dist_err, 3)
% quantile(real(angl_err), 3)

% %debug
% colmap_idx = ones(1, length(gtposes_all));
% for i = 1:1:length(gtposes_all)
%     if gtposes_all(i).ps.gidx == 2
%         colmap_idx(i) = 0;
%     end
% end
% colmap_idx = logical(colmap_idx);
% 
% quantile(dist_err(colmap_idx), 3)
% quantile(angl_err(colmap_idx), 3)
% 
% quantile(dist_err(~colmap_idx), 3)
% quantile(angl_err(~colmap_idx), 3)

%% for all localization results
quan_err_all = zeros(length(method), 3);

for ii = 1:1:length(method)
    m = method(ii);
    load(fullfile(locposes_matpath, m.name, m.matname));%locposes
    valuable_flag = ones(1, length(locposes));
    dist_err = inf(1, length(locposes));
    angl_err = inf(1, length(locposes));
    for i = 1:1:length(locposes)
        %find query from valuable gtposes
        [~, qbasename, ~] = fileparts(locposes(i).Query_name);
        qidx = strcmp(qbasename, {gtposes_all.name});
        if sum(qidx) == 0
            valuable_flag(i) = 0;
            continue;
        end
        thisq_gtpose = gtposes_all(qidx);

        %evaluation
        [dist_err(i), angl_err(i)] = p2dist(locposes(i).P, thisq_gtpose.P);
    %     keyboard;
    end
    
    dist_err = dist_err(logical(valuable_flag));
    angl_err = angl_err(logical(valuable_flag))*180/pi;
    
    quan_err_all(ii, :) = quantile(dist_err, 3);
end

%export tex file
tex_txtname = 'quantile_table.tex';
fid = fopen(tex_txtname, 'w');

fprintf(fid, 'Method & 25\\%% & 50\\%% & 75\\%% \\\\ \n');
for ii = 1:1:length(method);
    this_methodname = method(ii).leg;
    this_quantile = quan_err_all(ii, :);
    
    fprintf(fid, '%s & %.2f & %.2f & %.2f \\\\ \n', this_methodname, this_quantile(1), this_quantile(2), this_quantile(3));
end

fclose(fid);





