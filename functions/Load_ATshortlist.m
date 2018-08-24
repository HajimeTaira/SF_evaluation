function [ ImgList ] = Load_ATshortlist( shortlist_params )
%LOAD_ATSHORTLIST この関数の概要をここに記述
%   詳細説明をここに記述

%Output
ImgList = struct();

%open file
fid = fopen(shortlist_params.fullpath);
data_all = textscan(fid, '%s', 'Delimiter', '\n');
data_all = data_all{1};
%close file
fclose(fid);

%Store the properties for each query
colnum_forquery = (shortlist_params.num + 1);
if rem(length(data_all), colnum_forquery)~=0
    disp('Load_ATshortlist: Format is wrong. ');
    return;
end
querynum = length(data_all) / colnum_forquery;
for i = 1:1:querynum
    querystr = data_all{(i-1)*colnum_forquery + 1};
    slstrs = data_all( ((i-1)*colnum_forquery + 2):1:(i*colnum_forquery) );
    
    %query image
    querystr_split = strsplit(querystr, '/');
    ImgList(i).queryname = querystr_split{end};
    %top-N images
    prop1 = cell(shortlist_params.num, 1);
    prop2 = cell(shortlist_params.num, 1);
    topNname = cell(shortlist_params.num, 1);
    for j = 1:1:shortlist_params.num
        this_slstr_split = strsplit(slstrs{j}, {'/', ' '});
        prop1{j} = this_slstr_split{1};
        prop2{j} = this_slstr_split{2};
        topNname{j} = strcat(this_slstr_split{end-1}, '/', this_slstr_split{end});
    end
    ImgList(i).topNprop2 = prop2;
    ImgList(i).topNname = topNname;
    ImgList(i).topNscore = str2double(prop1);
end


end

