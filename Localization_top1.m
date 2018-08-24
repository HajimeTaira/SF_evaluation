clear all;
% close all;

%user define%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
dataset_name = 'SanFrancisco';

%shortlist
% shortlist_basename = 'shortlist_disloc_interplace';
shortlist_basename = 'shortlist_disloc_interplace_new';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%output%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
output_dir = fullfile('outputs', dataset_name);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Load shortlist or estimated poses
load_save_shortlist_reuse;%shortlist_str

%Save localization results (top1)
save_top1locposes_reuse;







