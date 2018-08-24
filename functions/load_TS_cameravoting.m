function [ poses ] = load_TS_cameravoting( cameravoting_path )
%LOAD_TS_CAMERAVOTING Summary of this function goes here
%   Detailed explanation goes here

fid = fopen(cameravoting_path);
data = textscan(fid, '%s', 'Delimiter', '\n');
data = data{1};
fclose(fid);

%output
poses = struct();

for i = 1:1:length(data)
    %format: database_image_name score R00 R01 R02 R10 R11 R12 R20 R21 R22 tx ty tz
    this_split = strsplit(data{i}, ' ');
    poses(i).imgname = this_split{1};
    poses(i).score = str2double(this_split{2});
    poses(i).R = ...
        [str2double(this_split(3:5)); ...
         str2double(this_split(6:8)); ...
         str2double(this_split(9:11))];
    poses(i).t = str2double(this_split(12:14))';
    poses(i).position = -poses(i).R' * poses(i).t;
    
end


end

