function [ shortlist_str ] = load_shortlist_txt( shortlist_txtname )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

shortlist_str = struct('Query_name', {}, 'topN_name', {}, 'topN_score', {}, 'topN_P', {}, 'topN_C', {});

fid = fopen(shortlist_txtname);
data_all = textscan(fid, '%s', 'Delimiter', '\n');
data_all = data_all{1};
shortlist_N = str2double(data_all{1});
data_all = data_all(2:end);
Qnum = length(data_all) / (shortlist_N + 1);
fclose(fid);

for i = 1:1:Qnum
    this_data = data_all( ((shortlist_N+1)*(i-1)+1):1:((shortlist_N+1)*i) );
    %query
    shortlist_str(i).Query_name = this_data{1};
    %topN property
    topN_data = this_data(2:end);
    for j = 1:1:shortlist_N
        topN_data_j = topN_data{j};
        topN_data_j = strsplit(topN_data_j, ' ');
        shortlist_str(i).topN_score(j) = str2double(topN_data_j{1});
        shortlist_str(i).topN_name{j} = topN_data_j{2};
        
        if length(topN_data_j) == 14%load camera pose
            shortlist_str(i).topN_P{j} = reshape(str2double(topN_data_j(3:14)), 3, 4);
            shortlist_str(i).topN_C{j} = -inv(shortlist_str(i).topN_P{j}(1:3, 1:3)) * shortlist_str(i).topN_P{j}(1:3, 4);
        end
    end
    
end

end

