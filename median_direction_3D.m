function [ med_vec ] = median_direction_3D( vectors )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

%polar coordinates
phi = asin(vectors(2, :));
theta = atan2(vectors(1, :), vectors(3, :));

med_phi = median(phi);
med_theta = median(theta);

med_vec = [cos(med_phi) .* sin(med_theta); ...
           sin(med_phi); ...
           cos(med_phi) .* cos(med_theta)];

end

