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

%shortlist
% shortlist_basename = 'shortlist_disloc_interplace';
shortlist_basename = 'shortlist_disloc_interplace_new';
% shortlist_basename = 'densevlad_gpsinit_uncertainty50_neighbor100_SR';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%output%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
output_dir = fullfile('outputs', dataset_name);
subset_path = fullfile(output_dir, 'imagesubsets_colmap', shortlist_basename, 'all');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Load shortlist or estimated poses
load_save_shortlist_reuse;%shortlist_str

%load query intrinsics
read_query_list;
query_intrinsic_list = QList;

%make subset
for i = 1:1:length(shortlist_str)
    
    %a. all
    if exist(fullfile(subset_path, shortlist_str(i).Query_name, 'all'), 'dir') ~= 7
        mkdir(fullfile(subset_path, shortlist_str(i).Query_name, 'all'));
    end
    cmdstr = sprintf('ln -s %s %s', fullfile(dataset_querydir, shortlist_str(i).Query_name), fullfile(subset_path, shortlist_str(i).Query_name, 'all', shortlist_str(i).Query_name));
    system(cmdstr);
%     copyfile(fullfile(dataset_querydir, shortlist_str(i).Query_name), fullfile(subset_path, shortlist_str(i).Query_name, 'all', shortlist_str(i).Query_name));
    for j = 1:1:length(shortlist_str(i).topN_name)
        cmdstr = sprintf('ln -s %s %s', fullfile(dataset_imgdir, shortlist_str(i).topN_name{j}), fullfile(subset_path, shortlist_str(i).Query_name, 'all'));
        system(cmdstr);
%         copyfile(fullfile(dataset_imgdir, shortlist_str(i).topN_name{j}), fullfile(subset_path, shortlist_str(i).Query_name, 'all'));
    end
    
    %b. PCI
    if exist(fullfile(subset_path, shortlist_str(i).Query_name, 'PCI'), 'dir') ~= 7
        mkdir(fullfile(subset_path, shortlist_str(i).Query_name, 'PCI'));
    end
    for j = 1:1:length(shortlist_str(i).topN_name)
        cmdstr = sprintf('ln -s %s %s', fullfile(dataset_imgdir, shortlist_str(i).topN_name{j}), fullfile(subset_path, shortlist_str(i).Query_name, 'PCI'));
        system(cmdstr);
%         copyfile(fullfile(dataset_imgdir, shortlist_str(i).topN_name{j}), fullfile(subset_path, shortlist_str(i).Query_name, 'PCI'));
    end
    
    %c. query
    if exist(fullfile(subset_path, shortlist_str(i).Query_name, 'Query'), 'dir') ~= 7
        mkdir(fullfile(subset_path, shortlist_str(i).Query_name, 'Query'));
    end
    cmdstr = sprintf('ln -s %s %s', fullfile(dataset_querydir, shortlist_str(i).Query_name), fullfile(subset_path, shortlist_str(i).Query_name, 'Query', shortlist_str(i).Query_name));
    system(cmdstr);
%     copyfile(fullfile(dataset_querydir, shortlist_str(i).Query_name), fullfile(subset_path, shortlist_str(i).Query_name, 'Query', shortlist_str(i).Query_name));
    
    %d. query intrinsic
    intrinsic_idx = find(strcmp({query_intrinsic_list.name}, shortlist_str(i).Query_name));
    fl = query_intrinsic_list(intrinsic_idx).K(1);
    cx = query_intrinsic_list(intrinsic_idx).K(1, 3);
    cy = query_intrinsic_list(intrinsic_idx).K(2, 3);
    
    fid = fopen(fullfile(subset_path, shortlist_str(i).Query_name, 'qintrinsic.txt'), 'w');
    fprintf(fid, '%f, %f, %f, 0', fl, cx, cy);
    fclose(fid);
    
end