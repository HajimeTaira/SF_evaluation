function [ ImgList ] = load_TS_disloc_originalshortlist( shortlist_path )
%LOAD_TS_DISLOC_ORIGINALSHORTLIST Summary of this function goes here
%   Detailed explanation goes here

%output
ImgList = struct();

%open file
fid = fopen(shortlist_path);
data_all = textscan(fid, '%s', 'Delimiter', '\n');
data_all = data_all{1};
%close file
fclose(fid);

%Store the properties for each query
qname = cell(length(data_all), 1);
dbname = cell(length(data_all), 1);
score = cell(length(data_all), 1);
for i = 1:1:length(data_all)
    thisline_split = strsplit(data_all{i}, ' ');
    qname{i} = thisline_split{1};
    dbname{i} = thisline_split{2};
    score{i} = thisline_split{3};
end

%check
unqname = unique(qname);
for j = 1:1:length(unqname)
    this_unqname = unqname{j};
    this_idx = strcmp(this_unqname, qname);
    this_qnamesplit = strsplit(this_unqname, '/');
    ImgList(j).queryname = this_qnamesplit{end};
    ImgList(j).topNname = dbname(this_idx);
    ImgList(j).topNscore = str2double(score(this_idx));
end
% if length(unique(qname))
%     disp('load_TS_disloc_originalshortlist: Format is wrong. ');
%     return;
% end


% ImgList = Imgs;
end

