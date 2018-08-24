function [ poses ] = load_referencepose_txt( ref_txt_path )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

%output
poses = struct('name', {}, 'P', {});

%open file
fid = fopen(ref_txt_path);
data_all = textscan(fid, '%s', 'Delimiter', '\n');
data_all = data_all{1};
%close file
fclose(fid);

%header
data_all = data_all(2:end);

for i = 1:1:length(data_all)
    this_data_split = strsplit(data_all{i}, ' ');
    poses(i).name = this_data_split{2};
    R = qtr2rot(str2double(this_data_split(3:6)));
    c = str2double(this_data_split(7:9))';
    t = - R * c;
    poses(i).P = [R, t];
    
end





end

