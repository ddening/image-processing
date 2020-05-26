% Verkleinert ein Bild um einen Faktor n
%
% K=resize_image(I)  I=Eingangsbildmatrix
%                    K=verkleinerte Bildmatrix
%
% Für den Faktor n sind nur gerade Werte erlaubt
% Erstellt am 29.04.2020
% Author: Dimitri Dening
function K=resize_image(I)
% einlesen einer Variable
factor = input('Reduktionsfakor=');

% Bild in double konvertieren
I = double(I);

% verkleiner Bild mehrfach um Faktor 2, falls factor > 2
for runs=1:factor/2
    % liefert die Groesse des Bildes
    [n, m] = size(I);
    
    % erstelle verkleinerte dummy Bildmatrix 
    C = zeros(uint8(n/2), uint8(m/2));
    % Index i,j um neue Werte in C zu setzen
    i = 1;
    j = 1;
    
    % verkleiner Bild um Faktor 2
    for x=1:2:n-1
        for y=1:2:m-1
            C(i, j) = (I(x, y) + I(x, y+1) + I(x+1, y) + I(x+1, y+1)) / 4;
            j = j+1;
        end
        i = i+1;
        j = 1;
    end
    % 'Zwischenergebnis' sichern
    I = C;
end
% Bild in uint8 konvertieren
K = uint8(I);
% figure, imshow(K)
end