clear all;
close all;

%user define%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
dataset_name = 'SanFrancisco';

%images
dataset_dir = fullfile('/datagrid5new', dataset_name);
%image path
dataset_imgtype = 'PCIs';
dataset_imgdir = fullfile(dataset_dir, dataset_imgtype);
%query path
dataset_querytype = 'Query/BuildingQueryImagesCartoIDCorrected-Upright';
dataset_querydir = fullfile(dataset_dir, dataset_querytype);
%PCIlist name
PCIlist_name = 'PCIs_dbfnames.mat';

%shortlist
% shortlist_basename = 'shortlist_netvlad_SR';
shortlist_basename = 'densevlad_gpsinit_uncertainty50_neighbor100_SR';

%subset range
range = 25;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%output%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
output_dir = fullfile('outputs', dataset_name);
subset_path = fullfile(output_dir, 'imagesubsets', shortlist_basename, sprintf('range%d', range));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%
%Load shortlist or estimated poses
load_save_shortlist_reuse;%shortlist_str

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
    %make folder
    mkdir(fullfile(subset_path, shortlist_str(i).Query_name));
    
    %measure topN distance
    topN_UTM = zeros(2, length(shortlist_str(i).topN_name));
    for k = 1:1:length(shortlist_str(i).topN_name)
        thisinfos = loadgps_from_davidchen_imgname(shortlist_str(i).topN_name{k});
        [topN_UTM(1, k), topN_UTM(2, k)] = lltoutm(thisinfos.lat, thisinfos.lng);
    end
    topN_dist = pdist2(topN_UTM(:, 1)', topN_UTM');
    neighbor_idx = find(topN_dist < range);
    subset_size(i) = length(neighbor_idx);

%     %measure PCI distance
%     top1_infos = loadgps_from_davidchen_imgname(shortlist_str(i).topN_name{1});
%     [top1_UTME, top1_UTMN] = lltoutm(top1_infos.lat, top1_infos.lng);
%     PCI_dist = pdist2([top1_UTME, top1_UTMN], PCI_UTM');
%     neighboridx = find(PCI_dist < range);
%     keyboard;
    
    
    %copy Query image
    copyfile(fullfile(dataset_querydir, shortlist_str(i).Query_name), fullfile(subset_path, shortlist_str(i).Query_name, shortlist_str(i).Query_name));
    
    %copy neighbor PCI image
    for j = neighbor_idx
        copyfile(fullfile(dataset_imgdir, shortlist_str(i).topN_name{j}), fullfile(subset_path, shortlist_str(i).Query_name));
    end
    
    %save property
    PCI_names = shortlist_str(i).topN_name(neighbor_idx);
    PCI_distance = topN_dist(neighbor_idx);
    save('-v6', fullfile(subset_path, shortlist_str(i).Query_name, 'PCI_property.mat'), 'PCI_names', 'PCI_distance');
    
    
    
    
    
end






