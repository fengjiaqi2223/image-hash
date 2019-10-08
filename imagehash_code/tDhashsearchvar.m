function Loc=tDhashsearchvar(x,y,m,n,a,b,img)
%mΪ�����������nΪ�������򳤣���x��y=1��Ϊ������������λ�ã�aΪ�������ȣ�bΪ�����鳤�ȣ�x1Ϊ��������ֵ��imgΪ��������ͼƬ
%FASTSEARCHMEANVAR �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
% Test sub-functions
[m,n]=size(img);
img=double(img);
res=zeros(m-a+1,n-b+1);
vars=zeros(m-a+1,n-b+1);
for i=1:m-a+1
    for j=1:n-b+1
        if i==1 && j==1
            % calc first one
            res(1,1)=blockSum(1,1,a,b,img);
            e1=res(1,1)/(a*b);
            vars(1,1)=blockSum(1,1,a,b,(img-e1).^2)/(a*b);
            continue;
        end
        % calc others
        if j==1 % from the row head, we need substract up row and add below row
            res(i,j)=res(i-1,j)-blockSum(i-1,j,1,b,img)+blockSum(i+a-1,j,1,b,img);
            e1=(res(i-1,j)/(a*b))^2;
            e2=(res(i,j)/(a*b))^2;
            vars(i,j)=vars(i-1,j)+e1-e2-(blockSum(i-1,j,1,b,img.^2)-blockSum(i-1+a,j,1,b,img.^2))/(a*b);
        else % in the internal row, we need substract left col and add right col
            res(i,j)=res(i,j-1)-blockSum(i,j-1,a,1,img)+blockSum(i,j-1+a,a,1,img);
            e1=(res(i,j-1)/(a*b))^2;
            e2=(res(i,j)/(a*b))^2;
            vars(i,j)=vars(i,j-1)+e1-e2-(blockSum(i,j-1,a,1,img.^2)-blockSum(i,j-1+b,a,1,img.^2))/(a*b);
        end
    end
end
[x,y]=find(vars==(max(vars(:))));
Loc=[x,y];
end
function res=blockSum(x,y,a,b,I)
    res=0;
    for i=x:x+a-1
        for j=y:y+b-1
            res=res+I(i,j);
        end
    end
end
    
        