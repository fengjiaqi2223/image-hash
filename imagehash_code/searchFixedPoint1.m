function [ P ] = searchFixedPoint1( Image )
%UNTITLED2 此处显示有关此函数的摘要
%   此处显示详细说明
X = tDhashsearchvar (1,1,256,256,32,32,Image);
P = X(1,:);

% L = size (Loc,1);
% avg1 = (sum(Loc(:,1)))/L;
% avg2 = (sum(Loc(:,2)))/L;
% Distance = [];
% for i = 1:L
%     h = sqrt(power(Loc(i,1)-avg1,2)+power(Loc(i,2)-avg2,2));
%     Distance = [Distance,h];
% end
% [C,index] = sort(Distance);
% %[rowSub,colSub] = ind2sub(size(Distance),IX(1:3));
% x1 = Loc(index(1),1);y1 = Loc(index(1),2);
% P1 = [x1,y1];
% x2 = Loc(index(2),1);y2 = Loc(index(2),2);
% P2 = [x2,y2];
% x3 = Loc(index(3),1);y3 = Loc(index(3),2);
% P3 = [x3,y3];
% P = [P1;P2;P3];

end

