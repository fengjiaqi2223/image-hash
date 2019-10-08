
clear all
clc
tic
  K = [];
  n = 500;%图像数目
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%最终结果，测试输出！！
  name1 = ls('C:\workspace\matlab\对数极坐标\数据集图像\原图排序');
 name1 = name1(3:1010, :);
 name2 = ls('C:\workspace\matlab\对数极坐标\数据集图像\旋转平移噪声\旋转-10平移-8噪声0.01');
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
   % k = 8-k; %k为每块block长度
    block = 64;
%I  = imresize(imread('C:\workspace\matlab\对数极坐标\图像旋转-对数极坐标\图像旋转-对数极坐标\secure\新建文件夹\Lena.jpg'),[512,512]);
[ row, column ] = makingGrids(256, 256, 16, 16);
[ blocking ] = ProduceBlocking(16, 16, row, column, block, 0.25);
j = {
'C:\workspace\matlab\对数极坐标\数据集图像\平移尺度噪声\平移5尺度2噪声0.01\';
'C:\workspace\matlab\对数极坐标\数据集图像\平移尺度噪声\平移-5尺度2噪声0.01\';
'C:\workspace\matlab\对数极坐标\数据集图像\平移尺度噪声\平移10尺度2噪声0.01\';
'C:\workspace\matlab\对数极坐标\数据集图像\平移尺度噪声\平移-10尺度2噪声0.01\';
'C:\workspace\matlab\对数极坐标\数据集图像\平移尺度噪声\平移15尺度2噪声0.01\'	;
'C:\workspace\matlab\对数极坐标\数据集图像\平移尺度噪声\平移-15尺度2噪声0.01\';
'C:\workspace\matlab\对数极坐标\数据集图像\平移尺度噪声\平移5尺度0.5噪声0.01\';
'C:\workspace\matlab\对数极坐标\数据集图像\平移尺度噪声\平移-5尺度0.5噪声0.01\';
'C:\workspace\matlab\对数极坐标\数据集图像\平移尺度噪声\平移10尺度0.5噪声0.01\';
'C:\workspace\matlab\对数极坐标\数据集图像\平移尺度噪声\平移-10尺度0.5噪声0.01\';
'C:\workspace\matlab\对数极坐标\数据集图像\平移尺度噪声\平移15尺度0.5噪声0.01\';
'C:\workspace\matlab\对数极坐标\数据集图像\平移尺度噪声\平移-15尺度2噪声0.01\';
};

for k = 1:length(j)

    for i = 1:500
         images_org(:, :, i) = imresize(rgb2gray(imread([ 'C:\workspace\matlab\对数极坐标\数据集图像\原图排序\',name1(i, :)])),[256,256]);
        images_trans(:, :, i) = imresize(rgb2gray(imread([ j{k},name1(i, :)])),[256,256]);
    
   
  end
  Distance= [] ;
H1 = [];
  %计算原图与变换过后的图像的距离
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
     v1(1,:) = CalculateHashVector(ImgNew1_org1, blocking, row,column, Q);  %images_org的哈希值1
     v1(2,:) = CalculateHashVector(ImgNew1_org2, blocking, row,column, Q);   %image_org的哈希值2
     
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
