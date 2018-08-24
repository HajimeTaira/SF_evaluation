clear all;
close all;

%% load current groundtruth
% merge_multiple_refposes;
% gtposes_all = poses;
load('reference_poses/reference_poses_addTM_all_598.mat');
gtposes_all = poses;

R_UTM_2_MVG  = [1, 0, 0; 0, 0, -1; 0, 1, 0];

%% Compute distance between ref. and rel. PCI
dist_relPCI = zeros(1, length(gtposes_all));
for ii = 1:1:length(gtposes_all)
    this_imgids = gtposes_all(ii).name;
    pos_ref = p2c(gtposes_all(ii).P);
    
    %load relPCI
    ann_matname = fullfile('/mnt/datagrid1/results/SanFrancisco/torii/SF_annotation_05-merge', this_imgids, 'matchesx.mat');
    load(ann_matname);relPCIimgname = pd.dn{pd.ix};
    relPCI_gpsinfo = loadgps_from_davidchen_imgname(relPCIimgname);
    [E, N] = lltoutm(relPCI_gpsinfo.lat, relPCI_gpsinfo.lng);%UTM coordinate
    pos_relPCI = [E; N; 0];
    
    dist_relPCI(ii) = norm(pos_ref(1:2) - pos_relPCI(1:2));
    fprintf('%d / %d done. \n', ii, length(gtposes_all));
end

%% Statistics
figure();
plot((1:1:length(dist_relPCI))/length(dist_relPCI)*100, sort(dist_relPCI), 'LineWidth', 2.0);
xlabel('Query [%]'); ylabel('|ref. pose - rel. PCI| [m]');