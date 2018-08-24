function [ Cameras ] = load_colmap_cameras( result_dir )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

fid = fopen(fullfile(result_dir, 'cameras.txt'));
data = textscan(fid, '%s', 'Delimiter', '\n');
data = data{1};
fclose(fid);
Cameras = struct('camid', {}, 'model', {}, 'width', {}, 'height', {}, 'params', {});

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
cameras_str = data_split(iscomment==0);

for i = 1:1:length(cameras_str)
    this_camera_str = cameras_str{i};
    
    Cameras(i).camid = str2double(this_camera_str{1});
    Cameras(i).model = this_camera_str{2};
    Cameras(i).width = str2double(this_camera_str{3});
    Cameras(i).height = str2double(this_camera_str{4});
    Cameras(i).params = str2double(this_camera_str(5:end));
end

end

