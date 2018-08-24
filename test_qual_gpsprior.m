clear all;
close all;
[ fnames ] = fn_setup;

%% Comparison
method = struct();

method(1).name = 'densevlad_gpsinit_uncertainty30_neighbor100';
method(1).leg = 'DenseVLAD (NN) GPS R=100';
method(1).matname = 'top1locposes.mat';
method(end+1).name = 'densevlad_gpsinit_uncertainty30_neighbor100_SR';
method(end).leg = 'DenseVLAD (SR) GPS R=100';
method(end).matname = 'top1locposes.mat';

%% Load reference pose
load(fullfile(fnames.gt.dir, fnames.gt.matname));
gtposes_all = poses;

%% Load shortlists
shortlist_dir = fullfile(fnames.outputs.dir, fnames.dataset.name, fnames.outputs.shortlists.name);
shortlist_all = cell(1, length(method));
for ii = 1:1:length(method)
    this_shortlist_matname = fullfile(shortlist_dir, [method(ii).name, '.mat']);
    load(this_shortlist_matname, 'shortlist_str');
    shortlist_all{ii} = shortlist_str;
end

%% Load localization results
results_dir = fullfile(fnames.outputs.dir, fnames.dataset.name, fnames.outputs.locresults.name);
locresults_all = cell(1, length(method));
for ii = 1:1:length(method)
    this_results_matname = fullfile(results_dir, method(ii).name, method(ii).matname);
    load(this_results_matname, 'locposes');
    locresults_all{ii} = locposes;
end

%% for each query
gpsprior_qual_dir = 'gpsprior_qual';

for ii = 1:1:length(gtposes_all)
    this_qname = [gtposes_all(ii).name, '.jpg'];
    
    %evaluate each method
    disterr_method = zeros(1, length(method));
    anglerr_method = zeros(1, length(method));
    for jj = 1:1:length(method)
        isQval = strcmp(this_qname, {locresults_all{jj}.Query_name});
        
        if sum(isQval) == 1
            [disterr_method(jj), anglerr_method(jj)] = p2dist(locresults_all{jj}(isQval).P, gtposes_all(ii).P);
        else
            disterr_method(jj) = inf;
            anglerr_method(jj) = inf;
        end
    end
    anglerr_method = anglerr_method * 180 / pi;
    
    % make qualitatives
    if disterr_method(1) < 50 && disterr_method(2) > 50
        
        h = figure('Visible', 'off');
        set(gcf, 'Position', [0 0 1600 500]);
        
        %query
        Iq = imread(fullfile(fnames.dataset.dir, fnames.dataset.name, fnames.dataset.Qdir, this_qname));
        ultimateSubplot(6, 2, 1, 1, 0.01, 0.05);imshow(Iq);title(sprintf('NN: %.2f [m]', disterr_method(1)));drawnow;
        ultimateSubplot(6, 2, 1, 2, 0.01, 0.05);imshow(Iq);title(sprintf('SR: %.2f [m]', disterr_method(2)));drawnow;
        
        %top5 DB
        for jj = 1:1:length(method)
            isQval = strcmp(this_qname, {shortlist_all{jj}.Query_name});
            this_topNname = shortlist_all{jj}(isQval).topN_name;
            
            for kk = 1:1:5
                this_dbname = fullfile(fnames.dataset.dir, fnames.dataset.name, fnames.dataset.PCIdir, this_topNname{kk});
                ultimateSubplot(6, 2, 1+kk, jj, 0.01, 0.05);
                imshow(imread(this_dbname)); hold on;
                
                %show matches
                [~, this_dbbasename, ~] = fileparts(this_dbname);
                verif_matname = fullfile(fnames.outputs.dir, fnames.dataset.name, fnames.outputs.verification.name, this_qname, [this_dbbasename, '.mat']);
                load(verif_matname, 'flows');
                scatter(flows.xdb, flows.ydb, 50, 'g', 'filled');
                line([flows.xq;  flows.xdb], [flows.yq;  flows.ydb], 'LineWidth', 1.5, 'Color', 'g');
                
                drawnow;
            end
        end
        
        %save figure
        if exist(gpsprior_qual_dir, 'dir') ~= 7
            mkdir(gpsprior_qual_dir)
        end
        h.PaperPositionMode = 'auto';
        saveas(h, fullfile(gpsprior_qual_dir, this_qname));
        
        close(h);
    end
    
    fprintf('%s done. \n', this_qname);
    
end

