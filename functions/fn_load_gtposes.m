function [ gtposes_all ] = fn_load_gtposes( gt )
%FN_LOAD_GTPOSES Summary of this function goes here
%   Detailed explanation goes here

%bundler
% bundler_leftR = [1, 0, 0; 0, -1, 0; 0, 0, -1];

gtposes_all = struct('name', {}, 'exist', {}, 'pd_exist', {}, 'R', {}, 't', {}, 'P', {}, 'C', {}, 'UTM', {}, 'pd', {}, 'ps', {});
for i = 1:1:size(gt.names, 1)
    sprintf('Query %d (%s): START. ', i, gt.names(i, :))
    gtposes_all(i).name = gt.names(i, :);
    %load groundtruth
    try
        load(fullfile(gt.dir, gt.names(i, :), gt.posematname));%pp, pd, ps
        
    catch 
        gtposes_all(i).exist = 0;
        
        if exist(fullfile(gt.dir, gt.names(i, :), gt.matchesxmatname), 'file') == 2
            load(fullfile(gt.dir, gt.names(i, :), gt.matchesxmatname));%pd
            gtposes_all(i).pd = pd;
            gtposes_all(i).pd_exist = 1;
        else
            gtposes_all(i).pd_exist = 0;
        end
        
        fprintf('Skipped. \n');
        continue;
    end
    
%     %consistency check
%     dfn = pd.dn{pd.ix};
%     id = strfind(dfn,'_');
%     
%     dlat = str2double(dfn(id(3)+1:id(4)-1));
%     dlon = str2double(dfn(id(4)+1:id(5)-1));
%     [ux,uy] = lltoutm(dlat,dlon);
%     d = sqrt((pp.qutm(1,1) - ux)^2 + (pp.qutm(2,1) - uy)^2);
%     if d >= 200
%         gtposes_all(i).exist = 0;
%         fprintf('Skipped. \n');
%         continue;
%     end
    
%     %store information
%     gtposes_all(i).exist = 1;
%     gtposes_all(i).K = pp.Kq;
%     gtposes_all(i).R = bundler_leftR * pp.Rq;
%     gtposes_all(i).t = bundler_leftR * pp.Tq;
%     gtposes_all(i).C = -gtposes_all(i).R^-1 * gtposes_all(i).t;
%     gtposes_all(i).UTM = pp.qutm;
%     gtposes_all(i).ll = pp.qlatlon';
    

    %store information
    gtposes_all(i).exist = 1;
    gtposes_all(i).pd_exist = 1;
    gtposes_all(i).R = pp.P(1:3, 1:3);
    gtposes_all(i).t = pp.P(:, 4);
%     gtposes_all(i).R = bundler_leftR * pp.P(1:3, 1:3);
%     gtposes_all(i).t = bundler_leftR * pp.P(:, 4);
    gtposes_all(i).P = [gtposes_all(i).R, gtposes_all(i).t];
    gtposes_all(i).C = -gtposes_all(i).R^-1 * gtposes_all(i).t;
    gtposes_all(i).UTM = pp.qutm;
    gtposes_all(i).pd = pd;
    gtposes_all(i).ps = ps;

    sprintf('Query %d (%s): DONE. ', i, gt.names(i, :))
end


end

