clear all;
close all;

%user define%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
dataset_name = 'SanFrancisco';

%initial top1 localization
% shortlist_basename = 'densevlad_gpsinit_uncertainty50_neighbor100_SR';
% shortlist_basename = 'shortlist_disloc_interplace';
% shortlist_basename = 'shortlist_netvlad_SR';
shortlist_basename = 'densevlad_gpsinit_uncertainty50_neighbor60_SR';
shortlist_basename = 'densevlad_gpsinit_uncertainty50_neighbor180_SR';
shortlist_basename = 'densevlad_gpsinit_uncertainty50_neighbor200_SR';
top1_matname = fullfile('outputs', dataset_name, 'localization_results', shortlist_basename, 'top1locposes.mat');

%sfm results (nvm)
% colmap_dir = fullfile('outputs', dataset_name, 'colmap_results', shortlist_basename, 'all');
range = 25;
colmap_dir = fullfile('outputs', dataset_name, 'colmap_results', shortlist_basename, sprintf('range%d', range));

PCI_header = 'PCI_sp_';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%output%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
output_dir = fullfile('outputs', dataset_name);

% recon_dir = fullfile(output_dir, 'recon_from_shortlist_colmap', shortlist_basename, 'all');
recon_dir = fullfile(output_dir, 'recon_from_shortlist_colmap', shortlist_basename, sprintf('range%d', range));
query_matname = 'query.mat';
PCI_matname = 'PCI.mat';
Points_matname = 'Points3D.mat';
trns_matname = 'COLMAP2UTMtrns.mat';

% output_localization_name = fullfile('outputs', dataset_name, 'localization_results', shortlist_basename, 'localsfmrangeinflocposes_colmap.mat');
output_localization_name = fullfile('outputs', dataset_name, 'localization_results', shortlist_basename, sprintf('localsfmrange%dlocposes_colmap.mat', range));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% load shortlist
load_save_shortlist_reuse;
%load top1 poses
load(top1_matname);%locposes

%% localsfm pose
for i = 1:1:length(locposes)
    this_locposes = locposes(i);
    
    %Load colmap result
    this_colmap_path = fullfile(colmap_dir, this_locposes.Query_name, '0');
    this_colmap_output_path = fullfile(recon_dir, this_locposes.Query_name);
    
    if exist(fullfile(this_colmap_output_path, PCI_matname), 'file') ~= 2
        try
            %a. images
            Images_colmap = load_colmap_images( this_colmap_path );
            %b. cameras
            Cameras_colmap = load_colmap_cameras( this_colmap_path );
            [~, id] = sort([Cameras_colmap.camid], 'ascend');
            Cameras_colmap = Cameras_colmap(id);
            %c. points
            Points_colmap = load_colmap_points3D( this_colmap_path );
        catch
            Images_colmap = [];
            Cameras_colmap = [];
            Points_colmap = [];
        end

        if size(Images_colmap, 2) == 0
            continue;
        end

        %find query and PCI
        this_rcnnames = {Images_colmap.name};
        camid_all = [Cameras_colmap.camid];
        %a. query
        isQrcn = strcmp(this_locposes.Query_name, this_rcnnames);
        imQrcn = Images_colmap(isQrcn);
        if sum(isQrcn) > 0
            imQ_camid = [Images_colmap(isQrcn).camid];
            camQrcn = Cameras_colmap(camid_all == imQ_camid);
        else
            camQrcn = [];
        end
        %b. PCI
        isPCIrcn = ~isQrcn;
        imPCIrcn = Images_colmap(isPCIrcn);
        if sum(isPCIrcn) > 0
            imPCI_camid = [Images_colmap(isPCIrcn).camid];
            [idx, ~] = find(repmat(camid_all', 1, sum(isPCIrcn)) == repmat(imPCI_camid, length(camid_all), 1));
            camPCIrcn = Cameras_colmap(idx);
        else
            camPCIrcn = [];
        end

        %save reconstruction
        if exist(this_colmap_output_path, 'dir') ~= 7
            mkdir(this_colmap_output_path);
        end
        save('-v6', fullfile(this_colmap_output_path, query_matname), 'isQrcn', 'imQrcn', 'camQrcn');
        save('-v6', fullfile(this_colmap_output_path, PCI_matname), 'isPCIrcn', 'imPCIrcn', 'camPCIrcn');
        save('-v6', fullfile(this_colmap_output_path, Points_matname), 'Points_colmap');
    else
        load(fullfile(this_colmap_output_path, query_matname), 'isQrcn', 'imQrcn', 'camQrcn');
        load(fullfile(this_colmap_output_path, PCI_matname), 'isPCIrcn', 'imPCIrcn', 'camPCIrcn');
        load(fullfile(this_colmap_output_path, Points_matname), 'Points_colmap');
    end
    
    %compute similarity transform
    if exist(fullfile(this_colmap_output_path, trns_matname), 'file') ~= 2
        if sum(isQrcn)>0 && sum(isPCIrcn)>=2
            %PCI gravity approximation
            PCI_rcn = [imPCIrcn.position];
            PCI_utm = zeros(3, sum(isPCIrcn));
            PCI_gravity_all = zeros(3, sum(isPCIrcn));
            for ii = 1:1:sum(isPCIrcn)
                PCI_gpsinfo = loadgps_from_davidchen_imgname(imPCIrcn(ii).name);
                [PCI_utm(1, ii), PCI_utm(2, ii)] = lltoutm(PCI_gpsinfo.lat, PCI_gpsinfo.lng);
                PCI_gravity_all(:, ii) = imPCIrcn(ii).R' * R_x(-PCI_gpsinfo.pitch*pi/180) * [0; -1; 0];
            end
            PCI_gravity = median_direction_3D(PCI_gravity_all);
            
            %LO-RANSAC
            [Rout, ceout, tout, output_inls] = ht_ransac_simtrans_gravityfixed(PCI_utm, PCI_rcn, PCI_gravity, 1);
        else
            Rout = [];
            ceout = [];
            tout = [];
            output_inls = [];
        end
        
        if sum(output_inls) > 0
            gravity = PCI_gravity;
            save('-v6', fullfile(this_colmap_output_path, trns_matname), 'Rout', 'ceout', 'tout', 'gravity', 'output_inls');
%             [R, t] = extrinsic_coordtrans(imQrcn.R, imQrcn.t, Rout, tout, ceout);
%             PQ_UTM = [R, t];
%             save('-v6', fullfile(this_colmap_output_path, names.colmap.PQ_PCI_matname), 'PQ_UTM');
        end
        
    else
        load(fullfile(this_colmap_output_path, trns_matname), 'Rout', 'ceout', 'tout', 'gravity', 'output_inls');
    end
    
    %Compute query 6DoF pose
    if sum(output_inls) > 0
        [R, t] = extrinsic_coordtrans(imQrcn.R, imQrcn.t, Rout, tout, ceout);
        locposes(i).P = [R, t];
        locposes(i).C = p2c(locposes(i).P);
        locposes(i).score = locposes(i).score + sum(output_inls);
    end
    fprintf('%s DONE.\n', this_locposes.Query_name);
end

%% save localization results
save('-v6', output_localization_name, 'locposes');
