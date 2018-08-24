function [ Cameras, Points ] = readNVM( NVMpath )
%READNVM この関数の概要をここに記述
%   詳細説明をここに記述

fid = fopen(NVMpath);

Data_all = textscan(fid, '%s', 'Delimiter', '\n');
Data_all = Data_all{1};

%read properties
cpose_type = Data_all{1};
cnum = str2double(Data_all{3});
Data_cameras = Data_all(4:(3+cnum));
pnum = str2double(Data_all{3+cnum+2});
Data_points = Data_all((3+cnum+3):(3+cnum+2+pnum));
clear Data_all;
fclose(fid);

%read cameras
Cameras = struct('path', {}, 'R', {}, 't', {}, 'fl', {}, 'distortion', {});
if length(cpose_type) == 7
    if all(cpose_type == 'NVM_V3 ')%quaternion
        qflag = 1;
    else
        disp('Not nvm file');
        return;
    end
else
    disp('TODO');
    qflag = 0;
end

for cidx = 1:1:cnum
    this_c = Data_cameras{cidx};
    this_c = strsplit(this_c, '\t');
    
    Cameras(cidx).path = this_c{1};
    
    this_c = str2double(strsplit(this_c{2}, ' '));
    
    Cameras(cidx).fl = this_c(1);
    if qflag == 1
        Cameras(cidx).position = this_c(6:8)';
        Cameras(cidx).R = qtr2rot(this_c(2:5));
        Cameras(cidx).t = - Cameras(cidx).R * Cameras(cidx).position;
        Cameras(cidx).distortion = this_c(9);
    else
        disp('TODO');
    end
    
end




%read points
Points = struct('X', {}, 'Y', {}, 'Z', {}, 'R', {}, 'G', {}, 'B', {}, 'tracknum', {}, 'imgidx', {}, 'fidx', {}, 'u', {}, 'v', {});

for pidx = 1:1:pnum
    this_p = Data_points{pidx};
    this_p = str2double(strsplit(this_p, ' '));
    
    Points(pidx).X = this_p(1);
    Points(pidx).Y = this_p(2);
    Points(pidx).Z = this_p(3);
    
    Points(pidx).R = this_p(4);
    Points(pidx).G = this_p(5);
    Points(pidx).B = this_p(6);
    
    Points(pidx).tracknum = this_p(7);
    
    this_nviews = this_p(8:(end-1));
    this_nviews = reshape(this_nviews, 4, []);
    Points(pidx).imgidx = this_nviews(1, :) + 1;
    Points(pidx).fidx = this_nviews(2, :) + 1;
    Points(pidx).u = this_nviews(3, :);
    Points(pidx).v = this_nviews(4, :);
    
end


end

