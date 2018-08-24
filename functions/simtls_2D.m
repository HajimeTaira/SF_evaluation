function [ R, t, c ] = simtls_2D( x1, x2 )
% c*R*x2+t = x1

x1_vec = x1(:);
x2_tran = [-x2(2, :); x2(1, :)];
A = [repmat(eye(2), size(x2, 2), 1), x2(:), x2_tran(:)];%A*k=x1_vec

[U, S, V] = svd(A);
S_inv = S;S_inv(S_inv ~= 0) = S_inv(S_inv ~= 0).^-1;
k = V * S_inv' * transpose(U) * x1_vec;

c = sqrt(k(3)^2+k(4)^2);
R = [k(3), -k(4); k(4), k(3)]/c;
t = k(1:2, :);




end

