function [ t ] = translation_leastsq( x1, x2 )
%UNTITLED3 Summary of this function goes here
% x2 + t = x1


A = repmat(eye(3), size(x2, 2), 1);
b = x1(:)-x2(:);%A*[tx, ty, tz]-b=0

[U, S, V] = svd(A);
S_inv = S;S_inv(S_inv ~= 0) = S_inv(S_inv ~= 0).^-1;
t = V * S_inv' * transpose(U) * b;



end

