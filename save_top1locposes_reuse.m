%input: output_dir, shortlist_basename, shortlist_str

locposes = struct('Query_name', {}, 'P', {}, 'C', {}, 'score', {});
R_UTM_2_MVG  = [1, 0, 0; 0, 0, -1; 0, 1, 0];
for i = 1:1:length(shortlist_str)
    %Query name
    locposes(i).Query_name = shortlist_str(i).Query_name;
    %top1 pose property
    if isempty(shortlist_str(1).topN_P) == 1
        top1_PCI_gpsinfo = loadgps_from_davidchen_imgname(shortlist_str(i).topN_name{1});%pose from filename
        top1_PCI_R = R_rpy(0, top1_PCI_gpsinfo.pitch, top1_PCI_gpsinfo.yaw) * R_UTM_2_MVG;
        [E, N] = lltoutm(top1_PCI_gpsinfo.lat, top1_PCI_gpsinfo.lng);%UTM coordinate
        top1_PCI_T = -top1_PCI_R * [E; N; 0];
        locposes(i).P = [top1_PCI_R, top1_PCI_T];
        locposes(i).C = p2c(locposes(i).P);
    else
        locposes(i).P = shortlist_str(i).topN_P{1};
        locposes(i).C = shortlist_str(i).topN_C{1};
    end
    locposes(i).score = shortlist_str(i).topN_score(1);
    
end
if exist(fullfile(output_dir, 'localization_results', shortlist_basename), 'dir') ~= 7
    mkdir(fullfile(output_dir, 'localization_results', shortlist_basename));
end
save('-v6', fullfile(output_dir, 'localization_results', shortlist_basename, 'top1locposes.mat'), 'locposes');