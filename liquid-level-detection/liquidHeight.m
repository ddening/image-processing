% Erkennt die höchste Kante einer Flüssigkeit im Objekt
%
% [J,C] = liquidHeight(Im)  Im=Eingangsbildmatrix
%                           J=Ausgangsmatrix
%                           C=Überlagertes Bild mit Kantenanzeige
% Erstellt am 20.05.2020
% Author: Dimitri Dening
function [J,C] = liquidHeight(Im)
load('mfilter.mat', 'mfilter');
I = faltung(Im, mfilter);
[Gx, Gy, Gb] = sobel(I);

J = binarize(Gy, -10);
J = edge(J, 'canny', 0.95);
C = labeloverlay(Im,J, 'Colormap','hot', 'Transparency', 0);

% figure,imshowpair(Gx,Gy,'montage')
% title('Directional Gradients Gx and Gy, Using Sobel Method')
% figure, imshowpair(Gy,J, 'montage')
% figure, imshow(C);
end

