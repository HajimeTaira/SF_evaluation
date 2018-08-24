clear all;
close all;

%user define%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
dataset_name = 'SanFrancisco';

%initial top1 localization
shortlist_basename = 'densevlad_gpsinit_uncertainty50_neighbor100_SR';
top1_matname = fullfile('outputs', dataset_name, 'localization_results', shortlist_basename, 'top1locposes.mat');

%sfm results (nvm)
nvm_dir = fullfile('outputs', dataset_name, 'nvm_from_imgsubsets', shortlist_basename, 'all');
% range = 25;
% nvm_dir = fullfile('outputs', dataset_name, 'nvm_from_imgsubsets', shortlist_basename, sprintf('range%d', range));
nvm_ext = '.nvm';

PCI_header = 'PCI_sp_';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%output%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
output_dir = fullfile('outputs', dataset_name);
%1. reconstruction results
recon_dir = fullfile(output_dir, 'recon_from_shortlist', shortlist_basename, 'all');
% recon_dir = fullfile(output_dir, 'recon_from_shortlist', shortlist_basename, sprintf('range%d', range));
query_matname = 'query.mat';
PCI_matname = 'PCI.mat';
Points_matname = 'Points3D.mat';
trns_matname = 'NVM2UTMtrns.mat';

output_localization_name = fullfile('outputs', dataset_name, 'localization_results', shortlist_basename, 'localsfmrangealllocposes.mat');
% output_localization_name = fullfile('outputs', dataset_name, 'localization_results', shortlist_basename, sprintf('localsfmrange%dlocposes.mat', range));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%
%load shortlist
load_save_shortlist_reuse;
%load top1 poses
load(top1_matname);%locposes

%%
%refinement by loading sfm
for i = 1:1:length(locposes)
    this_output_dir = fullfile(recon_dir, locposes(i).Query_name);
    
    %try to load nvm
    this_nvm_name = fullfile(nvm_dir, [locposes(i).Query_name, nvm_ext]);
    if exist(fullfile(this_output_dir, query_matname), 'file') == 2
        load(fullfile(this_output_dir, query_matname));
        load(fullfile(this_output_dir, PCI_matname));
    else
        try
            [Cameras, Points] = readNVM(this_nvm_name);
        catch
%             keyboard;
            continue;
        end
        
        %parse reconstruction
        basename_rcn = cell(1, length(Cameras));
        for j = 1:1:length(Cameras)
            [~, basename_rcn{j}, ~] = fileparts(Cameras(j).path);
        end
        %1. query
        [~, qbasename, ~] = fileparts(locposes(i).Query_name);
        isQrcn = strcmp(qbasename, basename_rcn);
        camQrcn = Cameras(isQrcn);
        %2. PCI
        isPCIrcn = strncmp(PCI_header, basename_rcn, 6);
        camPCIrcn = Cameras(isPCIrcn);
        %save reconstruction
        if exist(this_output_dir, 'dir') ~= 7
            mkdir(this_output_dir);
        end
        save('-v6', fullfile(this_output_dir, query_matname), 'isQrcn', 'camQrcn');
        save('-v6', fullfile(this_output_dir, PCI_matname), 'isPCIrcn', 'camPCIrcn');
        save('-v6', fullfile(this_output_dir, Points_matname), 'Points');
    end
    
    %check reconstruction
    %1: query
    if sum(isQrcn) == 0
        continue;
    end
    %2: PCI
    if sum(isPCIrcn) < 3
        continue;
    end
    
    %Prepare for similarity transform
    %PCI position (database)
    PCIpos_utm = zeros(3, length(camPCIrcn));
    PCI_gravity_all = zeros(3, sum(isPCIrcn));
    for j = 1:1:length(camPCIrcn)
        PCI_gpsinfo = loadgps_from_davidchen_imgname(camPCIrcn(j).path);
        [PCI_utme, PCI_utmn] = lltoutm(PCI_gpsinfo.lat, PCI_gpsinfo.lng);
        PCIpos_utm(:, j) = [PCI_utme; PCI_utmn; 0];   
        PCI_gravity_all(:, j) = camPCIrcn(j).R' * R_x(-PCI_gpsinfo.pitch*pi/180) * [0; -1; 0];
    end
    %PCI position (recostruction)
    PCIpos_rcn = [camPCIrcn.position];
    
    %similarity transform
    if exist(fullfile(this_output_dir, trns_matname), 'file') == 2
        load(fullfile(this_output_dir, trns_matname));%Rout, ceout, tout, output_inls
    else
%         [Rout, ceout, tout, output_inls] = at_ransac_similaritytransform(PCIpos_utm, PCIpos_rcn, 1);
        PCI_gravity = median_direction_3D(PCI_gravity_all);
        [Rout, ceout, tout, output_inls] = ht_ransac_simtrans_gravityfixed(PCIpos_utm, PCIpos_rcn, PCI_gravity, 1);
        if sum(output_inls) == 0
            continue;
        end
        save('-v6', fullfile(this_output_dir, trns_matname), 'Rout', 'ceout', 'tout', 'output_inls');
    end
    
    %estimate query pose from reconstruction
    locposes(i).score = locposes(i).score + sum(output_inls);
    [R, T] = extrinsic_coordtrans( camQrcn.R, camQrcn.t, Rout, tout, ceout );
    locposes(i).P = [R, T];
    locposes(i).C = p2c(locposes(i).P);
    
    fprintf('%s done. \n', locposes(i).Query_name);
end

%save localization
save('-v6', output_localization_name, 'locposes');



