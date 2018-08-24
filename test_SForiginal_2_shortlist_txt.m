clear all;
close all;
% SF_name = 'inputs/SVKNNTree-D6-Navteq-SF-PCI-March2011-HistEq-Upright-SIFT.queryResult.accuracy.label.detail';
% shortlist_txtname = 'inputs/SForiginal';
SF_name = 'inputs/SVKNNTree-D6-Navteq-SF-PCI-March2011-HistEq-Upright-SIFT.queryResult.accuracy.label.rerank.detail';
shortlist_txtname = 'inputs/SForiginal_rerank';

%% load original SF shortlist
shortlist_params.fullpath = SF_name;
shortlist_params.num = 50;
[ ImgList ] = Load_ATshortlist( shortlist_params );

%% write shortlist_txt
fid = fopen(shortlist_txtname, 'w');
fprintf(fid, '50\n');

for i = 1:1:length(ImgList)
    %query name
    fprintf(fid, '%s\n', ImgList(i).queryname);
    
    %topN property
    for j = 1:1:length(ImgList(i).topNname)
        fprintf(fid, '%f %s\n', 0, ImgList(i).topNname{j});
    end
end


fclose(fid);