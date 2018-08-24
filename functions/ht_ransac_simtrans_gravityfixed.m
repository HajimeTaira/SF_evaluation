function [ Rout, cout, tout, siminls ] = ht_ransac_simtrans_gravityfixed( x1, x2, g2, rthr )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

g1 = [0; 0; 1];

%1. fit gravity
n = cross(g2, g1);n = n / norm(n);
theta = acos(g2'*g1);
R_grav = R_Rodrigues( n, theta );
x2_gfit = R_grav * x2;


%2. similarity transform (ransac)
Npts = size(x1, 2);
max_i = 2;
max_sam = 1000;
no_sam = 0;
rthr = rthr^2;
Rsim = eye(3);
tsim = zeros(3, 1);
csim = 1;
siminls = zeros(1, Npts);
while no_sam < max_sam
    no_sam = no_sam + 1;
    idx = randperm(Npts, 2);
    
    [Re, te, ce, inls, d] = ht_estimatemodel_3d_gravityconst(x1, x2_gfit, idx, rthr);
    no_i = sum(inls);
    
    if no_i > 2
        lo_cnt = 0;
        while lo_cnt < 10
            lo_cnt = lo_cnt + 1;
            [lo_Re, lo_te, lo_ce, lo_inls, lo_d] = ht_estimatemodel_3d_gravityconst(x1, x2_gfit, inls, rthr);
            lo_no_i = sum(lo_inls);
            if lo_no_i >= no_i
                no_i = lo_no_i;
                Re = lo_Re;
                te = lo_te;
                ce = lo_ce;
                inls = lo_inls;
            else
                break;
            end
        end
    end
    
    if no_i >= max_i
        max_i = no_i;
        Rsim = Re;
        tsim = te;
        csim = ce;
        siminls = inls;
        max_sam = min([max_sam, nsamples(max_i, Npts, 2, 0.95)]);
    end
end


%4. output
cout = csim;
Rout = Rsim * R_grav;
tout = tsim;


end

function [Re, te, ce, inls, d] = ht_estimatemodel_3d_gravityconst(x1, x2, idx, rthr)
    [Re, te, ce] = simtls_3D_gravityconst(x1(:, idx), x2(:, idx));
    d = sum((x1 - bsxfun(@plus, ce*Re*x2, te)).^2, 1);
    inls = d < rthr;
end

function [SampleCnt, q] = nsamples(ni, ptNum, pf, conf)
    q  = prod (((ni-pf+1) : ni) ./ ((ptNum-pf+1) : ptNum));
    if q < eps
      SampleCnt = Inf;
    else
      %   SampleCnt  = log(1 - conf) / log(1 - q);
      if q > conf
        SampleCnt = 1;
      else
        SampleCnt  = log(1 - conf) / log(1 - q);
      end
    end
end

