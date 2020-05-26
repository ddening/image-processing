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
I = imread('gl19k.jpg');
originalImage = I;
%% Flüssigkeitsstand
I = imgaussfilt(I);
J = edge(I, 'canny', 0.1); % NICHT ANFASSEN
[Fstand, Overlay] = liquidHeight(I);
%imshow(Fstand);

%% Finde oberste Kante mit Kantendetektor o.ä.
load('mfilter.mat', 'mfilter');
I = faltung(I, mfilter);
[Gx, Gy, Gb] = sobel(I);
K = binarize(Gy, -2);
Oberkante = edge(K, 'canny', 0.7); %% NICHT ANFASSEN
%figure, imshow(Oberkante);

%% Labeln
labeledImage = bwlabel(Fstand, 8);
coloredLabels = label2rgb (labeledImage, 'hsv', 'k', 'shuffle');
% figure, imshowpair(I, coloredLabels, 'montage'); 

blobMeasurements = regionprops(labeledImage, I, 'all');

[Ilabel num] = bwlabel(labeledImage);
Ibox = [blobMeasurements.BoundingBox]; 
Ibox = reshape(Ibox,[4 num]);

%figure, imshow(coloredLabels);
% hold on;
% for cnt = 1:num 
%     rectangle('position',Ibox(:,cnt),'edgecolor','r');
% end
% hold off;

%% Oberkannte erkennen

figure, imshow(Overlay);
hold on;
[zeile, spalte] = size(Oberkante);
topYX = [0 ; 0];    % dummy Koordinaten der gefundenen Oberkante
deltaArrayOben = [];    % Astände von Flüssigkeit zur Oberkante
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
        deltaArrayOben(end+1)=abs(topYX(1)-e(2)+(e(4)/2)); % Bestimme Abstand zwischen Flüssigkeit und Oberkante
        %line([mitte, mitte],[e(2), 1]); % imshow(coloredLabels);
        line([mitte, mitte],[topYX(1), e(2)+uint16((e(4)/2))], 'LineWidth', 2 ,'color', 'cyan'); % imshow(Oberkante);
    end
end
%hold off;

%% Unterkante erkennen
B = medfilt2(originalImage, [20,20]);
S = imadjust(B, [0.26 0.34], []);
Ifill = imfill(~S, 'holes');
Unterkante = edge(Ifill, 'canny', 0.1);

%figure, imshow(originalImage);
%hold on;
[zeile, spalte] = size(Unterkante);
bottomYX = [0 ; 0];    % dummy Koordinaten der gefundenen Oberkante
deltaArrayUnten = [];    % Astände von Flüssigkeit zur Oberkante
idx=1;
for elem=1:num
    e = blobMeasurements(elem).BoundingBox; % x,y,weite,höhe
    if blobMeasurements(elem).Area > 150
        % mitte = uint16(e(1) + (e(3)/2));    % Alternativ
        mitte = uint16(blobMeasurements(elem).Centroid(1)); % bestimme Koordinatenmitte der Box
        
        % Bestimme Linie von y-Pixel 600 -> Unterkannte Glas
        bottomYX(1) = 0;
        bottomYX(2) = 0;
        for z=zeile-10:-1:1
            if Unterkante(z, mitte) == 1
                bottomYX(1)= z;
                bottomYX(2)= mitte; % Position von unterern Glaskante gefunden
                break;
            end  
        end  
        deltaArrayUnten(end+1)=abs(bottomYX(1)-e(2)+(e(4)/2)); % Bestimme Abstand zwischen Flüssigkeit und Oberkante
        gesamt = deltaArrayUnten(idx)+deltaArrayOben(idx);
        if (deltaArrayUnten(idx) / gesamt) < 0.75
            line([mitte, mitte],[bottomYX(1), e(2)+uint16((e(4)/2))], 'LineWidth', 2 ,'color', 'red');
        else
            line([mitte, mitte],[bottomYX(1), e(2)+uint16((e(4)/2))], 'LineWidth', 2 ,'color', 'green');
        end
        %line([mitte, mitte],[bottomYX(1), e(2)+uint16((e(4)/2))], 'LineWidth', 2 ,'color', 'green');
        %line([mitte, mitte],[e(2), 1]);
        idx = idx+1;
    end
end
hold off;

%% Gesamthöhe bestimmen
n = numel(deltaArrayOben);
gesamt = [];
for i=1:n
    gesamt(end+1) = deltaArrayOben(i)+deltaArrayUnten(i); 
end

% % min zu 3/4 gefüllt?
state=false;
for i=1:n
    if (deltaArrayUnten(i) / gesamt(i)) < 0.75
        disp('Glas < 3/4');
    else
        disp('Glas > 3/4');
    end
end
