clear all;
close all;
set(0,'defaultAxesFontName','times');
set(0,'defaultTextFontName','times');

%input%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
dataset_name = 'SanFrancisco';

%current groundtruth
pass = 'pass0';
% gt.dir = sprintf('/datagrid1new/results/%s/torii/SF_annotation_05-merge', dataset_name);%old 442 poses
gt.dir = sprintf('/datagrid1new/results/%s/taira/SF_annotation_05-merge_htsim', dataset_name);%new, 467 poses
gt.names = num2str(transpose(0:1:802), '%04g');
gt.posematname = sprintf('%s.newrot.inl010.res003.pos010.ori015.fiveposes.mat', pass);
gt.matchesxmatname = 'matchesx.mat';

%localized poses
locposes_matpath = 'outputs/SanFrancisco/localization_results';
mode = 1;
if mode == 1
%     method(1).name = 'densevlad_gpsinit_uncertainty50_neighbor10_SR';
%     method(1).leg = 'DenseVLAD (SR) GPS R=10';
%     method(1).matname = 'top1locposes.mat';
%     method(1).marker = '-kx';
    method(1).name = 'densevlad_gpsinit_uncertainty50_neighbor20_SR';
    method(1).leg = 'DenseVLAD (SR) GPS R=20';
    method(1).matname = 'top1locposes.mat';
    method(1).marker = '-kx';
    method(end+1).name = 'densevlad_gpsinit_uncertainty50_neighbor30_SR';
    method(end).leg = 'DenseVLAD (SR) GPS R=30';
    method(end).matname = 'top1locposes.mat';
    method(end).marker = '-kx';
    method(end+1).name = 'densevlad_gpsinit_uncertainty50_neighbor40_SR';
    method(end).leg = 'DenseVLAD (SR) GPS R=40';
    method(end).matname = 'top1locposes.mat';
    method(end).marker = '-kx';
    method(end+1).name = 'densevlad_gpsinit_uncertainty50_neighbor50_SR';
    method(end).leg = 'DenseVLAD (SR) GPS R=50';
    method(end).matname = 'top1locposes.mat';
    method(end).marker = '-kx';
    method(end+1).name = 'densevlad_gpsinit_uncertainty50_neighbor60_SR';
    method(end).leg = 'DenseVLAD (SR) GPS R=60';
    method(end).matname = 'top1locposes.mat';
    method(end).marker = '-kx';
    method(end+1).name = 'densevlad_gpsinit_uncertainty50_neighbor70_SR';
    method(end).leg = 'DenseVLAD (SR) GPS R=70';
    method(end).matname = 'top1locposes.mat';
    method(end).marker = '-kx';
%     method(end+1).name = 'densevlad_gpsinit_uncertainty50_neighbor75_SR';
%     method(end).leg = 'DenseVLAD (SR) GPS R=75';
%     method(end).matname = 'top1locposes.mat';
%     method(end).marker = '-kx';
    method(end+1).name = 'densevlad_gpsinit_uncertainty50_neighbor80_SR';
    method(end).leg = 'DenseVLAD (SR) GPS R=80';
    method(end).matname = 'top1locposes.mat';
    method(end).marker = '-kx';
    method(end+1).name = 'densevlad_gpsinit_uncertainty50_neighbor90_SR';
    method(end).leg = 'DenseVLAD (SR) GPS R=90';
    method(end).matname = 'top1locposes.mat';
    method(end).marker = '-gx';
    method(end+1).name = 'densevlad_gpsinit_uncertainty50_neighbor100_SR';
    method(end).leg = 'DenseVLAD (SR) GPS R=100';
    method(end).matname = 'top1locposes.mat';
    method(end).marker = '-bx';
    method(end+1).name = 'densevlad_gpsinit_uncertainty50_neighbor120_SR';
    method(end).leg = 'DenseVLAD (SR) GPS R=120';
    method(end).matname = 'top1locposes.mat';
    method(end).marker = '-kx';
    method(end+1).name = 'densevlad_gpsinit_uncertainty50_neighbor140_SR';
    method(end).leg = 'DenseVLAD (SR) GPS R=140';
    method(end).matname = 'top1locposes.mat';
    method(end).marker = '-kx';
    method(end+1).name = 'densevlad_gpsinit_uncertainty50_neighbor160_SR';
    method(end).leg = 'DenseVLAD (SR) GPS R=160';
    method(end).matname = 'top1locposes.mat';
    method(end).marker = '-kx';
    method(end+1).name = 'densevlad_gpsinit_uncertainty50_neighbor180_SR';
    method(end).leg = 'DenseVLAD (SR) GPS R=180';
    method(end).matname = 'top1locposes.mat';
    method(end).marker = '-kx';
    method(end+1).name = 'densevlad_gpsinit_uncertainty50_neighbor200_SR';
    method(end).leg = 'DenseVLAD (SR) GPS R=200';
    method(end).matname = 'top1locposes.mat';
    method(end).marker = '-kx';
    method(end+1).name = 'densevlad_gpsinit_uncertainty50_neighbor225_SR';
    method(end).leg = 'DenseVLAD (SR) GPS R=225';
    method(end).matname = 'top1locposes.mat';
    method(end).marker = '-kx';
    method(end+1).name = 'densevlad_gpsinit_uncertainty50_neighbor250_SR';
    method(end).leg = 'DenseVLAD (SR) GPS R=250';
    method(end).matname = 'top1locposes.mat';
    method(end).marker = '-kx';
%     method(end+1).name = 'shortlist_format_2_SR';
%     method(end).leg = 'DenseVLAD (SR)';
%     method(end).matname = 'top1locposes.mat';
%     method(end).marker = '-rx';
    
%     method(end+1).name = 'densevlad_gpsinit_uncertainty50_neighbor5';
%     method(end).leg = 'DenseVLAD (NN) GPS R=5';
%     method(end).matname = 'top1locposes.mat';
%     method(end).marker = '-kx';
%     
%     method(end+1).name = 'densevlad_gpsinit_uncertainty50_neighbor10';
%     method(end).leg = 'DenseVLAD (NN) GPS R=10';
%     method(end).matname = 'top1locposes.mat';
%     method(end).marker = '-kx';
    method(end+1).name = 'densevlad_gpsinit_uncertainty50_neighbor20';
    method(end).leg = 'DenseVLAD (NN) GPS R=20';
    method(end).matname = 'top1locposes.mat';
    method(end).marker = '-kx';
%     method(end+1).name = 'densevlad_gpsinit_uncertainty50_neighbor25';
%     method(end).leg = 'DenseVLAD (NN) GPS R=25';
%     method(end).matname = 'top1locposes.mat';
%     method(end).marker = '-kx';
    method(end+1).name = 'densevlad_gpsinit_uncertainty50_neighbor30';
    method(end).leg = 'DenseVLAD (NN) GPS R=30';
    method(end).matname = 'top1locposes.mat';
    method(end).marker = '-kx';
    method(end+1).name = 'densevlad_gpsinit_uncertainty50_neighbor40';
    method(end).leg = 'DenseVLAD (NN) GPS R=40';
    method(end).matname = 'top1locposes.mat';
    method(end).marker = '-kx';
    method(end+1).name = 'densevlad_gpsinit_uncertainty50_neighbor50';
    method(end).leg = 'DenseVLAD (NN) GPS R=50';
    method(end).matname = 'top1locposes.mat';
    method(end).marker = '-kx';
    method(end+1).name = 'densevlad_gpsinit_uncertainty50_neighbor60';
    method(end).leg = 'DenseVLAD (NN) GPS R=60';
    method(end).matname = 'top1locposes.mat';
    method(end).marker = '-kx';
    method(end+1).name = 'densevlad_gpsinit_uncertainty50_neighbor70';
    method(end).leg = 'DenseVLAD (NN) GPS R=70';
    method(end).matname = 'top1locposes.mat';
    method(end).marker = '-kx';
%     method(end+1).name = 'densevlad_gpsinit_uncertainty50_neighbor75';
%     method(end).leg = 'DenseVLAD (NN) GPS R=75';
%     method(end).matname = 'top1locposes.mat';
%     method(end).marker = '-kx';
    method(end+1).name = 'densevlad_gpsinit_uncertainty50_neighbor80';
    method(end).leg = 'DenseVLAD (NN) GPS R=80';
    method(end).matname = 'top1locposes.mat';
    method(end).marker = '-kx';
    method(end+1).name = 'densevlad_gpsinit_uncertainty50_neighbor90';
    method(end).leg = 'DenseVLAD (NN) GPS R=90';
    method(end).matname = 'top1locposes.mat';
    method(end).marker = '-go';
    method(end+1).name = 'densevlad_gpsinit_uncertainty50_neighbor100';
    method(end).leg = 'DenseVLAD (NN) GPS R=100';
    method(end).matname = 'top1locposes.mat';
    method(end).marker = '-bo';
    method(end+1).name = 'densevlad_gpsinit_uncertainty50_neighbor120';
    method(end).leg = 'DenseVLAD (NN) GPS R=120';
    method(end).matname = 'top1locposes.mat';
    method(end).marker = '-kx';
    method(end+1).name = 'densevlad_gpsinit_uncertainty50_neighbor140';
    method(end).leg = 'DenseVLAD (NN) GPS R=140';
    method(end).matname = 'top1locposes.mat';
    method(end).marker = '-kx';
    method(end+1).name = 'densevlad_gpsinit_uncertainty50_neighbor160';
    method(end).leg = 'DenseVLAD (NN) GPS R=160';
    method(end).matname = 'top1locposes.mat';
    method(end).marker = '-kx';
    method(end+1).name = 'densevlad_gpsinit_uncertainty50_neighbor180';
    method(end).leg = 'DenseVLAD (NN) GPS R=180';
    method(end).matname = 'top1locposes.mat';
    method(end).marker = '-kx';
    method(end+1).name = 'densevlad_gpsinit_uncertainty50_neighbor200';
    method(end).leg = 'DenseVLAD (NN) GPS R=200';
    method(end).matname = 'top1locposes.mat';
    method(end).marker = '-kx';
    method(end+1).name = 'densevlad_gpsinit_uncertainty50_neighbor225';
    method(end).leg = 'DenseVLAD (NN) GPS R=225';
    method(end).matname = 'top1locposes.mat';
    method(end).marker = '-kx';
    method(end+1).name = 'densevlad_gpsinit_uncertainty50_neighbor250';
    method(end).leg = 'DenseVLAD (NN) GPS R=250';
    method(end).matname = 'top1locposes.mat';
    method(end).marker = '-kx';
%     method(end+1).name = 'shortlist_format_2';
%     method(end).leg = 'DenseVLAD (NN)';
%     method(end).matname = 'top1locposes.mat';
%     method(end).marker = '-ro';

%     method(end+1).name = 'densevlad_gpsinit_uncertainty50_neighbor10_SR';
%     method(end).leg = 'DenseVLAD (SR) GPS R=10';
%     method(end).matname = 'localsfmrange25locposes_colmap.mat';
%     method(end).marker = '-kx';
    method(end+1).name = 'densevlad_gpsinit_uncertainty50_neighbor20_SR';
    method(end).leg = 'DenseVLAD (SR) GPS R=20';
    method(end).matname = 'localsfmrange25locposes_colmap.mat';
    method(end).marker = '-kx';
    method(end+1).name = 'densevlad_gpsinit_uncertainty50_neighbor30_SR';
    method(end).leg = 'DenseVLAD (SR) GPS R=30';
    method(end).matname = 'localsfmrange25locposes_colmap.mat';
    method(end).marker = '-kx';
    method(end+1).name = 'densevlad_gpsinit_uncertainty50_neighbor40_SR';
    method(end).leg = 'DenseVLAD (SR) GPS R=40';
    method(end).matname = 'localsfmrange25locposes_colmap.mat';
    method(end).marker = '-kx';
    method(end+1).name = 'densevlad_gpsinit_uncertainty50_neighbor50_SR';
    method(end).leg = 'DenseVLAD (SR) GPS R=50';
    method(end).matname = 'localsfmrange25locposes_colmap.mat';
    method(end).marker = '-kx';
    method(end+1).name = 'densevlad_gpsinit_uncertainty50_neighbor60_SR';
    method(end).leg = 'DenseVLAD (SR) GPS R=60';
    method(end).matname = 'localsfmrange25locposes_colmap.mat';
    method(end).marker = '-kx';
    method(end+1).name = 'densevlad_gpsinit_uncertainty50_neighbor70_SR';
    method(end).leg = 'DenseVLAD (SR) GPS R=70';
    method(end).matname = 'localsfmrange25locposes_colmap.mat';
    method(end).marker = '-kx';
%     method(end+1).name = 'densevlad_gpsinit_uncertainty50_neighbor75_SR';
%     method(end).leg = 'DenseVLAD (SR) GPS R=75';
%     method(end).matname = 'localsfmrange25locposes_colmap.mat';
%     method(end).marker = '-kx';
    method(end+1).name = 'densevlad_gpsinit_uncertainty50_neighbor80_SR';
    method(end).leg = 'DenseVLAD (SR) GPS R=80';
    method(end).matname = 'localsfmrange25locposes_colmap.mat';
    method(end).marker = '-kx';
    method(end+1).name = 'densevlad_gpsinit_uncertainty50_neighbor90_SR';
    method(end).leg = 'DenseVLAD (SR) GPS R=90';
    method(end).matname = 'localsfmrange25locposes_colmap.mat';
    method(end).marker = '-gx';
    method(end+1).name = 'densevlad_gpsinit_uncertainty50_neighbor100_SR';
    method(end).leg = 'DenseVLAD (SR) GPS R=100';
    method(end).matname = 'localsfmrange25locposes_colmap.mat';
    method(end).marker = '-bx';
    method(end+1).name = 'densevlad_gpsinit_uncertainty50_neighbor120_SR';
    method(end).leg = 'DenseVLAD (SR) GPS R=120';
    method(end).matname = 'localsfmrange25locposes_colmap.mat';
    method(end).marker = '-kx';
    method(end+1).name = 'densevlad_gpsinit_uncertainty50_neighbor140_SR';
    method(end).leg = 'DenseVLAD (SR) GPS R=140';
    method(end).matname = 'localsfmrange25locposes_colmap.mat';
    method(end).marker = '-kx';
    method(end+1).name = 'densevlad_gpsinit_uncertainty50_neighbor160_SR';
    method(end).leg = 'DenseVLAD (SR) GPS R=160';
    method(end).matname = 'localsfmrange25locposes_colmap.mat';
    method(end).marker = '-kx';
    method(end+1).name = 'densevlad_gpsinit_uncertainty50_neighbor180_SR';
    method(end).leg = 'DenseVLAD (SR) GPS R=180';
    method(end).matname = 'localsfmrange25locposes_colmap.mat';
    method(end).marker = '-kx';
    method(end+1).name = 'densevlad_gpsinit_uncertainty50_neighbor200_SR';
    method(end).leg = 'DenseVLAD (SR) GPS R=200';
    method(end).matname = 'localsfmrange25locposes_colmap.mat';
    method(end).marker = '-kx';
    method(end+1).name = 'densevlad_gpsinit_uncertainty50_neighbor225_SR';
    method(end).leg = 'DenseVLAD (SR) GPS R=225';
    method(end).matname = 'localsfmrange25locposes_colmap.mat';
    method(end).marker = '-kx';
    method(end+1).name = 'densevlad_gpsinit_uncertainty50_neighbor250_SR';
    method(end).leg = 'DenseVLAD (SR) GPS R=250';
    method(end).matname = 'localsfmrange25locposes_colmap.mat';
    method(end).marker = '-kx';
%     method(end+1).name = 'shortlist_format_2_SR';
%     method(end).leg = 'DenseVLAD (SR)';
%     method(end).matname = 'localsfmrange25locposes_colmap.mat';
%     method(end).marker = '-rx';
elseif mode == 2
    method(1).name = 'shortlist_format_2';
    method(1).leg = 'DenseVLAD (NN)';
    method(1).matname = 'top1locposes.mat';
    method(1).marker = '-ko';
    method(end+1).name = 'shortlist_format_2_SR';
    method(end).leg = 'DenseVLAD (SR)';
    method(end).matname = 'top1locposes.mat';
    method(end).marker = '-kx';
    method(end+1).name = 'shortlist_format_2_SR';
    method(end).leg = 'DenseVLAD (SR-SfM)';
    method(end).matname = 'localsfmrange25locposes_colmap.mat';
    method(end).marker = '-k';
    method(end+1).name = 'densevlad_gpsinit_uncertainty50_neighbor100';
    method(end).leg = 'DenseVLAD (NN+GPS)';
    method(end).matname = 'top1locposes.mat';
    method(end).marker = '-o';
    method(end+1).name = 'densevlad_gpsinit_uncertainty50_neighbor100_SR';
    method(end).leg = 'DenseVLAD (SR+GPS)';
    method(end).matname = 'top1locposes.mat';
    method(end).marker = '-x';
    method(end+1).name = 'densevlad_gpsinit_uncertainty50_neighbor100_SR';
    method(end).leg = 'DenseVLAD (SR-SfM+GPS)';
    method(end).matname = 'localsfmrange25locposes_colmap.mat';
    method(end).marker = '-';
end


%acceptable angular error
max_ang_err = 180;

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
% load('reference_poses/reference_poses_addTM_all_either_336.mat');%either
load('reference_poses/reference_poses_addTM_all_598.mat');
% load('reference_poses/reference_poses_addTM_all_either_334.mat');
% load('reference_poses/reference_poses_addTM_all_both_142.mat');
gtposes_all = poses;


%%
%plot curve for each method
vefig = figure();hold on;%title(sprintf('Angular error < %d', max_ang_err));
% prfig = figure();hold on;
% rocfig = figure();hold on;
error_thr = [0:1:15 20:5:50 ];
recall5m = zeros(1, length(method));
recall10m = zeros(1, length(method));
recall15m = zeros(1, length(method));
recall20m = zeros(1, length(method));
recall30m = zeros(1, length(method));
recall40m = zeros(1, length(method));
recall50m = zeros(1, length(method));
for ii = 1:1:length(method)%m = method
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
%     valuable_flag = valuable_idx;
%     gt_C = [gtposes_all.C];
%     loc_C = [locposes(valuable_idx).C];
%     dist_err = sqrt(sum((gt_C(1:2, :) - loc_C(1:2, :)).^2));
    
%     %(a): varying error threshold
%     figure(vefig);
%     dist_err = dist_err(angl_err<max_ang_err * pi/180);
%     sorted_error = sort(dist_err, 'ascend');
%     localized_ratio = (1:1:length(sorted_error)) / sum(valuable_flag);
%     sparse_idx = 1:20:length(sorted_error);
%     sorted_error = sorted_error(sparse_idx);
%     localized_ratio = localized_ratio(sparse_idx);
%     plot(sorted_error, localized_ratio*100, m.marker, 'LineWidth', 2.0);%, 'MarkerIndices', sparse_idx);
    
%     %(b): varying score threshold
%     label = dist_err < 10;
%     dist = [locposes(logical(valuable_flag)).score].^-1;
%     figure(prfig);
%     plot_PRcurve_ROCcurve_marker( label, dist, prfig, rocfig ,m.marker);

    %(c): old
    figure(vefig);
    localized_rate = sum( (repmat(dist_err,length(error_thr),1) < repmat(error_thr',1,length(dist_err))) & ...
                        (repmat(angl_err<max_ang_err * pi/180, length(error_thr), 1))...
                      , 2 )./ length(gtposes_all);%sum(valuable_flag);
    if mode == 2 && (ii == 4 || ii == 5 || ii == 6)
        plot(error_thr, localized_rate*100, m.marker, 'LineWidth', 2.0, 'MarkerSize', 10, 'Color', [255,140,0]/255);
    else
        plot(error_thr, localized_rate*100, m.marker, 'LineWidth', 2.0, 'MarkerSize', 10);
    end
    
    recall5m(ii) = sum(dist_err < 5 & angl_err<max_ang_err * pi/180) / length(gtposes_all) * 100;
    recall10m(ii) = sum(dist_err < 10 & angl_err<max_ang_err * pi/180) / length(gtposes_all) * 100;
    recall15m(ii) = sum(dist_err < 15 & angl_err<max_ang_err * pi/180) / length(gtposes_all) * 100;
    recall20m(ii) = sum(dist_err < 20 & angl_err<max_ang_err * pi/180) / length(gtposes_all) * 100;
    recall30m(ii) = sum(dist_err < 30 & angl_err<max_ang_err * pi/180) / length(gtposes_all) * 100;
    recall40m(ii) = sum(dist_err < 40 & angl_err<max_ang_err * pi/180) / length(gtposes_all) * 100;
    recall50m(ii) = sum(dist_err < 50 & angl_err<max_ang_err * pi/180) / length(gtposes_all) * 100;
    
end

radius = [20, 30, 40, 50, 60, 70, 80, 90, 100, 120, 140, 160, 180, 200, 225, 250];
gpsfig = figure();
% h05 = plot(radius, recall5m((length(radius)+2):(2*length(radius)+1)), '-b', 'LineWidth', 2.0, 'MarkerSize', 10);hold on;
% h05s = plot(radius, recall5m(1:length(radius)), '--b', 'LineWidth', 2.0, 'MarkerSize', 10);
h10n = plot(radius, recall10m((length(radius)+1):(2*length(radius))), '-bo', 'LineWidth', 2.0, 'MarkerSize', 8);hold on;
% h10s = plot(radius, recall10m(1:length(radius)), '-bx', 'LineWidth', 2.0, 'MarkerSize', 8);
h10r = plot(radius, recall10m((2*length(radius)+1):(3*length(radius))), '-b', 'LineWidth', 2.0, 'MarkerSize', 8);
% h15n = plot(radius, recall15m((length(radius)+1):(2*length(radius))), '-bo', 'LineWidth', 2.0, 'MarkerSize', 8);hold on;
% h15s = plot(radius, recall15m(1:length(radius)), '-bx', 'LineWidth', 2.0, 'MarkerSize', 8);
% h15r = plot(radius, recall15m((2*length(radius)+1):(3*length(radius))), '-b', 'LineWidth', 2.0, 'MarkerSize', 8);
h20n = plot(radius, recall20m((length(radius)+1):(2*length(radius))), '-go', 'LineWidth', 2.0, 'MarkerSize', 8);hold on;
% h20s = plot(radius, recall20m(1:length(radius)), '-gx', 'LineWidth', 2.0, 'MarkerSize', 8);
h20r = plot(radius, recall20m((2*length(radius)+1):(3*length(radius))), '-g', 'LineWidth', 2.0, 'MarkerSize', 8);
h30n = plot(radius, recall30m((length(radius)+1):(2*length(radius))), '-ro', 'LineWidth', 2.0, 'MarkerSize', 8);hold on;
% h30s = plot(radius, recall30m(1:length(radius)), '-rx', 'LineWidth', 2.0, 'MarkerSize', 8);
h30r = plot(radius, recall30m((2*length(radius)+1):(3*length(radius))), '-r', 'LineWidth', 2.0, 'MarkerSize', 8);
% h40n = plot(radius, recall40m((length(radius)+1):(2*length(radius))), '-bo', 'LineWidth', 2.0, 'MarkerSize', 8);hold on;
% % h40s = plot(radius, recall40m(1:length(radius)), '-bx', 'LineWidth', 2.0, 'MarkerSize', 8);
% h40r = plot(radius, recall40m((2*length(radius)+1):(3*length(radius))), '-b', 'LineWidth', 2.0, 'MarkerSize', 8);
% plot(radius, ones(size(radius))*recall50m(2*length(radius)+2), '--b', 'LineWidth', 2.0);
% legtmp = {'dthr=20m', 'dthr=30m', 'dthr=40m', 'dthr=50m'};
% legend([h20, h30, h40, h50], legtmp, ...
%     'Location', 'southeast', 'FontSize', 16);
legtmp = {'DenseVLAD (NN+GPS) ', 'DenseVLAD (SR-SfM+GPS) '};
% legend([h20, h20s, h30, h30s, h40, h40s, h50, h50s], ...
%     [strcat(legtmp, 'thr=20'), strcat(legtmp, 'thr=30'), strcat(legtmp, 'thr=40'), strcat(legtmp, 'thr=50')], ...
%     'Location', 'southeast', 'FontSize', 14);
legend([h10n, h10r, h20n, h20r, h30n, h30r], ...
    [strcat(legtmp, 'thr=10'), strcat(legtmp, 'thr=20'), strcat(legtmp, 'thr=30')], ...
    'Location', 'southeast', 'FontSize', 14);

grid on;
xlim([0 260]); ylim([20 100]);%ylim([70 100]);
xlabel('Radius [meters]'); ylabel('Correctly localized queries [%]');
set(gca, 'FontSize', 17);
set(get(gcf,'CurrentAxes'),'Position',[0.15 0.14 0.8 0.8]);
set(gcf,'PaperUnits','Inches','PaperPosition',[0 0 5 5]);
print(gpsfig, '-depsc','gpsprior.eps','-r160');

% figure(vefig);
% xlim([0 30]);ylim([0 100]);grid on;
% legend({method.leg}, 'Location', 'southeast', 'FontSize', 17);
% xlabel('Distance threshold [meters]');ylabel('Correctly localized queries [%]');
% set(gca, 'FontSize', 18);
% set(gca, 'XTick', 0:5:50);
% set(get(gcf,'CurrentAxes'),'Position',[0.15 0.14 0.8 0.8]);
% set(gcf,'PaperUnits','Inches','PaperPosition',[0 0 5 5]);
% print('-depsc',sprintf('gps_athr%d_%d.eps', max_ang_err, length(poses)),'-r160');
% savefig(vefig, sprintf('gps_athr%d_%d.fig', max_ang_err, length(poses)));
% 
% % figure(prfig);
% % axis([0 1 0 1]);grid on;
% % legend({method.leg});
% % figure(rocfig);close(rocfig);
