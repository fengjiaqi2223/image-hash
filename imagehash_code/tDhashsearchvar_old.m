%img1=imread('LenaRGB.jpg');%读取图像
%img1=rgb2gray(img1);%转换为灰度
%se=translate(strel(1),[37 23]);%平移 
%img2=imdilate(img1,se);
%X1=twoDhash(1,1,3,3,img) 取需要search的阙值
%[m,n]=size(img);
function Loc=tDhashsearchvar(x,y,m,n,a,b,img)
%m为搜索的区域宽，n为搜索区域长；（x，y=1）为搜索区域的起点位置；a为搜索块宽度，b为搜索块长度，x1为搜索的阙值，img为被搜索的图片
%A1=img1(1:3,1:3);
A = [];
B = [];
H = [];
c = a*b;
img = double(img);
C = img.*img;
a = ones(a,b)./c;
A = conv2(C,a,'valid');
B = conv2(img,a,'valid');
D = A - B.*B;
D=D.*(c/(c-1));

%for i=x:x+m-a
   % for j=y:y+n-b
       % A2=img2(i:i+2,j:j+2);
       % x2=twoDhash(i,j,a,b,img);
    %    H(i,j)=twoDhashvar(i,j,a,b,img);
        %if H(i,j)==x1
            %disp(i);
            %break
        %end
       % if x2==x1
      %A=[i,j];
    %if img(i,j)>200|img(i,j)<100
     % A=[];
   %end
      
        %disp(j);
        % B=[B;A] ;     % break
        %end
   % end
%end 
%for i = 1 : 3
    %[x,y] = find(max(max(H)));
   % [x, y]=find(H==(max(H(:))));
   % A = [x, y];
    %H(x,y) = -1;
    %B = [B;A];
%end
% [x,y] = find(max(max(H)));
 [x,y]=find(D==(max(D(:))));
Loc=[x,y];

%save data1 B
    
        