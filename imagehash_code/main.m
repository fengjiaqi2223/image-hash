
clear all
clc
tic
images_transTEMP  = [];
images_orgTEMP  = [];
n = 1;
 images_org = double(zeros(256, 256, n));
 images_trans = double(zeros(256, 256, n));
     Q = 32;
   % k = log2(Q);
   % k = 8-k; %kΪÿ��block����
    block = 64;
%I  = imresize(imread('C:\workspace\matlab\����������\ͼ����ת-����������\ͼ����ת-����������\secure\�½��ļ���\Lena.jpg'),[512,512]);
[ row, column ] = makingGrids(256, 256, 16, 16);
[ blocking ] = ProduceBlocking(16, 16, row, column, block, 0.25);

images_org(:, :, i) = imresize(rgb2gray(imread(['imgpath1'])),[256,256]);
images_trans(:, :, i) = imresize(rgb2gray(imread([''imgpath2])),[256,256]);

  Distance= [] ;
H1 = [];
  %����ԭͼ��任�����ͼ��ľ���

  
    images_trans(:, :, 1) = double(images_trans(:, :, i));
    images_org(:, :, 1) = double(images_org(:, :, i));
   
     images_orgTEMP = ImageLogPolarTransform_new(images_org(:, :, 1));
     images_transTEMP = ImageLogPolarTransform_new(images_trans(:, :, 1));
%        
    [ ImgNew1_org1 ] = TransImageFJQ1( images_orgTEMP);
    [ ImgNew1_trans1 ] = TransImageFJQ1(  images_transTEMP);
%     
     images_org(:, :, 1) = ImageLogPolarTransform(images_org(:, :, i));
    images_trans(:, :, 1) = ImageLogPolarTransform(images_trans(:, :, i));
      [ ImgNew1_org2 ] = TransImageFJQ1( images_org(:, :, 1) );
    [ ImgNew1_trans2 ] = TransImageFJQ1( images_trans(:, :, 1) );
     v1 = [];v2  = [];
     v1(1,:) = CalculateHashVector(ImgNew1_org1, blocking, row,column, Q);  %images_org�Ĺ�ϣֵ1
     v1(2,:) = CalculateHashVector(ImgNew1_org2, blocking, row,column, Q);   %image_org�Ĺ�ϣֵ2
	 Hash1 = [v1(1,:),v1(2,:)];%ͼ��1�Ĺ�ϣֵ
     
     v2(1,:) = CalculateHashVector(ImgNew1_trans1, blocking, row,column, Q);
     v2(2,:) = CalculateHashVector(ImgNew1_trans2, blocking, row,column, Q);
	  Hash2 = [v2(1,:),v2(2,:)];%ͼ��2�Ĺ�ϣֵ
    
     Distance(1) = HammingDistance( v1(1,:),v2(1,:));
      Distance(2) = HammingDistance( v1(2,:),v2(2,:));
     h=min(min(Distance));

    H1=[H1;h];
 end
H1=H1/192;%��ǰ����ͼ���һ���ĺ�������
K = [K,H1];
end
 %H1 = H1';
toc
