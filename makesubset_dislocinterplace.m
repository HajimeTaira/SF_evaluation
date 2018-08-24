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

%shortlist
% shortlist_basename = 'shortlist_disloc_interplace';
shortlist_basename = 'densevlad_gpsinit_uncertainty50_neighbor100_SR';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%output%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
output_dir = fullfile('outputs', dataset_name);
subset_path = fullfile(output_dir, 'imagesubsets', shortlist_basename, 'all');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Load shortlist or estimated poses
load_save_shortlist_reuse;%shortlist_str

%make subset
for i = 1:1:length(shortlist_str)
    %make folder
    mkdir(fullfile(subset_path, shortlist_str(i).Query_name));
    
    %copy Query image
    copyfile(fullfile(dataset_querydir, shortlist_str(i).Query_name), fullfile(subset_path, shortlist_str(i).Query_name, shortlist_str(i).Query_name));
    
    %copy PCI in shortlist
    for j = 1:1:length(shortlist_str(i).topN_name)
        copyfile(fullfile(dataset_imgdir, shortlist_str(i).topN_name{j}), fullfile(subset_path, shortlist_str(i).Query_name));
    end
end