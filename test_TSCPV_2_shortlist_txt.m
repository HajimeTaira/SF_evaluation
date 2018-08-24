clear all;
close all;

%load CPV
CPV_name = 'inputs/camera_pose_voting_ransac_poses_without_gps.txt';
[ poses ] = load_TS_cameravoting(CPV_name);
%%
%precomputed similarity transform (bundler -> UTM)
S1_matfullpath = '/datagrid5new/SanFrancisco/sf0gpsalined_to_utm.mat';
S2_matfullpath = '/datagrid5new/SanFrancisco/sf0bundler_to_utm.mat';
%Load precomputed similarity transform
load(S2_matfullpath, 'Rutm', 'tutm', 'ceutm', 'cam', 'utm_pci');
X1 = [utm_pci; zeros(1,size(utm_pci,2))];
X1mean = mean(X1,2);
X1center = bsxfun(@minus,X1,X1mean);
X2 = bsxfun(@minus,cam,mean(cam,2));
X2out = bsxfun(@plus,(ceutm*Rutm)*X2,tutm+X1mean);
X2outmean = mean(X2out,2);%????????
clear Rutm tutm ceutm cam utm_pci;
load(S1_matfullpath, 'Rutm', 'tutm', 'ceutm');
R_TSBDR2MVG = [1, 0, 0; 0, -1, 0; 0, 0, -1];

%parse into shortlist format
shortlist_txtname = 'inputs/shortlist_cpv_wo_gps';
shortlist_matname = 'outputs/SanFrancisco/shortlists/shortlist_cpv_w_gps.mat';
shortlist_str = struct('Query_name', {}, 'topN_name', {}, 'topN_score', {}, 'topN_P', {}, 'topN_C', {});
fid = fopen(shortlist_txtname, 'w');
fprintf(fid, '1\n');
for i = 1:1:length(poses)
    %query name
    [~, this_query_name, ext] = fileparts(poses(i).imgname);
    fprintf(fid, '%s\n', [this_query_name, ext]);
    shortlist_str(i).Query_name = [this_query_name, ext];
    
    %score, top1(none)
    fprintf(fid, '%f %s', poses(i).score, 'N');
    shortlist_str(i).topN_name = {'N'};
    shortlist_str(i).topN_score = poses(i).score;
    
    
    %pose
    R = poses(i).R * Rutm';
    t = (ceutm * poses(i).t) - (R * tutm) - R * X2outmean;
    P_i = R_TSBDR2MVG * [R, t];
    
    for k = 1:1:12
        fprintf(fid, ' %f', P_i(k));
    end
    fprintf(fid, '\n');
    shortlist_str(i).topN_P = {P_i};
    shortlist_str(i).topN_C = {p2c(P_i)};
end
fclose(fid);
% save('-v6', shortlist_matname, 'shortlist_str');