% Faltung einer Bildmatrix mit Filter F
%
% L = gesichtSobn(I)    I=Eingangsbildmatrix
%                       L=Summe der einzelnen Bildzeilen
%
function L = gesichtSobn(I)
load('Sobn.mat', 'Sobn');
% Bild in double konvertieren
I = double(I);

% Faltung entlang n mit Sobeloperator
K = faltung(I, Sobn);
[x,y] = size(K);

summe = 0;
L = [];
% Bestimme Summe jeder Bildzeile
for m=1:x
    for n=1:y
        summe = summe + abs(K(m,n));
    end
    L(end+1) = summe;
    summe = 0;
end
end

