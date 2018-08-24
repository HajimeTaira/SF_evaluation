clear all;
close all;
set(0,'defaultAxesFontName','times');
set(0,'defaultTextFontName','times');

%input%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
dataset_name = 'SanFrancisco';

%current groundtruth
pass = 'pass0';

%localized poses
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
    method(3).matname = 'localsfmrange25locposes_colmap.mat';
    method(3).marker = '-b.';
    method(4).name = 'shortlist_disloc_interplace_new';
    method(4).leg = 'Disloc (SR^*)';
    method(4).matname = 'top1locposes.mat';
    method(4).marker = '-cx';
    method(5).name = 'shortlist_disloc_interplace_new';
    method(5).leg = 'Disloc (SR^*-SfM)';
    method(5).matname = 'localsfmrange25locposes_colmap.mat';
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
    method(3).matname = 'localsfmrange25locposes_colmap.mat';
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
    method(6).matname = 'localsfmrange25locposes_colmap.mat';
    method(6).marker = '-m.';
elseif mode == 3
    method(1).name = 'shortlist_format_2_SR';
    method(1).leg = 'DenseVLAD (SR-SfM)';
    method(1).matname = 'localsfmrange25locposes_colmap.mat';
    method(1).marker = '-k.';
%     method(2).name = 'shortlist_disloc_interplace';
%     method(2).leg = 'Disloc + inter place (SR-SfM)';
%     method(2).matname = 'localsfmrangeInflocposes.mat';
%     method(2).marker = '-r.';
    method(2).name = 'shortlist_disloc_original_SR';
    method(2).leg = 'Disloc (SR-SfM)';
    method(2).matname = 'localsfmrange25locposes_colmap.mat';
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
    method(3).matname = 'localsfmrange25locposes_colmap.mat';
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
    method(6).matname = 'localsfmrange25locposes_colmap.mat';
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
    method(9).matname = 'localsfmrange25locposes_colmap.mat';
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
    method(2).name = 'shortlist_format_2_SR';
    method(2).leg = 'DenseVLAD (SR)';
    method(2).matname = 'top1locposes.mat';
    method(2).marker = '-kx';
    method(3).name = 'densevlad_gpsinit_uncertainty10_neighbor50';
    method(3).leg = 'DenseVLAD gps US10 (NN)';
    method(3).matname = 'top1locposes.mat';
    method(3).marker = '--ko';
    method(4).name = 'densevlad_gpsinit_uncertainty10_neighbor50_SR';
    method(4).leg = 'DenseVLAD gps US10 (SR)';
    method(4).matname = 'top1locposes.mat';
    method(4).marker = '--kx';
    method(5).name = 'densevlad_gpsinit_uncertainty20_neighbor50';
    method(5).leg = 'DenseVLAD gps US20 (NN)';
    method(5).matname = 'top1locposes.mat';
    method(5).marker = '--go';
    method(6).name = 'densevlad_gpsinit_uncertainty20_neighbor50_SR';
    method(6).leg = 'DenseVLAD gps US20 (SR)';
    method(6).matname = 'top1locposes.mat';
    method(6).marker = '--gx';
    method(7).name = 'densevlad_gpsinit_uncertainty30_neighbor50';
    method(7).leg = 'DenseVLAD gps US30 (NN)';
    method(7).matname = 'top1locposes.mat';
    method(7).marker = '--ro';
    method(8).name = 'densevlad_gpsinit_uncertainty30_neighbor50_SR';
    method(8).leg = 'DenseVLAD gps US30 (SR)';
    method(8).matname = 'top1locposes.mat';
    method(8).marker = '--rx';
    method(9).name = 'densevlad_gpsinit_uncertainty40_neighbor50';
    method(9).leg = 'DenseVLAD gps US40 (NN)';
    method(9).matname = 'top1locposes.mat';
    method(9).marker = '--mo';
    method(10).name = 'densevlad_gpsinit_uncertainty40_neighbor50_SR';
    method(10).leg = 'DenseVLAD gps US40 (SR)';
    method(10).matname = 'top1locposes.mat';
    method(10).marker = '--mx';
    method(11).name = 'densevlad_gpsinit_uncertainty50_neighbor50';
    method(11).leg = 'DenseVLAD gps US50 (NN)';
    method(11).matname = 'top1locposes.mat';
    method(11).marker = '--co';
    method(12).name = 'densevlad_gpsinit_uncertainty50_neighbor50_SR';
    method(12).leg = 'DenseVLAD gps US50 (SR)';
    method(12).matname = 'top1locposes.mat';
    method(12).marker = '--cx';
    method(13).name = 'densevlad_gpsinit_uncertainty75_neighbor50';
    method(13).leg = 'DenseVLAD gps US75 (NN)';
    method(13).matname = 'top1locposes.mat';
    method(13).marker = '--kv';
    method(14).name = 'densevlad_gpsinit_uncertainty75_neighbor50_SR';
    method(14).leg = 'DenseVLAD gps US75 (SR)';
    method(14).matname = 'top1locposes.mat';
    method(14).marker = '--ks';
    method(15).name = 'densevlad_gpsinit_uncertainty100_neighbor50';
    method(15).leg = 'DenseVLAD gps US100 (NN)';
    method(15).matname = 'top1locposes.mat';
    method(15).marker = '--rv';
    method(16).name = 'densevlad_gpsinit_uncertainty100_neighbor50_SR';
    method(16).leg = 'DenseVLAD gps US100 (SR)';
    method(16).matname = 'top1locposes.mat';
    method(16).marker = '--rs';
elseif mode == 6 % disloc confirmation
    method(1).name = 'shortlist_disloc_interplace';
    method(1).leg = 'Disloc (inter-place)';
    method(1).matname = 'top1locposes.mat';
    method(1).marker = '--c';
    method(2).name = 'shortlist_disloc_interplace_new';
    method(2).leg = 'Disloc (inter-place) bugfixed';
    method(2).matname = 'top1locposes.mat';
    method(2).marker = '-cx';
    method(3).name = 'shortlist_disloc_interplace_pop_new';
    method(3).leg = 'Disloc (inter-place pop) bugfixed';
    method(3).matname = 'top1locposes.mat';
    method(3).marker = '-rx';
end

%table
pos_thrs = [5, 10, 15, 20, 25, 30];
ori_thrs = [5, 5, 10, 10, 20, 20];
% ori_thrs = ones(1, 6)*180;

%fig
% error_thr = [0:1:15 20:5:30 ];
error_thr = [0:1:10 15:5:45 ];
max_pos_err = inf;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%
%load current groundtruth
% [ gtposes_all ] = fn_load_gtposes( gt );
% valuable_idx = logical([gtposes_all.exist]);
% gtposes_all = gtposes_all(valuable_idx);
% load('reference_poses/reference_poses_442.mat');%poses
% merge_multiple_refposes;

% load('reference_poses/reference_poses_addTM_all_595.mat');%poses
% load('reference_poses/reference_poses_addTM_all_both_151.mat');%both
load('reference_poses/reference_poses_addTM_all_598.mat');
% load('reference_poses/reference_poses_addTM_all_either_334.mat');
% load('reference_poses/reference_poses_addTM_all_both_142.mat');
gtposes_all = poses;

rate_localized = zeros(length(pos_thrs), length(method));
vefig = figure();hold on;
for ii = 1:1:length(method)
    m = method(ii);
    
    load(fullfile(locposes_matpath, m.name, m.matname));%locposes
    valuable_flag = ones(1, length(locposes));
    dist_err = zeros(1, length(locposes));
    angl_err = zeros(1, length(locposes));
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
    angl_err = angl_err(logical(valuable_flag));
    angl_err = angl_err * 180 / pi;
    
    %evaluation
    for jj = 1:1:length(pos_thrs)
        rate_localized(jj, ii) = sum(dist_err < pos_thrs(jj) & angl_err < ori_thrs(jj)) / length(gtposes_all) * 100;
    end
    
    
    figure(vefig);
    localized_rate = sum( (repmat(angl_err,length(error_thr),1) < repmat(error_thr',1,length(angl_err))) & ...
                        (repmat(dist_err<max_pos_err, length(error_thr), 1))...
                      , 2 )./ length(gtposes_all);%sum(valuable_flag);
    plot(error_thr, localized_rate*100, m.marker, 'LineWidth', 2.0);
    
end

figure(vefig);
xlim([0 45]);ylim([0 100]);grid on;
legend({method.leg}, 'Location', 'southeast', 'FontSize', 17);
xlabel('Orientation threshold [degrees]');ylabel('Correctly localized queries [%]');
set(gca, 'FontSize', 18);
set(gca, 'XTick', 0:5:45);
set(get(gcf,'CurrentAxes'),'Position',[0.15 0.13 0.8 0.8]);
set(gcf,'PaperUnits','Inches','PaperPosition',[0 0 5 5]);
print('-depsc',sprintf('fig%d_posthr%d_%d.eps', mode, max_pos_err, length(poses)),'-r160');
savefig(vefig, sprintf('fig%d_posthr%d_%d.fig', mode, max_pos_err, length(poses)));


% output_txtname = 'evaluation_angular.tex';
% fid = fopen(output_txtname, 'w');
% fprintf(fid, ' & \\multicolumn{6}{c}{Thresholds [meters, degrees]} \\\\ \n');
% fprintf(fid, 'Method ');
% for jj = 1:1:length(pos_thrs)
%     fprintf(fid, '& %d, %d ', pos_thrs(jj), ori_thrs(jj));
% end
% fprintf(fid, '\\\\ \\hline \n');
% 
% for ii = 1:1:length(method)
%     fprintf(fid, '%s ', method(ii).leg);
%     
%     for jj = 1:1:length(pos_thrs)
%         fprintf(fid, '& %.2f ', rate_localized(jj, ii));
%     end
%     
%     fprintf(fid, '\\\\ \n');
% end
% % fprintf(fid, 'Distance & Orientation & \\multicolumn{5}{c}{Methods} \\\\ \n');
% % fprintf(fid, '[meters] & [degrees] ');
% % for ii = 1:1:length(method)
% %     fprintf(fid, '& %s ', method(ii).leg);
% % end
% % fprintf(fid, '\\\\ \\hline \n');
% % 
% % for jj = 1:1:length(pos_thrs)
% %     fprintf(fid, '%d & %d ', pos_thrs(jj), ori_thrs(jj));
% %     for ii = 1:1:length(method)
% %         fprintf(fid, '& %.2f ', rate_localized(jj, ii));
% %     end
% %     fprintf(fid, '\\\\ \n');
% % end
% fclose(fid);


