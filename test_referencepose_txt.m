clear all;
close all;

%user define%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
dataset_name = 'SanFrancisco';

%current groundtruth
pass = 'pass0';
gt.dir = sprintf('/datagrid1new/results/%s/torii/SF_annotation_05-merge', dataset_name);
% gt.dir = sprintf('/datagrid1new/results/%s/taira/SF_annotation_05-merge_htsim', dataset_name);%new, 467 poses
gt.names = num2str(transpose(0:1:802), '%04g');
gt.posematname = sprintf('%s.newrot.inl010.res003.pos010.ori015.fiveposes.mat', pass);
gt.matchesxmatname = 'matchesx.mat';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%output%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
output_gt_txtname = 'reference_poses/reference_poses_442.txt';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%load current groundtruth
[ gtposes_all ] = fn_load_gtposes( gt );
valuable_idx = logical([gtposes_all.exist]);
gtposes_all = gtposes_all(valuable_idx);

fid = fopen(output_gt_txtname, 'w');

%header
fprintf(fid, '# ["0 <image name> <1x4 quaternion> <1x3 camera position>"] x %d images. \n', length(gtposes_all));
for i = 1:1:length(gtposes_all)
    this_gtpose = gtposes_all(i);
    
    %R->q
    this_q = rot2qtr(this_gtpose.P(1:3, 1:3));
    fprintf(fid, '0 %s %.16f %.16f %.16f %.16f %.16f %.16f %.16f\n', ...
            this_gtpose.name, ...
            this_q(1), this_q(2), this_q(3), this_q(4), ...
            this_gtpose.C(1), this_gtpose.C(2), this_gtpose.C(3));
        
    
    
end

fclose(fid);

% %%
% %output%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% output_simtr_txtname1 = 'sf0gpsaligned2utm_simtrns.txt';
% output_simtr_txtname2 = 'sf0bundler2utm_simtrns.txt';
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% %precomputed similarity transform (bundler -> UTM)
% S1_matfullpath = '/datagrid5new/SanFrancisco/sf0gpsalined_to_utm.mat';
% S2_matfullpath = '/datagrid5new/SanFrancisco/sf0bundler_to_utm.mat';
% %Load precomputed similarity transform
% load(S2_matfullpath, 'Rutm', 'tutm', 'ceutm', 'cam', 'utm_pci');
% X1 = [utm_pci; zeros(1,size(utm_pci,2))];
% X1mean = mean(X1,2);
% X1center = bsxfun(@minus,X1,X1mean);
% X2 = bsxfun(@minus,cam,mean(cam,2));
% X2out = bsxfun(@plus,(ceutm*Rutm)*X2,tutm+X1mean);
% X2outmean = mean(X2out,2);%????????
% clear Rutm tutm ceutm cam utm_pci;
% load(S1_matfullpath, 'Rutm', 'tutm', 'ceutm');
% 
% 
% %gpsaligned to utm
% c_tr = ceutm;
% R_tr = Rutm;
% t_tr = tutm + X2outmean;
% 
% fid = fopen(output_simtr_txtname1, 'w');
% 
% fprintf(fid, '%.16f\n', c_tr);
% 
% fprintf(fid, '%.16f %.16f %.16f\n', R_tr(1,1), R_tr(1,2), R_tr(1,3));
% fprintf(fid, '%.16f %.16f %.16f\n', R_tr(2,1), R_tr(2,2), R_tr(2,3));
% fprintf(fid, '%.16f %.16f %.16f\n', R_tr(3,1), R_tr(3,2), R_tr(3,3));
% 
% fprintf(fid, '%.16f\n%.16f\n%.16f\n', t_tr(1), t_tr(2), t_tr(3));
% 
% fclose(fid);
% 
% 
% 
% %sf0bundler to utm
% load(S2_matfullpath, 'Rutm', 'tutm', 'ceutm', 'cam', 'utm_pci');
% X1 = [utm_pci; zeros(1,size(utm_pci,2))];
% X1mean = mean(X1,2);
% 
% c_tr = ceutm;
% R_tr = Rutm;
% t_tr = tutm+X1mean - ceutm*Rutm * mean(cam,2);
% 
% fid = fopen(output_simtr_txtname2, 'w');
% 
% fprintf(fid, '%.16f\n', c_tr);
% 
% fprintf(fid, '%.16f %.16f %.16f\n', R_tr(1,1), R_tr(1,2), R_tr(1,3));
% fprintf(fid, '%.16f %.16f %.16f\n', R_tr(2,1), R_tr(2,2), R_tr(2,3));
% fprintf(fid, '%.16f %.16f %.16f\n', R_tr(3,1), R_tr(3,2), R_tr(3,3));
% 
% fprintf(fid, '%.16f\n%.16f\n%.16f\n', t_tr(1), t_tr(2), t_tr(3));
% 
% fclose(fid);
% 
% 
% 
% 
% 
% 
% 
% 
