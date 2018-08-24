function [Rout, ceout, tout, output_inls] = at_ransac_similaritytransform(X1,X2,rthr)

Npts = size(X1,2);
max_i = 0;
max_sam = 1000;
no_sam = 0;
Rout = eye(3);
ceout = zeros(3, 1);
tout = zeros(3, 1);
output_inls = zeros(1, length(X1));

rthr = rthr^2; % errors are squared

while no_sam < max_sam
  no_sam = no_sam + 1;
  idx = randperm(Npts,3);

  [Re, te, ce, inl, d] = at_estimatemodel(X1,X2,idx,rthr);
  no_i = sum(inl);
  fprintf('itr=%03d, error=%.2f, no_i=%d\n',no_sam,mean(d(inl)),no_i);

  if no_i > 3
    lo_cnt = 0;
    while lo_cnt < 10
      lo_cnt = lo_cnt+1;
      [lo_Re, lo_te, lo_ce, lo_inl, lo_d] = at_estimatemodel(X1,X2,inl,rthr);
      lo_no_i = sum(lo_inl);
      fprintf('itr=%03d, error=%.2f, lo_no_i=%d, lo_itr=%03d\n',no_sam,mean(lo_d(lo_inl)),lo_no_i,lo_cnt);
      if lo_no_i > no_i
        no_i = lo_no_i;
        Re = lo_Re;
        te = lo_te;
        ce = lo_ce;
        inl = lo_inl;
      else
        break;
      end
    end
  end
  
  if no_i > max([max_i 3])
    max_i = no_i;
    Rout = Re;
    tout = te;
    ceout = ce;
    output_inls = inl>0;    
    max_sam = min([max_sam, nsamples(max_i, Npts, 3, 0.95)]);
  end
end

fprintf('\n3D point fitting found: %d inliers (%2.2f%%)\n  Number of samples: %d\n',...
  max_i, 100*max_i/Npts, no_sam);


function [Re, te, ce, inl, d] = at_estimatemodel(X1,X2,idx,rthr)
[Re, te, ce] = simtls([X2(:,idx); X1(:,idx)]);
X2c = bsxfun(@plus,(ce*Re)*X2,te);
d = sum((X1 - X2c).^2,1); 
inl = d < rthr;
  

%SampleCnt calculates number of samples needed to be done
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
  end;
end;

