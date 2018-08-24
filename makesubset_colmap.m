clear all;
close all;

%user define%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
dataset_name = 'SanFrancisco';

%images
dataset_dir = fullfile('/mnt/datagrid5', dataset_name);
%image path
dataset_imgtype = 'PCIs';
dataset_imgdir = fullfile(dataset_dir, dataset_imgtype);
%query path
dataset_querytype = 'Query/BuildingQueryImagesCartoIDCorrected-Upright';
dataset_querydir = fullfile(dataset_dir, dataset_querytype);
%PCIlist name
PCIlist_name = 'PCIs_dbfnames.mat';

%shortlist
% shortlist_basename = 'shortlist_format_2_SR';
% shortlist_basename = 'shortlist_netvlad_SR';
% shortlist_basename = 'shortlist_disloc_original_SR';
% shortlist_basename = 'densevlad_gpsinit_uncertainty50_neighbor100_SR';
% shortlist_basename = 'densevlad_gpsinit_uncertainty50_neighbor10_SR';
% shortlist_basename = 'densevlad_gpsinit_uncertainty50_neighbor20_SR';
% shortlist_basename = 'densevlad_gpsinit_uncertainty50_neighbor30_SR';
% shortlist_basename = 'densevlad_gpsinit_uncertainty50_neighbor40_SR';
% shortlist_basename = 'densevlad_gpsinit_uncertainty50_neighbor50_SR';
% shortlist_basename = 'densevlad_gpsinit_uncertainty50_neighbor60_SR';
% shortlist_basename = 'densevlad_gpsinit_uncertainty50_neighbor70_SR';
% shortlist_basename = 'densevlad_gpsinit_uncertainty50_neighbor80_SR';
% shortlist_basename = 'densevlad_gpsinit_uncertainty50_neighbor90_SR';
% shortlist_basename = 'densevlad_gpsinit_uncertainty50_neighbor120_SR';
% shortlist_basename = 'densevlad_gpsinit_uncertainty50_neighbor140_SR';
% shortlist_basename = 'densevlad_gpsinit_uncertainty50_neighbor160_SR';
% shortlist_basename = 'densevlad_gpsinit_uncertainty50_neighbor180_SR';
% shortlist_basename = 'densevlad_gpsinit_uncertainty50_neighbor200_SR';
% shortlist_basename = 'densevlad_gpsinit_uncertainty50_neighbor225_SR';
% shortlist_basename = 'densevlad_gpsinit_uncertainty50_neighbor250_SR';
shortlist_basename = 'shortlist_disloc_interplace_new';

%subset range
range = 25;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%output%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
output_dir = fullfile('outputs', dataset_name);
subset_path = fullfile(output_dir, 'imagesubsets_colmap', shortlist_basename, sprintf('range%d', range));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%
%Load shortlist or estimated poses
load_save_shortlist_reuse;%shortlist_str

%load query intrinsics
read_query_list;
query_intrinsic_list = QList;


% %load all PCI list
% load(fullfile(dataset_dir, PCIlist_name), 'dbfnames');
% dbfnames = strcat(dbfnames, '.jpg');
% PCI_UTM = zeros(2, length(dbfnames));
% for k = 1:1:length(dbfnames)
%     thisinfos = loadgps_from_davidchen_imgname(dbfnames{k});
%     [PCI_UTM(1, k), PCI_UTM(2, k)] = lltoutm(thisinfos.lat, thisinfos.lng);
% end

%%
%make subset
subset_size = zeros(1, length(shortlist_str));
for i = 1:1:length(shortlist_str)
    
    %measure topN distance
    topN_UTM = zeros(2, length(shortlist_str(i).topN_name));
    for k = 1:1:length(shortlist_str(i).topN_name)
        thisinfos = loadgps_from_davidchen_imgname(shortlist_str(i).topN_name{k});
        [topN_UTM(1, k), topN_UTM(2, k)] = lltoutm(thisinfos.lat, thisinfos.lng);
    end
    topN_dist = pdist2(topN_UTM(:, 1)', topN_UTM');
    neighbor_idx = find(topN_dist < range);
    subset_size(i) = length(neighbor_idx);
    
    %a. all
    if exist(fullfile(subset_path, shortlist_str(i).Query_name, 'all'), 'dir') ~= 7
        mkdir(fullfile(subset_path, shortlist_str(i).Query_name, 'all'));
    end
%     copyfile(fullfile(dataset_querydir, shortlist_str(i).Query_name), fullfile(subset_path, shortlist_str(i).Query_name, 'all', shortlist_str(i).Query_name));
    cmdstr = sprintf('ln -s %s %s', fullfile(dataset_querydir, shortlist_str(i).Query_name), fullfile(subset_path, shortlist_str(i).Query_name, 'all', shortlist_str(i).Query_name));
    system(cmdstr);
    for j = neighbor_idx
        cmdstr = sprintf('ln -s %s %s', fullfile(dataset_imgdir, shortlist_str(i).topN_name{j}), fullfile(subset_path, shortlist_str(i).Query_name, 'all'));
        system(cmdstr);
%         copyfile(fullfile(dataset_imgdir, shortlist_str(i).topN_name{j}), fullfile(subset_path, shortlist_str(i).Query_name, 'all'));
    end
    
    %b. PCI
    if exist(fullfile(subset_path, shortlist_str(i).Query_name, 'PCI'), 'dir') ~= 7
        mkdir(fullfile(subset_path, shortlist_str(i).Query_name, 'PCI'));
    end
    for j = neighbor_idx
        cmdstr = sprintf('ln -s %s %s', fullfile(dataset_imgdir, shortlist_str(i).topN_name{j}), fullfile(subset_path, shortlist_str(i).Query_name, 'PCI'));
        system(cmdstr);
%         copyfile(fullfile(dataset_imgdir, shortlist_str(i).topN_name{j}), fullfile(subset_path, shortlist_str(i).Query_name, 'PCI'));
    end
    
    %c. query
    if exist(fullfile(subset_path, shortlist_str(i).Query_name, 'Query'), 'dir') ~= 7
        mkdir(fullfile(subset_path, shortlist_str(i).Query_name, 'Query'));
    end
%     copyfile(fullfile(dataset_querydir, shortlist_str(i).Query_name), fullfile(subset_path, shortlist_str(i).Query_name, 'Query', shortlist_str(i).Query_name));
    cmdstr = sprintf('ln -s %s %s', fullfile(dataset_querydir, shortlist_str(i).Query_name), fullfile(subset_path, shortlist_str(i).Query_name, 'Query', shortlist_str(i).Query_name));
    system(cmdstr);
    
    %d. query intrinsic
    intrinsic_idx = find(strcmp({query_intrinsic_list.name}, shortlist_str(i).Query_name));
    fl = query_intrinsic_list(intrinsic_idx).K(1);
    cx = query_intrinsic_list(intrinsic_idx).K(1, 3);
    cy = query_intrinsic_list(intrinsic_idx).K(2, 3);
    
    fid = fopen(fullfile(subset_path, shortlist_str(i).Query_name, 'qintrinsic.txt'), 'w');
    fprintf(fid, '%f, %f, %f, 0', fl, cx, cy);
    fclose(fid);
    
    
    
    
    
end






