function [ ImgNew ] = TransImageFJQ1( Img )
%UNTITLED5 �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
Image = Img;
[P] = searchFixedPoint1(Image);
[n,m] = size(Img);
ImgNew = zeros(n, m);

ImgNew(1:n-P(1, 1), 1:m-P(1, 2)) = Image(P(1, 1)+1:n, P(1, 2)+1:m);
ImgNew(1:n-P(1, 1), m-P(1, 2)+1:m) = Image(P(1, 1)+1:n, 1:P(1, 2));
ImgNew(n-P(1,1)+1:n, 1: m-P(1, 2)) = Image(1:P(1, 1), P(1, 2)+1:m);
ImgNew(n-P(1,1)+1:n, m-P(1,2)+1:m) = Image(1:P(1, 1),1:P(1, 2));

% ImgNew(1:n-P(2, 1),1:m-P(2, 2), 2) = Image(P(2, 1)+1:n, P(2, 2)+1:m);
% ImgNew(1:n-P(2, 1),m-P(2, 2)+1:m, 2) = Image(P(2, 1)+1:n, 1:P(2, 2));
% ImgNew(n-P(2, 1)+1:n,1: m-P(2, 2), 2) = Image(1:P(2, 1), P(2, 2)+1:m);
% ImgNew(n-P(2, 1)+1:n, m-P(2, 2)+1:m, 2) = Image(1:P(2, 1),1:P(2, 2));
% 
% ImgNew(1:n-P(3, 1),1:m-P(3, 2), 3) = Image(P(3, 1)+1:n, P(3, 2)+1:m);
% ImgNew(1:n-P(3, 1),m-P(3, 2)+1:m, 3) = Image(P(3, 1)+1:n, 1:P(3, 2));
% ImgNew(n-P(3, 1)+1:n, 1: m-P(3, 2), 3) = Image(1:P(3, 1), P(3, 2)+1:m);
% ImgNew(n-P(3, 1)+1:n, m-P(3, 2)+1:m, 3) = Image(1:P(3, 1),1:P(3, 2));


end

