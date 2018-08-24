function [ ImgList ] = load_TS_disloc_shortlist( shortlist_path )
%LOAD_TS_DISLOC_SHORTLIST Summary of this function goes here
%   Detailed explanation goes here

%Output
ImgList = struct();

%open file
fid = fopen(shortlist_path);
data_all = textscan(fid, '%s', 'Delimiter', '\n');
data_all = data_all{1};
%close file
fclose(fid);

%Store the properties for each query
topNscore = cell(length(data_all), 1);
topNname = cell(length(data_all), 1);
place_id = cell(length(data_all), 1);
for i = 1:1:length(data_all)
    this_str_split = strsplit(data_all{i}, ' ');
    
    topNscore{i} = this_str_split{1};
    topNname{i} = this_str_split{2};
    place_id{i} = this_str_split{3};
    
end

ImgList.topNscore = str2double(topNscore);
ImgList.topNname = topNname;
ImgList.topNplace_id = str2double(place_id);

end

