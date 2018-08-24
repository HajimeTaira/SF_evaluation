function [ R ] = R_x( phi )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

R = [1, 0, 0; ...
    0, cos(phi), -sin(phi); ...
    0, sin(phi), cos(phi)];

end

