clear all;
close all;

%%
% %original shortlist
% disloc_name = '/datagrid4new/sattler/results_disloc_with_geometric_burstiness/sf.disloc.retrieval_ranking.txt';
% [ ImgList ] = load_TS_disloc_originalshortlist( disloc_name );
% 
% %output
% shortlist_txtname = 'inputs/shortlist_disloc_original';
% 
% %write shortlist_txt
% fid = fopen(shortlist_txtname, 'w');
% fprintf(fid, '200\n');
% 
% for i = 1:1:length(ImgList)
%     %query name
%     fprintf(fid, '%s\n', ImgList(i).queryname);
%     
%     %topN property
%     for j = 1:1:length(ImgList(i).topNname)
%         fprintf(fid, '%f %s\n', ImgList(i).topNscore(j), ImgList(i).topNname{j});
%     end
% end
% fclose(fid);
% 
% %%
% %inter-place (SR)
% disloc_path = '/datagrid4new/sattler/results_disloc_with_geometric_burstiness/inter_place';
% query_idx = 0:1:802;
% TSshortlist_nameformat = 'query_%04g.inter_place.txt';
% 
% %output
% shortlist_matname = 'outputs/SanFrancisco/shortlists/shortlist_disloc_interplace.mat';
% shortlist_str = struct('Query_name', {}, 'topN_name', {}, 'topN_score', {}, 'topN_P', {}, 'topN_C', {});
% 
% for qq = query_idx
%     this_shortlist_txtname = fullfile(disloc_path, sprintf('%04g', qq), sprintf(TSshortlist_nameformat, qq));
%     [ this_sl ] = load_TS_disloc_shortlist( this_shortlist_txtname );
%     shortlist_str(qq+1).Query_name = sprintf('%04g.jpg', qq);
%     shortlist_str(qq+1).topN_name = this_sl.topNname;
%     shortlist_str(qq+1).topN_score = this_sl.topNscore;
% end
% save('-v6', shortlist_matname, 'shortlist_str');

%% disloc inter-place (new)
this_dir = '/mnt/datagrid1/results/SanFrancisco/taira/SF_annotation_release';
TSdisloc_txtname = fullfile(this_dir, 'inputs/disloc_bugfixed/sf.disloc.inter_place_geometric_burstiness_ranking.txt');
shortlist_matname = fullfile(this_dir, 'outputs/SanFrancisco/shortlists/shortlist_disloc_interplace_new.mat');
% TSdisloc_txtname = fullfile(this_dir, 'inputs/disloc_bugfixed/sf.disloc.inter_place_popularity_geometric_burstiness_ranking.txt');
% shortlist_matname = fullfile(this_dir, 'outputs/SanFrancisco/shortlists/shortlist_disloc_interplace_pop_new.mat');

[ this_sl ] = load_TS_disloc_originalshortlist( TSdisloc_txtname );
shortlist_str = struct('Query_name', {}, 'topN_name', {}, 'topN_score', {}, 'topN_P', {}, 'topN_C', {});
for qq = 1:1:length(this_sl)
    shortlist_str(qq).Query_name = this_sl(qq).queryname;
    shortlist_str(qq).topN_score = this_sl(qq).topNscore;
    shortlist_str(qq).topN_name = cell(length(this_sl(qq).topNname), 1);
    for dd = 1:1:length(this_sl(qq).topNname)
        [this_path, this_basename, ~] = fileparts(this_sl(qq).topNname{dd});
        shortlist_str(qq).topN_name{dd} = fullfile(this_path, [this_basename, '.jpg']);
    end
    
    %sort
    [~, sorted_idx] = sort(shortlist_str(qq).topN_score, 'descend');
    shortlist_str(qq).topN_score = shortlist_str(qq).topN_score(sorted_idx);
    shortlist_str(qq).topN_name = shortlist_str(qq).topN_name(sorted_idx);
end

save('-v6', shortlist_matname, 'shortlist_str');

