pose1 =load('reference_poses/reference_poses_467_ext.mat');
pose1 = pose1.poses;
pose2 =load('reference_poses/reference_poses_addTM_438.mat');
pose2 = pose2.poses;
pose3 =load('reference_poses/reference_poses_colmapimprove_44.mat');
pose3 = pose3.poses;

pose1_qnames = {pose1.name};
poses12 = pose1;
for k = 1:1:length(pose2)
    if sum(strcmp(pose1_qnames, pose2(k).name)) == 0
        poses12 = [poses12, pose2(k)];
    end
end

pose12_qnames = {poses12.name};
poses123 = poses12;
for k = 1:1:length(pose3)
    if sum(strcmp(pose12_qnames, pose3(k).name)) == 0
        poses123 = [poses123, pose3(k)];
    end
end

poses = poses123;