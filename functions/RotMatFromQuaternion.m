function [ R ] = RotMatFromQuaternion( Q )
%ROTMATFROMQUATERNION Summary of this function goes here
%   Detailed explanation goes here

if(size(Q, 2) ~= 4)
    ERROR = sprintf('There is no exact input.');
    disp(ERROR);
    R = zeros(3, 3);
else
%     R11 = Q(1)^2 + Q(2)^2 + Q(3)^2 + Q(4)^2;
%     R12 = 2 * (Q(1)*Q(2) + Q(3)*Q(4));
%     R13 = 2 * (Q(1)*Q(3) - Q(2)*Q(4));
%     R21 = 2 * (Q(1)*Q(2) - Q(3)*Q(4));
%     R22 = - Q(1)^2 + Q(2)^2 - Q(3)^2 + Q(4)^2;
%     R23 = 2 * (Q(2)*Q(3) + Q(1)*Q(4));
%     R31 = 2 * (Q(1)*Q(3) + Q(2)*Q(4));
%     R32 = 2 * (Q(2)*Q(3) - Q(1)*Q(4));
%     R33 = - Q(1)^2 - Q(2)^2 + Q(3)^2 + Q(4)^2;
    
    R11 = 1 - 2 * (Q(3)^2 + Q(4)^2);
    R12 = 2 * (Q(2)*Q(3) - Q(4)*Q(1));
    R13 = 2 * (Q(4)*Q(2) + Q(3)*Q(1));
    R21 = 2 * (Q(2)*Q(3) + Q(4)*Q(1));
    R22 = 1 - 2 * (Q(4)^2 + Q(2)^2);
    R23 = 2 * (Q(3)*Q(4) - Q(2)*Q(1));
    R31 = 2 * (Q(4)*Q(2) - Q(3)*Q(1));
    R32 = 2 * (Q(3)*Q(4) + Q(2)*Q(1));
    R33 = 1 - 2 * (Q(2)^2 + Q(3)^2);
    
    R = [R11, R12, R13;
         R21, R22, R23;
         R31, R32, R33];
end

end

