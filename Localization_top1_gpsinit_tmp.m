clear all;
% close all;

%user define%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
dataset_name = 'SanFrancisco';

%parameter
gps_uncertainty = 50;
neighbor_r = 250;

%shortlist
shortlist_basename = sprintf('densevlad_gpsinit_uncertainty%d_neighbor%d', gps_uncertainty, neighbor_r);

%score
qfnames_matname = 'scores/densevlad/qfnames.mat';
dbfnames_matname = '/datagrid5new/SanFrancisco/PCIs_dbfnames.mat';
scores_matname = 'scores/densevlad/score_dnsvlad_K128_pca4096_layer00.mat';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%output%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
output_dir = fullfile('outputs', dataset_name);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%make gps initialized shortlist
load_save_shortlist_gpsinit_reuse;
 
%Save localization results (top1)
save_top1locposes_reuse;

