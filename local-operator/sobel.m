% Anwendung des Sobel-Operators auf eine Bildmatrix I
%
% K=sobel(I)    I=Eingangsbildmatrix
%               K=Betrag
%
% Erstellt am 12.05.2020
% Author: Dimitri Dening
function [Gx, Gy, betrag, richtung]=sobel(I)
% Bild in double konvertieren
I = double(I);

load('Sobm.mat', 'Sobm');
load('Sobn.mat', 'Sobn');

% Faltung entlang m und n mit Sobeloperator
Gy = faltung(I, Sobm);
Gx = faltung(I, Sobn);
[x,y] = size(Gy);

betrag = zeros(x,y);
richtung = zeros(x,y);

for i=1:1:x
    for j=1:1:y
        betrag(i,j) = sqrt(Gy(i,j).^2 + Gx(i,j).^2); % gibt die Staerke der Kante an
        richtung(i,j) = (atan2(Gx(i,j),Gy(i,j)))*(360/(2*pi));
    end
end

% figure('Name', 'Sobel m'), imagesc(Gy); colormap(gray);
% figure('Name', 'Sobel n'), imagesc(Gx); colormap(gray);
% figure('Name', 'Betrag'), imagesc(betrag); colormap(gray);
% figure('Name', 'Richtung'), imagesc(richtung); colormap(gray);
end

