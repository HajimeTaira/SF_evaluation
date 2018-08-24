function [ Images ] = load_colmap_images( result_dir )
%LOAD_COLMAP_IMAGES Summary of this function goes here
%   Detailed explanation goes here

fid = fopen(fullfile(result_dir, 'images.txt'));
data = textscan(fid, '%s', 'Delimiter', '\n');
data = data{1};
fclose(fid);

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
data_split = data_split(iscomment==0);
imgparams_str = data_split(1:2:end);
points2d_str = data_split(2:2:end);

%output
Images = struct();

for j = 1:1:length(imgparams_str)
    this_imgparams = imgparams_str{j};
    this_points2D = points2d_str{j};
    
    %image parameters
    Images(j).imgid = str2double(this_imgparams{1});
    Images(j).R = qtr2rot(str2double(this_imgparams(2:5)));
    Images(j).t = str2double(this_imgparams(6:8))';
    Images(j).position = -Images(j).R' * Images(j).t;
    Images(j).camid = str2double(this_imgparams{9});
    Images(j).name = this_imgparams{10};
    
    %keypoints
    Images(j).kp = reshape(str2double(this_points2D), 3, []);
    
%     %debug
%     Images(j).xvec = Images(j).R' * [1; 0; 0];
%     Images(j).yvec = Images(j).R' * [0; 1; 0];
%     Images(j).zvec = Images(j).R' * [0; 0; 1];
end

end

