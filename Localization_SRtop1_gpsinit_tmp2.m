clear all;
close all;

%user define%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
dataset_name = 'SanFrancisco';

%images
dataset_dir = fullfile('/datagrid5new', dataset_name);

%parameter
gps_uncertainty = 50;
neighbor_r = 200;

%shortlist (original)
shortlist_basename = sprintf('densevlad_gpsinit_uncertainty%d_neighbor%d', gps_uncertainty, neighbor_r);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%output%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
output_dir = fullfile('outputs', dataset_name);

%1. shortlist (after SR with GPS initialization)
shortlist_SR_basename = [shortlist_basename, '_SR'];
shortlist_SR_matname = fullfile(output_dir, 'shortlists', [shortlist_SR_basename, '.mat']);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if exist(shortlist_SR_matname, 'file') == 2
    load(shortlist_SR_matname);
else
    %Load shortlist or estimated poses (original)
    load_save_shortlist_gpsinit_reuse;%shortlist_str
    
    parfor i = 1:1:length(shortlist_str)
        warning('off','all');
        this_shortlist_str = shortlist_str(i);
        
        this_shortlist_str = SR_reranking_helper( this_shortlist_str, dataset_dir, output_dir );
        
%         %re-scoring (geometric verification)
%         shortlist_rescoring_reuse;%update this_shortlist_str.topN_score
%         
%         %spatial re-ranking
%         shortlist_reranking_reuse;%update this_shortlist_str
        
        shortlist_str(i) = this_shortlist_str;%update shortlist_str
        fprintf('%s DONE. \n', this_shortlist_str.Query_name);
    end
    
    
    %save shortlist (SR)
    if exist(fullfile(output_dir, 'shortlists'), 'dir') ~= 7
        mkdir(fullfile(output_dir, 'shortlists'));
    end
    save('-v6', shortlist_SR_matname, 'shortlist_str');

end

%Save localization results (top1 after SR)
shortlist_basename = shortlist_SR_basename;
save_top1locposes_reuse;
