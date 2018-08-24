clear all;
close all;

HPresults_path = '/datagrid1new/results/SanFrancisco/sattler/hyperpoints_top_100';
HP_allq = dir(fullfile(HPresults_path, '*.jpg.ranking_poses.txt'));
HPposes_name = fullfile(HPresults_path, {HP_allq.name});

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

%write shortlist
shortlist_txtname = 'inputs/shortlist_format_3';
shortlist_matname = 'outputs/SanFrancisco/shortlists/shortlist_format_3.mat';
fid = fopen(shortlist_txtname, 'w');
fprintf(fid, '100\n');
shortlist_str = struct('Query_name', {}, 'topN_name', {}, 'topN_score', {}, 'topN_P', {}, 'topN_C', {});
R_TSBDR2MVG = [1, 0, 0; 0, -1, 0; 0, 0, -1];

for i = 1:1:length(HPposes_name)
    %query name
    [~, this_query_name, ~] = fileparts(HPposes_name{i});
    [~, this_query_name, ~] = fileparts(this_query_name);
    fprintf(fid, '%s\n', this_query_name);
    shortlist_str(i).Query_name = this_query_name;
    
    this_HPpose = load_TS_hyperpoint_poses(HPposes_name{i});
    for j = 1:1:length(this_HPpose)
        fprintf(fid, '%f %s', this_HPpose(j).score, this_HPpose(j).imgname);
        shortlist_str(i).topN_score(j) = this_HPpose(j).score;
        shortlist_str(i).topN_name{j} = this_HPpose(j).imgname;
        
        %P
        R = this_HPpose(j).R * Rutm';
        t = (ceutm * this_HPpose(j).t) - (R * tutm) - R * X2outmean;
        P_j = R_TSBDR2MVG * [R, t];
%         keyboard;
        for k = 1:1:12
            fprintf(fid, ' %f', P_j(k));
        end
        fprintf(fid, '\n');
        shortlist_str(i).topN_P{j} = P_j;
        shortlist_str(i).topN_C{j} = p2c(P_j);
    end
    
end

fclose(fid);
save('-v6', shortlist_matname, 'shortlist_str');

