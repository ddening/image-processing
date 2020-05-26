% Erstellt am 20.05.2020
% Author: Dimitri Dening
function segmentation(originalImage)
O = double(originalImage);

% Pre processing
% O = imgaussfilt(O);
% O = medfilt2(O);

O = imflatfield(O, 60);
% O = imadjust(O);
% O = imlocalbrighten(O);

thresholdValue = 80;
binaryImage = binarize(O, thresholdValue);
% binaryImage = O < thresholdValue;

binaryImage = imfill(binaryImage, 'holes');
% figure, imshow(labeloverlay(originalImage,binaryImage))

%figure,
%imshowpair(O, binaryImage, 'montage' );
%title('Preproccesed Image (left), and Binary Image (right)')

labeledImage = bwlabel(binaryImage, 8);
coloredLabels = label2rgb (labeledImage, 'hsv', 'k', 'shuffle');
figure, imshow(coloredLabels);

blobMeasurements = regionprops(labeledImage, originalImage, 'all');
numberOfBlobs = size(blobMeasurements, 1);

% boundaries
% hold on;
% boundaries = bwboundaries(binaryImage);
% numberOfBoundaries = size(boundaries, 1);
% for k = 1 : numberOfBoundaries
% 	thisBoundary = boundaries{k};
% 	plot(thisBoundary(:,2), thisBoundary(:,1), 'g', 'LineWidth', 2);
% end
% hold off;

% elements = size(blobMeasurements, 1);
% for e=1:elements
%     if blobMeasurements(e).Area > 10000
%         figure, imshow(blobMeasurements(e).Image);
%     end
% end

end

