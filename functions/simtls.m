function [R, t, c] = simtls(X)
% [R t c] = simtls(X)
% S. Umeyama: Least-Squares Estimation of Transformation Parameters
% Between Two Point Patterns, PAMI 1991

m1 = mean(X(1:3,:),2);
m2 = mean(X(4:6,:),2);
d1 = X(1:3,:)-repmat(m1,1,size(X,2));
d2 = X(4:6,:)-repmat(m2,1,size(X,2));
v1 = mean(sum(d1.^2));
%v2 = mean(sum(d2.^2));

cor = zeros(3,3);
for i=1:size(X,2)
  cor = cor + d2(:,i)*d1(:,i)';
end
cor = cor/size(X,2);

[U, D, V] = svd(cor);

if abs(det(cor)) < 100*eps
  if det(U)*det(V) > 0
    S = eye(3);
  else
    S = diag([1 1 -1]);
  end
elseif det(cor) > 0
  S = eye(3);
else
  S = diag([1 1 -1]);
end

R = U*S*V';
t = m2-1/v1*trace(D*S)*U*S*V'*m1;
c = 1/v1*trace(D*S);
