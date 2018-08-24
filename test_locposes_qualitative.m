clear all;
close all;
[ fnames ] = fn_setup;
lat30m = (30 / 6378150) / pi * 180;
lng30m = @(lat) (30 / (6378150 * cos(lat * pi / 180))) / pi * 180;

%% comparison
method(1).name = 'shortlist_format_2_SR';
method(1).leg = 'DenseVLAD (SR)';
method(1).matname = 'top1locposes.mat';
method(1).marker = '-kx';
method(2).name = 'shortlist_format_2_SR';
method(2).leg = 'DenseVLAD (SR-SfM)';
method(2).matname = 'localsfmrange25locposes.mat';
method(2).marker = '-k.';
method(3).name = 'shortlist_format_3';
method(3).leg = 'Hyperpoints (3D)';
method(3).matname = 'top1locposes.mat';
method(3).marker = '-g.';

%% load current groundtruth
% merge_multiple_refposes;
% gtposes_all = poses;
load('reference_poses/reference_poses_addTM_all_595.mat');
gtposes_all = poses;

%% load localization results
for ii = 1:1:length(method)
    load(fullfile(fnames.outputs.dir, fnames.dataset.name, fnames.outputs.locresults.name, method(ii).name, method(ii).matname));
    method(ii).results = locposes;
end

%% load top1 names (denseVLAD)
load(fullfile(fnames.outputs.dir, fnames.dataset.name, fnames.outputs.shortlists.name, 'shortlist_format_2_SR.mat'));%shortlist_str

%% make qualitative result for each reference pose
this_qid = '0294';
this_gtid = strcmp({gtposes_all.name}, this_qid);
ii = find(this_gtid);

% for ii = 1:1:length(gtposes_all)
    this_gtpose = gtposes_all(ii);
    this_qname = [this_gtpose.name, '.jpg'];
    
    this_resultspath = fullfile(fnames.outputs.dir, fnames.dataset.name, fnames.outputs.qualitative.name, this_qname);
    if exist(this_resultspath, 'dir') ~= 7
        mkdir(this_resultspath);
    end
    
    Iq = imread(fullfile(fnames.dataset.dir, fnames.dataset.name, fnames.dataset.Qdir, this_qname));
    idx = strcmp(this_qname, {shortlist_str.Query_name});
    Idb = imread(fullfile(fnames.dataset.dir, fnames.dataset.name, fnames.dataset.PCIdir, shortlist_str(idx).topN_name{1}));
    
    
    %localized position
    c_all = nan(3, length(method));
    for jj = 1:1:length(method)
        idx = strcmp(this_qname, {method(jj).results.Query_name});
        c_all(:, jj) = method(jj).results(idx).C;
    end
    
    %plot on the google map
    gt_c = p2c(this_gtpose.P);
    [latq, lngq] = utm2ll(gt_c(1), gt_c(2), 10);
    resultfig = figure();%('visible', 'off');%map
    set(gcf, 'Position', [0 0 640 640/lng30m(latq)*lat30m]);ha1=gca;
    scatter(lngq, latq, 800, 'filled', 'w', 'square', 'LineWidth', 2);hold on;
    h1 = scatter(lngq, latq, 500, 'filled', 'ms', 'LineWidth', 2);hold on;%gt
    
    [latC, lngC] = utm2ll(c_all(1, :), c_all(2, :), 10);
    scatter(lngC(1), latC(1), 800, 'filled', 'w', 'square', 'LineWidth', 2);%top1
    h2 = scatter(lngC(1), latC(1), 500, 'kx', 'LineWidth', 4);%top1
    scatter(lngC(2), latC(2), 800, 'filled', 'w', 'square', 'LineWidth', 2);%sfm
    h3 = scatter(lngC(2), latC(2), 500, 'filled', 'ko', 'LineWidth', 2);%sfm
    scatter(lngC(3), latC(3), 800, 'filled', 'w', 'square', 'LineWidth', 2);%HP
    h4 = scatter(lngC(3), latC(3), 500, 'filled', 'go', 'LineWidth', 2);%HP
        ha1.FontName = 'Times';ha1.FontSize = 16;ha1.XTick = ha1.XTick(1:2:end);ha1.Position = [0 0 1 1];%[0.1 0.1 0.88 0.88];
    axis image off;
    
    xlim([lngq-lng30m(latq), lngq+lng30m(latq)]); ylim([latq-lat30m, latq+lat30m]);
    plot_google_map('Height', 640, 'Width', 640, 'MapType', 'satellite', 'APIkey', 'AIzaSyC2MQqKNOOAgr3dd4CARhiP-P9ggGEkJR8');
    showcenter = [lngq; latq];
    drawnow;
    resultfig.PaperPositionMode = 'auto';
    xlim([lngq-lng30m(latq), lngq+lng30m(latq)]); ylim([latq-lat30m, latq+lat30m]);
    saveas(resultfig, fullfile(this_resultspath, 'map.eps'), 'epsc');
%     close(resultfig);
    drawnow;
    
    resultfig2 = figure('visible', 'off');%query image
    imshow(Iq);set(gcf, 'Position', [0 0 size(Iq, 2) size(Iq, 1)]);
    ha2 = gca;ha2.Position =  [0 0 1 1];
    drawnow;
    saveas(resultfig2, fullfile(this_resultspath, 'query.eps'), 'epsc');
    close(resultfig2);
    drawnow;
    
    
    resultfig3 = figure('visible', 'off');%query image
    imshow(Idb);set(gcf, 'Position', [0 0 size(Idb, 2) size(Idb, 1)]);
    ha3 = gca;ha3.Position =  [0 0 1 1];
    drawnow;
    saveas(resultfig3, fullfile(this_resultspath, 'top1SR.eps'), 'epsc');
    close(resultfig3);
    drawnow;

%     distance = pdist2(gt_c(1:2)', c_all(1:2, :)');
%     if distance(3) > 30 && distance(2) > 30
%         fprintf('%s\n', this_qname);
%     end
    
%     %distance (txt)
%     dist_txtname = fullfile(this_resultspath, 'err.txt');
%     fid = fopen(dist_txtname, 'w');
%     for jj = 1:1:length(method)
%         fprintf(fid, '%s: %d (m)\n', method(jj).leg, distance(jj));
%     end
%     fclose(fid);


%     keyboard;
    
    
% end




