%AngularProjection�������ڽ�ͼ���ƽ�������ʾ��ʽת��Ϊ
%�������ʾ��ʽ����������ÿ���ֵ���ٽ���ƽ�������е�ֵ���Բ�ֵ�ó�
%������ʽΪAngularProjection��FileName,RStyle,RCount,AngularCount),����������밴˳������
%����FileName��ʾҪ�����ͼ������RStyleΪѡȡ�뾶��ʽ���С�RMAX����'RMED'����RMIN��������ʽ
%��RMAX����ʾ������ͼ������Բ����Rlength=sqrt��Height*Height/4+Width*Width/4��
%��RMED����ʾ��Height��Width������һ�����뾶��Բ����Rlength=max��Height/2��Width/2��
%��RMIN����ʾ��Height��Width����С��һ�����뾶��Բ����Rlength=min��Height/2��Width/2��
% RStyleĬ��ΪRMIN��ʽ
%RCount������ʾ��Բ�뾶�ֵĿ�����Ĭ��Ϊmin��Height/2��Width/2����
%AngularCount������ʾ��Բ�ֵܷĽǶȿ�����Ĭ��Ϊmax��Height/2��Width/2����


function [LogPolarValue]=ImageLogPolarTransform_new(varargin)

%�������С��һ�������������
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

%�뾶���󣬽ǶȾ���
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
% title('ԭͼ');
% subplot(2,2,2),imshow(Polar_Value);
% title('ԭͼ������任���');
% subplot(2,2,3),imshow(LogPolarValue);
% title('ԭͼ����������任���');
% subplot(2,2,4),imshow(uint8(Z));
% title('Բ��ģ��');
% figure,imshow(OriginalImage);
% title('ԭͼ');
% figure,imshow(Polar_Value);
% title('ԭͼ������任���');
% figure,imshow(LogPolarValue);
% title('ԭͼ����������任���');