%input: output_dir, shortlist_basename, qfnames_matname, dbfnames_matname, scores_matname
%output: shortlist_str
R_UTM_2_MVG  = [1, 0, 0; 0, 0, -1; 0, 1, 0];

shortlist_matname = fullfile(output_dir, 'shortlists', [shortlist_basename, '.mat']);

if exist(shortlist_matname, 'file') == 2
    load(shortlist_matname);
else
    %load qlist, dblist, score
    load(qfnames_matname, 'qfnames');
    load(dbfnames_matname, 'dbfnames');
    load(scores_matname, 'score');
    
    %load reference pose
    refpose_matname = 'reference_poses/reference_poses_addTM_all_598.mat';
    load(refpose_matname, 'poses');
    
    %compute query psuedo gps position
    query_psuedogps_matname = sprintf('query_psuedoGPS_uncertainty%d.mat', gps_uncertainty);
    if exist(query_psuedogps_matname, 'file') ~= 2
        qname_gps = cell(1, length(poses));
        psuedo_UTM = zeros(2, length(poses));
        for ii = 1:1:length(poses)
            qname_gps{ii} = [poses(ii).name, '.jpg'];
            this_UTM = p2c(poses(ii).P);
            randori = rand(1)*2*pi;
            gpsnoise = rand(1)*gps_uncertainty * [cos(randori); sin(randori)];
            psuedo_UTM(:, ii) = this_UTM(1:2) + gpsnoise;
%             psuedo_UTM(:, ii) = this_UTM(1:2) + rand(2, 1)*2*gps_uncertainty - gps_uncertainty;
        end
        
        save('-v6', query_psuedogps_matname, 'qname_gps', 'psuedo_UTM');
    else
        load(query_psuedogps_matname, 'qname_gps', 'psuedo_UTM');
    end
    
    %load db position
    dbposall_matname = 'dbUTMall.mat';
    if exist(dbposall_matname, 'file') ~= 2
        Pdb = cell(1, length(dbfnames));
        Cdb = zeros(3, length(dbfnames));
        for ii = 1:1:length(dbfnames)
            PCI_gpsinfo = loadgps_from_davidchen_imgname([dbfnames{ii}, '.jpg']);%pose from filename
            PCI_R = R_rpy(0, PCI_gpsinfo.pitch, PCI_gpsinfo.yaw) * R_UTM_2_MVG;
            [E, N] = lltoutm(PCI_gpsinfo.lat, PCI_gpsinfo.lng);%UTM coordinate
            PCI_T = -PCI_R * [E; N; 0];
            Pdb{ii} = [PCI_R, PCI_T];
            Cdb(:, ii) = p2c(Pdb{ii});
        end
        
        save('-v6', dbposall_matname, 'Pdb', 'Cdb', 'dbfnames');
    else
        load(dbposall_matname, 'Cdb');
    end
    
%     %debug
%     figure();
%     scatter(Cdb(1, :), Cdb(2, :), 5, 'filled');hold on;axis equal;
%     scatter(psuedo_UTM(1, :), psuedo_UTM(2, :), 30, 'filled');
%     keyboard;
    
    %edit shortlist
    shortlist_str = struct('Query_name', {}, 'topN_name', {}, 'topN_score', {}, 'topN_P', {}, 'topN_C', {});
    isqgpsexist = false(1, size(score, 1));
    for ii = 1:1:size(score, 1)
        this_qname = strsplit(qfnames{ii}, '/');this_qname = this_qname{end};
        
        isthisq = strcmp(this_qname, qname_gps);
        isqgpsexist(ii) = any(isthisq);
        if ~isqgpsexist(ii); continue; end
        
        %qname
        
        
        %db shortlist
        this_qgps = psuedo_UTM(:, isthisq);
        
        dbdist = pdist2(this_qgps', Cdb(1:2, :)');
        if sum(dbdist < neighbor_r) == 0
            neighbordblist = strcat(dbfnames, '.jpg');
            neighbordbscore = score(ii, :);neighbordbscore(isnan(neighbordbscore)) = 0;
            neighbordbdist = dbdist;
        else
            neighbordbdist = dbdist(dbdist < neighbor_r);
            neighbordblist = strcat(dbfnames(dbdist < neighbor_r), '.jpg');
            neighbordbscore = score(ii, dbdist < neighbor_r);neighbordbscore(isnan(neighbordbscore)) = 0;
        end
        
        
        %debug
%         figure();
%         scatter(this_qgps(1), this_qgps(2), 'filled');hold on;
%         scatter(Cdb(1, dbdist<50), Cdb(2, dbdist<50), 'filled');
%         keyboard;
%         figure();
%         [nnPCIdist, nnPCIidx] = sort(neighbordbdist, 'ascend');
%         subplot(2, 1, 1);imshow(imread(fullfile('/datagrid5new/SanFrancisco/Query/BuildingQueryImagesCartoIDCorrected-Upright', this_qname)));
%         for jj = 1:1:100
%             subplot(2, 1, 2);imshow(imread(fullfile('/datagrid5new/SanFrancisco/PCIs', neighbordblist{nnPCIidx(jj)})));
%             title(sprintf('%.4f', neighbordbscore(nnPCIidx(jj))));
%             keyboard;
%         end
%         figure();
%         [nnPCIdist, nnPCIidx] = sort(neighbordbscore, 'descend');
%         subplot(2, 1, 1);imshow(imread(fullfile('/datagrid5new/SanFrancisco/Query/BuildingQueryImagesCartoIDCorrected-Upright', this_qname)));
%         for jj = 1:1:100
%             subplot(2, 1, 2);imshow(imread(fullfile('/datagrid5new/SanFrancisco/PCIs', neighbordblist{nnPCIidx(jj)})));
%             title(sprintf('%.4f', neighbordbscore(nnPCIidx(jj))));
%             keyboard;
%         end
        
        
        
        [neighbordbscore_sorted, idx] = sort(neighbordbscore, 'descend');
        neighbordblist_sorted = neighbordblist(idx);
        
        length_shortlist = min(length(neighbordblist_sorted), 200);
        shortlist_str(ii).Query_name = this_qname;
        shortlist_str(ii).topN_name = neighbordblist_sorted(1:1:length_shortlist);
        shortlist_str(ii).topN_score = neighbordbscore_sorted(1:1:length_shortlist);
        
%         %debug: evaluate top1
%         top1dist(ii) = neighbordbdist(idx(1));
        
        fprintf('%d done. \n', ii);
        
%         %debug
%         figure();
%         subplot(2, 1, 1);imshow(imread(fullfile('/datagrid5new/SanFrancisco/Query/BuildingQueryImagesCartoIDCorrected-Upright', shortlist_str(ii).Query_name)));
%         for jj = 1:100
%             subplot(2, 1, 2);imshow(imread(fullfile('/datagrid5new/SanFrancisco/PCIs', shortlist_str(ii).topN_name{jj})));
%             title(sprintf('%.4f', shortlist_str(ii).topN_score(jj)));
%             keyboard;ii
%         end
    end
    shortlist_str = shortlist_str(isqgpsexist);
    
%     %debug
%     top1dist = top1dist(isqgpsexist);
%     figure();
%     plot(sort(top1dist, 'ascend'), [1:1:length(top1dist)] / length(top1dist));
%     xlim([0 30]);
%     keyboard;
    
    
    if exist(fullfile(output_dir, 'shortlists'), 'dir') ~= 7
        mkdir(fullfile(output_dir, 'shortlists'));
    end
    save('-v6', shortlist_matname, 'shortlist_str');
end