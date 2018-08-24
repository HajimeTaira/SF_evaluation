clear all;
close all;
AT_name = 'inputs/res_netvlad_K64_pca4096_layer00.detail';
shortlist_txtname = 'inputs/shortlist_netvlad';

%%
%load AT shortlist
shortlist_params.fullpath = AT_name;
shortlist_params.num = 200;
[ ImgList ] = Load_ATshortlist( shortlist_params );

%%
%write shortlist_txt
fid = fopen(shortlist_txtname, 'w');
fprintf(fid, '200\n');

for i = 1:1:length(ImgList)
    %query name
    fprintf(fid, '%s\n', ImgList(i).queryname);
    
    %topN property
    for j = 1:1:length(ImgList(i).topNname)
        fprintf(fid, '%f %s\n', ImgList(i).topNscore(j), ImgList(i).topNname{j});
    end
end


fclose(fid);