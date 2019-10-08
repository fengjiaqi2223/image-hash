function [ row, column ] = makingGrids( x, y, a, b )
%UNTITLED4 此处显示有关此函数的摘要
%   此处显示详细说明
%[ ImgNew ] = TransImageFJQ( Image );
%[n,m] = size(Image);
rand('state',3);
K_1 = rand(1,a-1);
R = zeros(1,a-1);
for i = 1:a-1
    R(i) = (x/a)*(i-1)+floor(16*K_1(i));
end
row=[R,x];
rand('state',4);
K_2 = rand(1,b-1);
C= zeros(1,b-1);
for i = 1:b-1
    C(i) = (y/b)*(i-1)+floor(16*K_2(i));
end
column=[C,y];
end


