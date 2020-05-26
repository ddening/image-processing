% Erstellt am 20.05.2020
% Author: Dimitri Dening
function B=segmentation2(I)
%I = double(I);
Iadj = imadjust(I,[0 0.3],[0 0.6]);
% imshowpair(I, Iadj, 'montage');
%%
J = imlocalbrighten(I, 0.47);
J = imbinarize(J, 0.36);
Icomp = imcomplement(J);
Ifill = imfill(Icomp, 'holes');
imshow(Ifill);
se = strel('disk', 15);
Iopen = imopen(Ifill, se);
%imshowpair(I, Iopen, 'montage');

%%
labeledImage = bwlabel(Iopen, 8);
coloredLabels = label2rgb (labeledImage, 'hsv', 'k', 'shuffle');
figure, imshowpair(I, coloredLabels, 'montage');

blobMeasurements = regionprops(labeledImage, I, 'all');
C = labeloverlay(I,Iopen, 'Colormap','autumn', 'Transparency', 0.5);

B=blobMeasurements;
end

