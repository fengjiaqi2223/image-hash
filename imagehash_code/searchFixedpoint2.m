%%%%%%%%%%%%%%%%%%%%%%%
%%%%%����ƽ�Ʋ����߳���2*r�Ļ�������
function Loc = searchFixedpoint2(r, img)
%FASTSEARCHMEANVAR �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
% Test sub-functions
[m,n]=size(img);
img=double(img);
a=r;
b=r;
res=zeros(m-a+1,n-b+1);
for i=1:m-a+1
    for j=1:n-b+1
        if i==1 && j==1
            % calc first one
            res(1,1)=blockSum(1,1,a,b,img);
            continue;
        end
        % calc others
        if j==1 % from the row head, we need substract up row and add below row
            res(i,j)=res(i-1,j)-blockSum(i-1,j,1,b,img)+blockSum(i+a-1,j,1,b,img);
        else % in the internal row, we need substract left col and add right col
            res(i,j)=res(i,j-1)-blockSum(i,j-1,a,1,img)+blockSum(i,j-1+a,a,1,img);
        end
    end
end
[x,y]=find(res==(max(res(:))));
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
