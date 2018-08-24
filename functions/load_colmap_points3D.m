function [ Points3D ] = load_colmap_points3D( result_dir )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

fid = fopen(fullfile(result_dir, 'points3D.txt'));
data = textscan(fid, '%s', 'Delimiter', '\n');
data = data{1};
fclose(fid);
Points3D = struct('points3d_id', {}, 'X', {}, 'color', {}, 'error', {}, 'track', {});

%delete comment
data_split = cell(size(data));
iscomment = zeros(size(data));
for i = 1:1:length(data)
    data_split{i} = strsplit(data{i}, ' ');
    if strcmp(data_split{i}{1}, '#') == 1; iscomment(i) = 1; end
end
if sum(~iscomment) == 0
    return;
end
points_str = data_split(iscomment==0);

for i = 1:1:length(points_str)
    this_point_str = points_str{i};
    
    Points3D(i).points3d_id = str2double(this_point_str{1});
    Points3D(i).X = str2double(this_point_str(2:4))';
    Points3D(i).color = str2double(this_point_str(5:7))';
    Points3D(i).error = str2double(this_point_str{8});
    Points3D(i).track = reshape(str2double(this_point_str(9:end)), 2, []);
end

end

