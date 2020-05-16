% Anwendung des Sobel-Operators auf eine Bildmatrix I
%
% K=sobel(I)    I=Eingangsbildmatrix
%               K=Betrag
%
function K=sobel(I)
% Bild in double konvertieren
I = double(I);

load('Sobm.mat', 'Sobm');
load('Sobn.mat', 'Sobn');
% Sobm = [1 2 1; 0 0 0 ; -1 -2 -1; ].*(1/8);
% Sobn = [1 0 -1; 2 0 -2 ; 1 0 -1; ].*(1/8); 

% Faltung entlang m und n mit Sobeloperator
K_m = faltung(I, Sobm);
K_n = faltung(I, Sobn);
[x,y] = size(K_m);

betrag = zeros(x,y);
richtung = zeros(x,y);

for i=1:1:x
    for j=1:1:y
        betrag(i,j) = sqrt(K_m(i,j).^2 + K_n(i,j).^2); % gibt die Staerke der Kante an
        richtung(i,j) = (atan2(K_n(i,j),K_m(i,j)))*(360/(2*pi));
    end
end

K=betrag;

disp('Betrag:')
disp(betrag)
disp('Richtung:')
disp(richtung)

figure('Name', 'Sobel m'), imagesc(K_m); colormap(gray);
figure('Name', 'Sobel n'), imagesc(K_n); colormap(gray);
figure('Name', 'Betrag'), imagesc(betrag); colormap(gray);
figure('Name', 'Richtung'), imagesc(richtung); colormap(gray);
end

