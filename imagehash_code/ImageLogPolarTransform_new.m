%AngularProjection函数用于将图像的平面坐标表示形式转化为
%极坐标表示形式，极坐标中每点的值用临近的平面坐标中的值线性插值得出
%函数形式为AngularProjection（FileName,RStyle,RCount,AngularCount),参数输入必须按顺序输入
%其中FileName表示要读入的图像名，RStyle为选取半径形式，有‘RMAX’、'RMED'、‘RMIN’三种形式
%‘RMAX’表示做整幅图像的外接圆，即Rlength=sqrt（Height*Height/4+Width*Width/4）
%‘RMED’表示以Height、Width中最大的一半做半径做圆，即Rlength=max（Height/2，Width/2）
%‘RMIN’表示以Height、Width中最小的一半做半径做圆，即Rlength=min（Height/2，Width/2）
% RStyle默认为RMIN形式
%RCount用来表示将圆半径分的块数，默认为min（Height/2，Width/2）块
%AngularCount用来表示将圆周分的角度块数，默认为max（Height/2，Width/2）块


function [LogPolarValue]=ImageLogPolarTransform_new(varargin)

%如果参数小于一个，则给出警告
if(nargin<1)
    msg='Please inpute Image Matrix';
    error('MATLAB:AngularProjection:inputParsing', msg);
    return;
end

OriginalImage=varargin{1};
[Height,Width,Dimension]=size(OriginalImage);
P0 = searchFixedpoint2(2, OriginalImage );
%P0 = searchFixedPointLever1(31, OriginalImage );
P0;
X0 = P0(1,1);Y0 = P0(1,2);
Q =[X0, Y0];
Q;

VararginCount=length(varargin);
switch VararginCount
case 1
    RLength=min((Height-1)/2,(Width-1)/2);
    RCount=min(Height,Width);
    AngularCount=max(Height,Width);
case 2
    RStyle = varargin{2};
    switch RStyle
    case 'RMAX'
        RLength=sqrt((X0-1)^2+(Y0-1)^2);
    case 'RMED'
        RLength=max((Height-1)/2,(Width-1)/2);
    case 'RMIN'
        RLength=min((Height-1)/2,(Width-1)/2);
    otherwise
        RLength=min((Height-1)/2,(Width-1)/2);
    end
    RCount=min(Height,Width);
    AngularCount=max(Height,Width);
case 3
    RStyle = varargin{2};
    switch RStyle
    case 'RMAX'
        RLength=sqrt((X0-1)^2+(Y0-1)^2);
    case 'RMED'
        RLength=max((Height-1)/2,(Width-1)/2);
    case 'RMIN'
        RLength=min((Height-1)/2,(Width-1)/2);
    otherwise
        RLength=min((Height-1)/2,(Width-1)/2);
    end
    RCount=varargin{3};
    AngularCount=max(Height,Width);
case 4
    RStyle = varargin{2};
    switch RStyle
    case 'RMAX'
        RLength=sqrt((X0-1)^2+(Y0-1)^2);
    case 'RMED'
        RLength=max((Height-1)/2,(Width-1)/2);
    case 'RMIN'
        RLength=min((Height-1)/2,(Width-1)/2);
    otherwise
        RLength=min((Height-1)/2,(Width-1)/2);
    end
    RCount=varargin{3};
    AngularCount=varargin{4};
otherwise
    msg='error inputs';
    error('MATLAB:AngularProjection:inputParsing', msg);
    return;
end

%半径矩阵，角度矩阵
% DeltR=RLength/RCount;
RMatrix=linspace(0,RLength,RCount);
% DeltAngular=2*pi/AngularCount;
AngularMatrix=linspace(0,2*pi,AngularCount);

XX=RMatrix'*sin(AngularMatrix);
YY=RMatrix'*cos(AngularMatrix);
XX=X0+XX;
YY=Y0+YY;
Z=zeros(Height,Width);
for i=1:Height
    for j=1:Width
        if((i-X0)^2+(j-Y0)^2<=RLength^2)
            Z(i,j)=OriginalImage(i,j);
        else
            Z(i,j)=0;
        end
    end
end

for p=1:Dimension
    OriginalImage1=OriginalImage(:,:,p);
    PolarValue=interp2(OriginalImage1,YY,XX,'bicubic');
    OriginalImage2=PolarValue;
    PolarValue=uint8(PolarValue);
    Polar_Value(:,:,p)=PolarValue;    
    [Height1,Width1,nn]=size(OriginalImage2);
    XLength=RLength;
    XN=Height1;
    X2=1;
    b=log10(XLength);
    a=log10(X2);
    LogRMatrix=logspace(a,b,XN);
    XXX=LogRMatrix'*sin(AngularMatrix);
    YYY=LogRMatrix'*cos(AngularMatrix);
    XXX=X0+XXX;
    YYY=Y0+YYY;
    LogValue=interp2(OriginalImage1,YYY,XXX,'bicubic');
    LogValue=uint8(LogValue);
    LogPolarValue(:,:,p)=LogValue;
end

% subplot(2,2,1),imshow(OriginalImage);
% title('原图');
% subplot(2,2,2),imshow(Polar_Value);
% title('原图极坐标变换结果');
% subplot(2,2,3),imshow(LogPolarValue);
% title('原图对数极坐标变换结果');
% subplot(2,2,4),imshow(uint8(Z));
% title('圆形模板');
% figure,imshow(OriginalImage);
% title('原图');
% figure,imshow(Polar_Value);
% title('原图极坐标变换结果');
% figure,imshow(LogPolarValue);
% title('原图对数极坐标变换结果');