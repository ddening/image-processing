% Bildverarbeitung Praktikum 03
% Fuellstandserkennung
% Erstellt am 20.05.2020
% Author: Dimitri Dening
% Praktikumsgruppe: Y
%% 
close all % schließt alle offenen figures
clear all % löscht alle Variablen im Workspace
clc % löscht das Command Window
%% load images
I = imread('gl1k.jpg');
originalImage = I;
%% Flüssigkeitsstand
I = imgaussfilt(I);
J = edge(I, 'canny', 0.1); % NICHT ANFASSEN
Fstand = liquidHeight(I);
%imshow(Fstand);

%% Finde oberste Kante mit Kantendetektor o.ä.
load('mfilter.mat', 'mfilter');
I = faltung(I, mfilter);
[Gx, Gy, Gb] = sobel(I);
K = binarize(Gy, -2);
Oberkante = edge(K, 'canny', 0.7); %% NICHT ANFASSEN
figure, imshow(Oberkante);

%% Labeln
labeledImage = bwlabel(Fstand, 8);
coloredLabels = label2rgb (labeledImage, 'hsv', 'k', 'shuffle');
% figure, imshowpair(I, coloredLabels, 'montage'); 

blobMeasurements = regionprops(labeledImage, I, 'all');

[Ilabel num] = bwlabel(labeledImage);
Ibox = [blobMeasurements.BoundingBox]; 
Ibox = reshape(Ibox,[4 num]);

figure, imshow(coloredLabels);
hold on;
for cnt = 1:num 
    rectangle('position',Ibox(:,cnt),'edgecolor','r');
end
hold off;

%% Linien senkrecht zeichnen von Füllstand bis Oberkante
figure, imshow(Oberkante);
hold on;
[zeile, spalte] = size(Oberkante);
topYX = [0 ; 0];    % dummy Koordinaten der gefundenen Oberkante
deltaArray = [];    % Astände von Flüssigkeit zur Oberkante
for elem=1:num
    e = blobMeasurements(elem).BoundingBox; % x,y,weite,höhe
    if blobMeasurements(elem).Area > 150
        % mitte = uint16(e(1) + (e(3)/2));    % Alternativ
        mitte = uint16(blobMeasurements(elem).Centroid(1)); % bestimme Koordinatenmitte der Box
        
        % Bestimme Linie von y-Pixel 1 -> Oberkante Glas
        topYX(1) = 0;
        topYX(2) = 0;
        for z=1:zeile
            if Oberkante(z, mitte) == 1
                topYX(1)= z;
                topYX(2)= mitte; % Position von oberer Glaskante gefunden
                break;
            end  
        end   
        deltaArray(end+1)=abs(topYX(1)-e(2)); % Bestimme Abstand zwischen Flüssigkeit und Oberkante
        %line([mitte, mitte],[e(2), 1]); % imshow(coloredLabels);
        line([mitte, mitte],[topYX(1), e(2)], 'LineWidth', 2 ,'color', 'red'); % imshow(Oberkante);
    end
end
hold off;

