function [ ranked_poses ] = load_TS_hyperpoint_poses( poses_path )
%LOAD_TS_ Summary of this function goes here
%   Detailed explanation goes here

fid = fopen(poses_path);
data = textscan(fid, '%s', 'Delimiter', '\n');
data = data{1};
fclose(fid);

%output
ranked_poses = struct();

for i = 1:1:length(data)
    %format: score database_image_id database_image_name R00 R01 R02 R10 R11 R12 R20 R21 R22 tx ty tz
    this_split = strsplit(data{i}, ' ');
    ranked_poses(i).score = str2double(this_split{1});
    ranked_poses(i).imgid = str2double(this_split{2});
    ranked_poses(i).imgname = this_split{3};
    ranked_poses(i).R = ...
        [str2double(this_split(4:6)); ...
         str2double(this_split(7:9)); ...
         str2double(this_split(10:12))];
    ranked_poses(i).t = str2double(this_split(13:15))';
    ranked_poses(i).position = -ranked_poses(i).R' * ranked_poses(i).t;
end


end

