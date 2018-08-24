%input: this_shortlist_str, dataset_dir, output_dir
%output: this_shortlist_str

dataset_imgdir = fullfile(dataset_dir, 'PCIs');
dataset_querydir = fullfile(dataset_dir, 'Query/BuildingQueryImagesCartoIDCorrected-Upright');

if exist(fullfile(output_dir, 'verification', this_shortlist_str.Query_name), 'dir') ~= 7
    mkdir(fullfile(output_dir, 'verification', this_shortlist_str.Query_name));
end

%query features
Iq = imread(fullfile(dataset_querydir, this_shortlist_str.Query_name));
[fq, dq, ~] = getFeatures(Iq);
dq = relja_rootsift(single(dq));

%for each database image in shortlist
for jj = 1:1:length(this_shortlist_str.topN_name)
    [~, thisdb_basename, ~] = fileparts(this_shortlist_str.topN_name{jj});
    if exist(fullfile(output_dir, 'verification', this_shortlist_str.Query_name, [thisdb_basename, '.mat']), 'file') == 2
        load(fullfile(output_dir, 'verification', this_shortlist_str.Query_name, [thisdb_basename, '.mat']), 'inliernum');
    else
        %database features
        Idb = imread(fullfile(dataset_imgdir, this_shortlist_str.topN_name{jj}));
        [fdb, ddb, ~] = getFeatures(Idb);
        ddb = relja_rootsift(single(ddb));
        
        %compute inliers
        [~, inliers, ~, ~] = at_sparseransac(fq,dq,fdb,ddb,2,10);
        inliernum = length(inliers);
        try
        tentative_qidx = inliers(1, :); tentative_dbidx = inliers(2, :);
        catch
            keyboard;
        end
        %flows
        flows = struct();
        flows.xq = fq(1, tentative_qidx);
        flows.yq = fq(2, tentative_qidx);
        flows.xdb = fdb(1, tentative_dbidx);
        flows.ydb = fdb(2, tentative_dbidx);
        save('-v6', fullfile(output_dir, 'verification', this_shortlist_str.Query_name, [thisdb_basename, '.mat']), 'inliernum', 'flows');
    end
    
    %update score
    this_shortlist_str.topN_score(jj) = this_shortlist_str.topN_score(jj) + inliernum;
    
    
end