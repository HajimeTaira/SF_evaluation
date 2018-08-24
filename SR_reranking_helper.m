function [ this_shortlist_str ] = SR_reranking_helper( this_shortlist_str, dataset_dir, output_dir )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

%re-scoring (geometric verification)
shortlist_rescoring_reuse;%update this_shortlist_str.topN_score

%spatial re-ranking
shortlist_reranking_reuse;%update this_shortlist_str

end

