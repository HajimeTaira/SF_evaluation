function [ R ] = R_Rodrigues( n, theta )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

R1 = n * transpose(n) * (1 - cos(theta));
R2 = [cos(theta), -n(3)*sin(theta), n(2)*sin(theta); ...
      n(3)*sin(theta), cos(theta), -n(1)*sin(theta); ...
      -n(2)*sin(theta), n(1)*sin(theta), cos(theta)];
  
R = R1 + R2;


end

