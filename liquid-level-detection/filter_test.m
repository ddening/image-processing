%% 
close all % schließt alle offenen figures
clear all % löscht alle Variablen im Workspace
clc % löscht das Command Window   
%% load filters
load('Bin5.mat', 'Bin5');
load('Bin3.mat', 'Bin3');
load('mfilter.mat', 'mfilter');
load('Sobm.mat', 'Sobm');

%% load images
originalImage = imread('gl1k.jpg');

%% edge detection comparison
e1=edge(originalImage, 'sobel');
e2=edge(originalImage, 'canny');
e3=edge(originalImage, 'roberts');
e4=edge(originalImage, 'prewitt');
e5=edge(originalImage, 'log');

figure,
subplot(2,3,1),imshow(originalImage);title('Originalbild');
subplot(2,3,2),imshow(e1);title('Sobel');
subplot(2,3,3),imshow(e2);title('Canny');
subplot(2,3,4),imshow(e3);title('Roberts');
subplot(2,3,5),imshow(e4);title('Prewitt');
subplot(2,3,6),imshow(e5);title('Log');

%% Pre processing
p1=faltung(originalImage, mfilter);
p2=faltung(originalImage, Bin5);
p3=imgaussfilt(originalImage);
p4=medfilt2(originalImage);

figure,
imshowpair(originalImage, p1, 'montage' );
title('Original Image (left), and Mean Filter (right)')
figure,
imshowpair(originalImage, p2, 'montage' );
title('Original Image (left), and Binomial Filter (right)')
figure,
imshowpair(originalImage, p3, 'montage' );
title('Original Image (left), and Gaussian Filter (right)')
figure,
imshowpair(originalImage, p4, 'montage' );
title('Original Image (left), and Median Filter (right)')

%% Contrast Adjustment
c1=imadjust(originalImage);
c2=imlocalbrighten(originalImage);
c3=imflatfield(originalImage, 30);
c4=histeq(originalImage);

figure,
imshowpair(originalImage, c1, 'montage' );
title('Original Image (left), and adjusted (right)')
figure,
imshowpair(originalImage, c2, 'montage' );
title('Original Image (left), and brighter (right)')
figure,
imshowpair(originalImage, c3, 'montage' );
title('Original Image (left), and flattened with sigma (right)')
figure,
imshowpair(originalImage, c4, 'montage' );
title('Original Image (left), and histeq (right)')

%% Morphological Operations
se = strel('square',5);
m1 = imdilate(originalImage, se);
m2 = imerode(originalImage, se);

figure,
imshowpair(originalImage, m1, 'montage' );
title('Original Image (left), and dilate (right)')
figure,
imshowpair(originalImage, m2, 'montage' );
title('Original Image (left), and erode (right)')
