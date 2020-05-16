% Faltung einer Bildmatrix mit Filter F
%
% K=faltung(I, F)   I=Eingangsbildmatrix
%                   F=Faltungskern bzw. Filter
%                   K=gefaltete Bildmatrix
%
function K=faltung(I, F)
I = double(I);          % Bild in double konvertieren
[c1,c2] = size(I);      % Dimensionen der Bildmatrix
K = zeros(c1, c2);      % Fuelle Ergebnismatrix mit Nullen
                        % Rand dadurch im Ergebnis mit Nullen besetzt
s = 0;                  % Hilfsvariable

% durchlaufe alle inneren Pixel
for m=2:1:c1-1
    for n=2:1:c2-1 
        % fuehre Berechnung fuer Pixel p(m,n) aus
        for i=-1:1:1
            for j=-1:1:1
                s = s + I(m-i, n-j)*F(i + 2, j + 2);
            end
        end
        K(m,n) = s;
        s = 0;
    end
end

% Wert vom Randpixel
val = 0;
% Randpixel auf Wert 'val' setzen
mAxis = [1, c1];
nAxis = [1, c2];
% m-Achse
for m=mAxis
    for n=1:c2
        K(m,n) = val;
    end
end
% n-Achse
for n=nAxis
    for m=1:c1
        K(m,n) = val;
    end
end

end


