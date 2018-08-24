function [ R, t, c ] = simtls_3D_gravityconst( x1, x2 )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

%warning: If x1(3, :)~=0, this algorithm would don't work!

b = x1; b(3, :) = b(3, :) - x2(3, :);
b = b(:);

x2_XY = [x2(1:2, :); zeros(1, size(x2, 2))]; x2_XY = x2_XY(:);
x2_XY_tran = [-x2(2, :); x2(1, :); zeros(1, size(x2, 2))]; x2_XY_tran = x2_XY_tran(:);
A = [repmat(eye(3), size(x2, 2), 1), x2_XY, x2_XY_tran];%A*k=b

[U, S, V] = svd(A);
S_inv = S;S_inv(S_inv ~= 0) = S_inv(S_inv ~= 0).^-1;
k = V * S_inv' * transpose(U) * b;

c = sqrt(k(4)^2+k(5)^2);
R = [k(4), -k(5); k(5), k(4)]/c;
R = [R, zeros(2, 1); 0, 0, 1];
t = [k(1:2, :); k(3, :)*c];
% t = k(1:3, :)*c;


end

