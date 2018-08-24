clear all;
close all;
[ fnames ] = fn_setup;
lat30m = (30 / 6378150) / pi * 180;
lng30m = @(lat) (30 / (6378150 * cos(lat * pi / 180))) / pi * 180;

%% comparison
% method(1).name = 'shortlist_format_2_SR';
% method(1).leg = 'DenseVLAD (SR)';
% method(1).matname = 'top1locposes.mat';
% method(1).marker = '-kx';
% method(2).name = 'shortlist_format_2_SR';
% method(2).leg = 'DenseVLAD (SR-SfM)';
% method(2).matname = 'localsfmrange25locposes.mat';
% method(2).marker = '-k.';
% method(1).name = 'shortlist_disloc_original_SR';
% method(1).leg = 'Disloc (SR)';
% method(1).matname = 'top1locposes.mat';
% method(1).marker = '-bx';
method(1).name = 'shortlist_disloc_original_SR';
method(1).leg = 'Disloc (SR-SfM)';
method(1).matname = 'localsfmrange25locposes.mat';
method(1).marker = '-b.';
method(2).name = 'shortlist_format_3';
method(2).leg = 'Hyperpoints (3D)';
method(2).matname = 'top1locposes.mat';
method(2).marker = '-g.';

%% load current groundtruth
% merge_multiple_refposes;
% gtposes_all = poses;
load('reference_poses/reference_poses_addTM_all_598.mat');
gtposes_all = poses;

%query intrinsics
read_query_list; %QList


%% load PCI names
PCInames_matname = '/datagrid5new/SanFrancisco/PCIs_dbfnames.mat';
load(PCInames_matname, 'dbfnames');
dbfbase = cell(size(dbfnames));
dbfbase_matname = 'dbfbasenames.mat';
if exist(dbfbase_matname, 'file') ~= 2
    for ii = 1:1:length(dbfnames)
        this_split = strsplit(dbfnames{ii}, '/');
        dbfbase{ii} = [this_split{2}, '.jpg'];
    end
    save(dbfbase_matname, 'dbfbase');
else
    load(dbfbase_matname, 'dbfbase');
end

%% load localization results
for ii = 1:1:length(method)
    load(fullfile(fnames.outputs.dir, fnames.dataset.name, fnames.outputs.locresults.name, method(ii).name, method(ii).matname));
    method(ii).results = locposes;
end

%% make qualitative result for each reference pose
% for ii = 1:1:length(gtposes_all)
%     this_gtpose = gtposes_all(ii);
%     this_qname = [this_gtpose.name, '.jpg'];
%     
%     %load relevant image information
%     ann_matname = fullfile('/datagrid1new/results/SanFrancisco/torii/SF_annotation_05-merge', this_gtpose.name, 'matchesx.mat');
%     load(ann_matname);
%     relPCIimgname = pd.dn{pd.ix};
%     this_relPCIidx = strcmp(relPCIimgname, dbfbase);
%     
%     %images
%     Iqname = fullfile(fnames.dataset.dir, fnames.dataset.name, fnames.dataset.Qdir, this_qname);
%     Iq = imread(Iqname);
%     Irelname = fullfile(fnames.dataset.dir, fnames.dataset.name, fnames.dataset.PCIdir, [dbfnames{this_relPCIidx}, '.jpg']);
%     Irel = imread(Irelname);
%     
%     %evaluation
%     refpos = p2c(this_gtpose.P);
%     [ gpsinfos ] = loadgps_from_davidchen_imgname( Irelname );
%     [UTME, UTMN] = ll2utm(gpsinfos.lat, gpsinfos.lng);
%     relPCIpos = [UTME; UTMN];
%     relPCI_dist = sqrt(sum((refpos(1:2) - relPCIpos).^2));
%     
%     poserr = zeros(1, length(method));
%     orierr = zeros(1, length(method));
%     for jj = 1:1:length(method)
%         locid = strcmp(this_qname, {method(jj).results.Query_name});
%         if sum(locid) ~= 0 && ~isnan(method(jj).results(locid).P(1))
%             [poserr(jj), orierr(jj)] = p2dist(this_gtpose.P, method(jj).results(locid).P);
%         else
%             poserr(jj) = inf;
%             orierr(jj) = inf;
%         end
%     end
%     
%     %make qualitative (query, relevant PCI)
%     h1 = figure('Visible', 'off');set(h1, 'Position', [0 0 350 900]);
%     ultimateSubplot( 1, 3, 1, 1, 0.01, 0.05 );
%     imshow(Iq); hold on;title('Query');
%     ultimateSubplot( 1, 3, 1, 2, 0.01, 0.05 );
%     imshow(Irel); hold on; title(sprintf('Rel. PCI dist.=%f m', relPCI_dist));
%     drawnow;
%     ultimateSubplot( 1, 3, 1, 3, 0.01, 0.05 );
%     quant_image = uint8(ones(480, 640, 3)*255);
%     quant_image = insertText(quant_image, [320, 80; 320, 240], ...; 320, 400], ...
%         {sprintf('%s: %f[m], %f[deg] \n', method(1).leg, poserr(1), orierr(1)), ...
%         sprintf('%s: %f[m], %f[deg] \n', method(2).leg, poserr(2), orierr(2)) ...
% %         sprintf('%s: %f[m], %f[deg] \n', method(3).leg, poserr(3), orierr(3))
%         }, ...
%         'FontSize', 24, 'AnchorPoint', 'Center', 'BoxColor', 'white');
%     imshow(quant_image);
%     drawnow;
%     
%     %grouping
%     if poserr(1) < 5 && poserr(2) < 5 % both srsfm and 3d accurate
%         description = 'bothaccurate';
%     elseif poserr(1) < 5 && poserr(2) >= 5 %srsfm accurate while 3d not
%         description = 'sfmaccurate';
%     elseif poserr(2) < 5 && poserr(1) >= 5 %3d accurate while srsfm not
%         description = '3daccurate';
%     elseif poserr(1) < 30 && poserr(2) < 30 %both relevant
%         description = 'bothrelevant';
%     elseif poserr(1) < 30 && poserr(2) >= 30 %srsfm relevant while 3d not
%         description = 'sfmrelevant';
%     elseif poserr(2) < 30 && poserr(1) >= 30 %3d relevant while srsfm not
%         description = '3drelevant';
%     else % both inaccurate
%         description = 'bothfailed';
%     end
%     
%     %save results
%     this_results_dir = fullfile(fnames.outputs.dir, fnames.dataset.name, 'qualitatives_new', description);
%     if exist(this_results_dir, 'dir') ~= 7
%         mkdir(this_results_dir);
%     end
%     this_results_imgname = fullfile(this_results_dir, this_qname);
%     h1.PaperPositionMode = 'auto';
%     saveas(h1, this_results_imgname);
%     close(h1);
%     
% %     %save quant.
% %     this_results_txtname = fullfile(this_results_dir, [this_qname, '.txt']);
% %     fid = fopen(this_results_txtname, 'w');
% %     fprintf(fid, 'Query: %s \n', this_qname);
% %     fprintf(fid, 'Rel. DB: %s (dist=%f[m]) \n', [dbfnames{this_relPCIidx}, '.jpg'], relPCI_dist);
% %     for jj = 1:1:length(method)
% %         fprintf(fid, 'Retrieval error %s: (pos, ori) = %f[m], %f[deg] \n', method(jj).leg, poserr(jj), orierr(jj)*180/pi);
% %     end
% %     fclose(fid);
%     
%     fprintf('%s (%d/%d) done. \n', this_qname, ii, length(gtposes_all));
%     
% end


%% selected queries
% % imgids = {'0112', '0161', '0172', '0699', '0544'};%sfmaccurate
% % export_dir = fullfile(fnames.outputs.dir, fnames.dataset.name, 'qualitatives_new', 'PAMI_qual_sfmaccurate');
% % imgids = {'0000', '0002', '0708', '0199', '0128'};%3daccurate
% % export_dir = fullfile(fnames.outputs.dir, fnames.dataset.name, 'qualitatives_new', 'PAMI_qual_3daccurate');
% % imgids = {'0007', '0032', '0766', '0760', '0516'};%bothaccurate
% % export_dir = fullfile(fnames.outputs.dir, fnames.dataset.name, 'qualitatives_new', 'PAMI_qual_bothaccurate');
% % imgids = {'0075', '0137', '0211', '0457', '0711'};%sfmrelevant
% % export_dir = fullfile(fnames.outputs.dir, fnames.dataset.name, 'qualitatives_new', 'PAMI_qual_sfmrelevant');
% imgids = {'0267', '0298', '0476', '0485', '0802'};%3drelevant
% export_dir = fullfile(fnames.outputs.dir, fnames.dataset.name, 'qualitatives_new', 'PAMI_qual_3drelevant');
% 
% if exist(export_dir, 'dir') ~= 7
%     mkdir(export_dir);
% end
% for ii = 1:1:length(imgids)
%     this_qid = imgids{ii};
%     
%     %1. query
%     this_qname = [this_qid, '.jpg'];
%     copyfile(fullfile(fnames.dataset.dir, fnames.dataset.name, fnames.dataset.Qdir, this_qname), ...
%         fullfile(export_dir, this_qname));
%     
%     %2. relevant PCI
%     ann_matname = fullfile('/datagrid1new/results/SanFrancisco/torii/SF_annotation_05-merge', this_qid, 'matchesx.mat');
%     load(ann_matname);relPCIimgname = pd.dn{pd.ix};
%     this_relPCIidx = strcmp(relPCIimgname, dbfbase);
%     copyfile(fullfile(fnames.dataset.dir, fnames.dataset.name, fnames.dataset.PCIdir, [dbfnames{this_relPCIidx}, '.jpg']), ...
%         fullfile(export_dir, [this_qid, '_relPCI.jpg']));
% end

imgids = {'0426', '0783', '0172', '0544', '0699'};%sfmaccurate
imgids = {'0128', '0199', '0002', '0000', '0431'};%3daccurate
imgids = {'0007', '0032', '0516', '0760', '0062'};%bothaccurate
imgids = {'0239', '0075', '0211', '0455', '0711'};%sfmrelevant
imgids = {'0267', '0260', '0067', '0379', '0335'};%3drelevant

poserr = zeros(length(method), length(imgids));
orierr = zeros(length(method), length(imgids));
for ii = 1:1:length(imgids)
    this_imgids = imgids{ii};
    this_qname = [this_imgids, '.jpg'];
    
    %load image
    Iq = imread(fullfile('/datagrid5new/SanFrancisco/Query/BuildingQueryImagesCartoIDCorrected-Upright', this_qname));
    
    %load intrinsic
    KQrcn = QList(strcmp(this_qname, {QList.name})).K;
    
    %load 2D-3D correspondences
    corr_dir = 'outputs/SanFrancisco/reprojection/2d3dcorrespondences';
    corr_matname = fullfile(corr_dir, [this_qname, '.2d3d.mat']);
    load(corr_matname, 'XYZ', 'UV');
    
    %groundtruth
    this_gtpose = gtposes_all(strcmp(this_imgids, {gtposes_all.name}));
    
    for jj = 1:1:length(method)
        this_method = method(jj);
        
        %estimation
        this_pose = this_method.results(strcmp([this_imgids, '.jpg'], {this_method.results.Query_name}));
        
        %a. quantitative
        [poserr(jj, ii), orierr(jj, ii)] = p2dist(this_gtpose.P, this_pose.P);
        
        %b. qualitative
        %reprojection
        XYZ_proj = KQrcn * this_pose.P * [XYZ; ones(1, size(XYZ, 2))];
        XY_proj = bsxfun(@rdivide, XYZ_proj(1:2, :), XYZ_proj(3, :));
        
        %plot
        Iqsize = size(Iq);
        h1 = figure('Visible', 'off');
        set(gcf, 'Position', [0 0 800 800/Iqsize(2)*Iqsize(1)]);
        imshow(Iq);hold on;
        set(gcf, 'Position', [0 0 800 800/Iqsize(2)*Iqsize(1)]);
        set(gca, 'Position', [0 0 1 1]);
        scatter(UV(1, :), UV(2, :), 80, 'b', 'filled');
        scatter(XY_proj(1, :), XY_proj(2, :), 80, 'r', 'filled');
        drawnow;
        
        %output
        output_dir = 'PAMI_figs';
        output_imgname = fullfile(output_dir, sprintf('method%d_%s_reproj.png', jj, this_imgids));
        h1.PaperPositionMode = 'auto';
        saveas(h1, output_imgname);
        close(h1);
        
        %relevant PCI
        ann_matname = fullfile('/datagrid1new/results/SanFrancisco/torii/SF_annotation_05-merge', this_imgids, 'matchesx.mat');
        load(ann_matname);relPCIimgname = pd.dn{pd.ix};
        this_relPCIidx = strcmp(relPCIimgname, dbfbase);
        copyfile(fullfile(fnames.dataset.dir, fnames.dataset.name, fnames.dataset.PCIdir, [dbfnames{this_relPCIidx}, '.jpg']), ...
            fullfile(output_dir, [this_imgids, '_relPCI.jpg']));
        
        
    end
    
    
    
end

%export tex
tex_name = 'qualitative_table.tex';
fid = fopen(tex_name, 'w');
for ii = 1:1:length(method)
    
    fprintf(fid, '~ & ~ & ~ & ~ & ~ & ~ \\\\ [-4pt] \n');
    
    for jj = 1:1:length(imgids)
        fprintf(fid, '& \\includegraphics[width=0.14\\linewidth]{figs_qualitative_relPCI/method%d_%s_reproj.pdf} \n', ii, imgids{jj});
    end
    fprintf(fid, '\\\\ \n');
    
    fprintf(fid, '%s ', method(ii).leg);
    for jj = 1:1:length(imgids)
        fprintf(fid, '& %.02fm, %.02f$^{\\circ}$ ', poserr(ii, jj), orierr(ii, jj)*180/pi);
    end
    fprintf(fid, '\\\\ \\hline \n');
end

fprintf(fid, '~ & ~ & ~ & ~ & ~ & ~ \\\\ [-4pt] \n');
fprintf(fid, 'Most relevant PCI \n');
for jj = 1:1:length(imgids)
    fprintf(fid, '& \\includegraphics[width=0.14\\linewidth]{figs_qualitative_relPCI/%s_relPCI.pdf} \n', imgids{jj});
end
fprintf(fid, '\\\\[4pt] \n');

fclose(fid);


% %% gather subset
% imgids = {'0128', '0199', '0002', '0000', '0431'};
% imgids = {'0007', '0032', '0128', '0267', '0298', '0476', '0516', '0544', '0645', '0760'};%SSII figs
% imgids = {'0239'};
% export_dir = 'PAMI_qualitative';
% 
% for ii = 1:1:length(imgids)
%     
%     %query
%     this_qname = [imgids{ii}, '.jpg'];
%     copyfile(fullfile(fnames.dataset.dir, fnames.dataset.name, fnames.dataset.Qdir, this_qname), ...
%         fullfile(export_dir, this_qname));
%     
%     %relevant PCI
%     ann_matname = fullfile('/datagrid1new/results/SanFrancisco/torii/SF_annotation_05-merge', imgids{ii}, 'matchesx.mat');
%     load(ann_matname);relPCIimgname = pd.dn{pd.ix};
%     this_relPCIidx = strcmp(relPCIimgname, dbfbase);
%     copyfile(fullfile(fnames.dataset.dir, fnames.dataset.name, fnames.dataset.PCIdir, [dbfnames{this_relPCIidx}, '.jpg']), ...
%         fullfile(export_dir, [imgids{ii}, '_relPCI.jpg']));
%     
% end

