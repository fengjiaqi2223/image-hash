
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
   % k = 8-k; %k为每块block长度
    block = 64;
%I  = imresize(imread('C:\workspace\matlab\对数极坐标\图像旋转-对数极坐标\图像旋转-对数极坐标\secure\新建文件夹\Lena.jpg'),[512,512]);
[ row, column ] = makingGrids(256, 256, 16, 16);
[ blocking ] = ProduceBlocking(16, 16, row, column, block, 0.25);

images_org(:, :, i) = imresize(rgb2gray(imread(['imgpath1'])),[256,256]);
images_trans(:, :, i) = imresize(rgb2gray(imread([''imgpath2])),[256,256]);

  Distance= [] ;
H1 = [];
  %计算原图与变换过后的图像的距离

  
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
     v1(1,:) = CalculateHashVector(ImgNew1_org1, blocking, row,column, Q);  %images_org的哈希值1
     v1(2,:) = CalculateHashVector(ImgNew1_org2, blocking, row,column, Q);   %image_org的哈希值2
	 Hash1 = [v1(1,:),v1(2,:)];%图像1的哈希值
     
     v2(1,:) = CalculateHashVector(ImgNew1_trans1, blocking, row,column, Q);
     v2(2,:) = CalculateHashVector(ImgNew1_trans2, blocking, row,column, Q);
	  Hash2 = [v2(1,:),v2(2,:)];%图像2的哈希值
    
     Distance(1) = HammingDistance( v1(1,:),v2(1,:));
      Distance(2) = HammingDistance( v1(2,:),v2(2,:));
     h=min(min(Distance));

    H1=[H1;h];
 end
H1=H1/192;%当前两幅图像归一化的汉明距离
K = [K,H1];
end
 %H1 = H1';
toc
