
clear all
clc
tic
  K = [];
  n = 500;%ͼ����Ŀ
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%���ս���������������
  name1 = ls('C:\workspace\matlab\����������\���ݼ�ͼ��\ԭͼ����');
 name1 = name1(3:1010, :);
 name2 = ls('C:\workspace\matlab\����������\���ݼ�ͼ��\��תƽ������\��ת-10ƽ��-8����0.01');
 name2 = name2(3:1010,:);
 %name2 = name2(3:102, :);
 m1 = 256;
 n1 = 256;
   images_transTEMP  = [];
  images_orgTEMP  = [];
 images_org = double(zeros(256, 256, n));
 images_trans = double(zeros(256, 256, n));
     Q = 32;
   % k = log2(Q);
   % k = 8-k; %kΪÿ��block����
    block = 64;
%I  = imresize(imread('C:\workspace\matlab\����������\ͼ����ת-����������\ͼ����ת-����������\secure\�½��ļ���\Lena.jpg'),[512,512]);
[ row, column ] = makingGrids(256, 256, 16, 16);
[ blocking ] = ProduceBlocking(16, 16, row, column, block, 0.25);
j = {
'C:\workspace\matlab\����������\���ݼ�ͼ��\ƽ�Ƴ߶�����\ƽ��5�߶�2����0.01\';
'C:\workspace\matlab\����������\���ݼ�ͼ��\ƽ�Ƴ߶�����\ƽ��-5�߶�2����0.01\';
'C:\workspace\matlab\����������\���ݼ�ͼ��\ƽ�Ƴ߶�����\ƽ��10�߶�2����0.01\';
'C:\workspace\matlab\����������\���ݼ�ͼ��\ƽ�Ƴ߶�����\ƽ��-10�߶�2����0.01\';
'C:\workspace\matlab\����������\���ݼ�ͼ��\ƽ�Ƴ߶�����\ƽ��15�߶�2����0.01\'	;
'C:\workspace\matlab\����������\���ݼ�ͼ��\ƽ�Ƴ߶�����\ƽ��-15�߶�2����0.01\';
'C:\workspace\matlab\����������\���ݼ�ͼ��\ƽ�Ƴ߶�����\ƽ��5�߶�0.5����0.01\';
'C:\workspace\matlab\����������\���ݼ�ͼ��\ƽ�Ƴ߶�����\ƽ��-5�߶�0.5����0.01\';
'C:\workspace\matlab\����������\���ݼ�ͼ��\ƽ�Ƴ߶�����\ƽ��10�߶�0.5����0.01\';
'C:\workspace\matlab\����������\���ݼ�ͼ��\ƽ�Ƴ߶�����\ƽ��-10�߶�0.5����0.01\';
'C:\workspace\matlab\����������\���ݼ�ͼ��\ƽ�Ƴ߶�����\ƽ��15�߶�0.5����0.01\';
'C:\workspace\matlab\����������\���ݼ�ͼ��\ƽ�Ƴ߶�����\ƽ��-15�߶�2����0.01\';
};

for k = 1:length(j)

    for i = 1:500
         images_org(:, :, i) = imresize(rgb2gray(imread([ 'C:\workspace\matlab\����������\���ݼ�ͼ��\ԭͼ����\',name1(i, :)])),[256,256]);
        images_trans(:, :, i) = imresize(rgb2gray(imread([ j{k},name1(i, :)])),[256,256]);
    
   
  end
  Distance= [] ;
H1 = [];
  %����ԭͼ��任�����ͼ��ľ���
 for i = 1 : 500
  
    images_trans(:, :, i) = double(images_trans(:, :, i));
    images_org(:, :, i) = double(images_org(:, :, i));
   
     images_orgTEMP = ImageLogPolarTransform_new(images_org(:, :, i));
     images_transTEMP = ImageLogPolarTransform_new(images_trans(:, :, i));
%        
    [ ImgNew1_org1 ] = TransImageFJQ1( images_orgTEMP);
    [ ImgNew1_trans1 ] = TransImageFJQ1(  images_transTEMP);
%     
     images_org(:, :, i) = ImageLogPolarTransform(images_org(:, :, i));
    images_trans(:, :, i) = ImageLogPolarTransform(images_trans(:, :, i));
      [ ImgNew1_org2 ] = TransImageFJQ1( images_org(:, :, i) );
    [ ImgNew1_trans2 ] = TransImageFJQ1( images_trans(:, :, i) );
     v1 = [];v2  = [];
     v1(1,:) = CalculateHashVector(ImgNew1_org1, blocking, row,column, Q);  %images_org�Ĺ�ϣֵ1
     v1(2,:) = CalculateHashVector(ImgNew1_org2, blocking, row,column, Q);   %image_org�Ĺ�ϣֵ2
     
     v2(1,:) = CalculateHashVector(ImgNew1_trans1, blocking, row,column, Q);
     v2(2,:) = CalculateHashVector(ImgNew1_trans2, blocking, row,column, Q);
    
     Distance(1) = HammingDistance( v1(1,:),v2(1,:));
      Distance(2) = HammingDistance( v1(2,:),v2(2,:));
     h=min(min(Distance));

    H1=[H1;h];
 end
H1=H1/192;
K = [K,H1];
end
 %H1 = H1';
toc
