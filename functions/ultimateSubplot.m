function [ hh ] = ultimateSubplot ( NX, NY, x, y, margx, margy )
% function [ ] = ultimateSubplot ( NX, NY, x, y, marg )
% NX, NY all plots
% x,y    coordinates of a particular plot
% marg   margin between plots
% 
% Rob Fergus fergus@robots.ox.ac.uk

if isempty(y),
    n = x;
    y = ceil(n / NX);
    x = n - (y - 1) * NX;
end 

if nargin < 6
  margy = margx;
end;

widX = 1 / (NX + (NX + 1) * margx);
widY = 1 / (NY + (NY + 1) * margy);

hh=subplot('position', [(x - 1)*widX + x*widX*margx, (NY - y) * widY + (NY - y + 1) * widY * margy, widX, widY]);

return;
     

