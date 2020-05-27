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
% not working for: [1, 7, 14]
I = imread('gl19k.jpg');
originalImage = I;

%% Flüssigkeitsstand
[Fstand, Overlay] = liquidHeight(I);
% figure, imshow(Fstand);
% figure, imshow(Overlay);

%% Labeln
labeledImage = bwlabel(Fstand, 8);
coloredLabels = label2rgb (labeledImage, 'hsv', 'k', 'shuffle');
blobMeasurements = regionprops(labeledImage, I, 'all');
% figure, imshowpair(I, coloredLabels, 'montage'); 

[Ilabel num] = bwlabel(labeledImage);
Ibox = [blobMeasurements.BoundingBox]; 
Ibox = reshape(Ibox,[4 num]);

% figure, imshow(coloredLabels);
% hold on;
% for cnt = 1:num 
%     rectangle('position',Ibox(:,cnt),'edgecolor','r');
% end
% hold off;

%% Bildvorverarbeitung
% Bild zur Bestimmung der Oberkante vorverarbeiten v2
load('mfilter.mat', 'mfilter');
filteredImage = faltung(I, mfilter);
filteredImage = faltung(filteredImage, mfilter); 
[Gx, Gy, Gb] = sobel(filteredImage);
K = binarize(Gy, -2);
TopEdge = edge(K, 'canny', 0.7); %% nicht ändern

% Bild zur Bestimmung der Unterkante vorverarbeiten
B = medfilt2(I, [20,20]); %20,20
S = imadjust(B, [0.26 0.34], []);
Ifill = imfill(~S, 'holes');
LowerEdge = edge(Ifill, 'canny', 0.1);

% figure, imshowpair(TopEdge, LowerEdge, 'montage');
% title('Image Preprocessing. TopEdge (left) and LowerEdge (right)')

%% Oberkannte erkennen
% figure, imshow(TopEdge);
figure, imshow(Overlay);
hold on;

[zeile, spalte] = size(TopEdge);
topYX = [0 ; 0];        % dummy Koordinaten der gefundenen Oberkante
deltaTop = [];          % Astände von Flüssigkeit zur Oberkante
for elem=1:num
    e = blobMeasurements(elem).BoundingBox; % x,y,weite,höhe
    if blobMeasurements(elem).Area > 150
        center = uint16(blobMeasurements(elem).Centroid(1)); % bestimme Koordinatenmitte der Box
        % center = uint16(e(1) + (e(3)/2));
        
        % Bestimme Linie von y-Pixel 1 -> Oberkante Glas
        topYX(1) = 0;
        topYX(2) = 0;
        for z=1:zeile
            if TopEdge(z, center) == 1
                topYX(1)= z;
                topYX(2)= center; % Position von oberer Glaskante gefunden
                break;
            end  
        end   
        % Bestimme Abstand zwischen Flüssigkeit und Oberkante
        deltaTop(end+1)=abs(topYX(1)-e(2)+(e(4)/2));
        line([center, center],[topYX(1), e(2)+uint16((e(4)/2))], 'LineWidth', 2 ,'color', 'cyan');
        %line([mitte, mitte],[e(2), 1]); % imshow(coloredLabels);
    end
end
%hold off;

%% Unterkante erkennen
% figure, imshow(originalImage);
% hold on;

[zeile, spalte] = size(LowerEdge);
bottomYX = [0 ; 0];     % dummy Koordinaten der gefundenen Oberkante
deltaBottom = [];       % Astände von Flüssigkeit zur Oberkante
idx=1;
offset=10;
level=0.75;
for elem=1:num
    e = blobMeasurements(elem).BoundingBox; % x,y,weite,höhe
    if blobMeasurements(elem).Area > 150
        center = uint16(blobMeasurements(elem).Centroid(1)); % bestimme Koordinatenmitte der Box
        % center = uint16(e(1) + (e(3)/2));
        
        % Bestimme Linie von y-Pixel 600 -> Unterkannte Glas
        bottomYX(1) = 0;
        bottomYX(2) = 0;
        for z=zeile-offset:-1:1
            if LowerEdge(z, center) == 1
                bottomYX(1)= z;
                bottomYX(2)= center; % Position von unterern Glaskante gefunden
                break;
            end  
        end  
        deltaBottom(end+1)=abs(bottomYX(1)-e(2)+(e(4)/2)); % Bestimme Abstand zwischen Flüssigkeit und Oberkante
        total = deltaBottom(idx)+deltaTop(idx);
        if (deltaBottom(idx) / total) < level
            line([center, center],[bottomYX(1), e(2)+uint16((e(4)/2))], 'LineWidth', 2 ,'color', 'red');
        else
            line([center, center],[bottomYX(1), e(2)+uint16((e(4)/2))], 'LineWidth', 2 ,'color', 'green');
        end
        idx = idx+1;
    end
end
hold off;

%% Gesamthöhe bestimmen
n = numel(deltaTop);
total = [];
for i=1:n
    total(end+1) = deltaTop(i)+deltaBottom(i); 
end

% % min zu 3/4 gefüllt?
state=false;
for i=1:n
    if (deltaBottom(i) / total(i)) < level
        disp('Glas < 3/4');
    else
        disp('Glas > 3/4');
    end
end
