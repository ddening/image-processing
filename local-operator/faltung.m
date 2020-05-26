% Faltung einer Bildmatrix mit Filter F
%
% K=faltung(I, F)   I=Eingangsbildmatrix
%                   F=Faltungskern bzw. Filter
%                   K=gefaltete Bildmatrix
%
function K=faltung(I, F)
I = double(I);          % Bild in double konvertieren
[c1,c2] = size(I);      % Dimensionen der Bildmatrix
[f1,f2] = size(F);      % Dimensionen des Faltungskerns
K = zeros(c1, c2);      % Fuelle Ergebnismatrix mit Nullen
                        % Rand dadurch im Ergebnis mit Nullen besetzt
s = 0;                  % Hilfsvariable
b = (f1-1)/2;
startIdx = ((f1/2)+0.5);
endIdx = startIdx-1;

% durchlaufe alle inneren Pixel
for m=startIdx:1:c1-endIdx
    for n=startIdx:1:c2-endIdx 
        % fuehre Berechnung fuer Pixel p(m,n) aus
        for i=-b:1:b
            for j=-b:1:b
                s = s + I(m-i, n-j)*F(i + startIdx, j + startIdx);
            end
        end
        K(m,n) = s;
        s = 0;
    end
end

% % Wert vom Randpixel
% val = 0;
% % Randpixel auf Wert 'val' setzen
% mAxis = [1, c1];
% nAxis = [1, c2];
% % m-Achse
% for m=mAxis
%     for n=1:c2
%         K(m,n) = val;
%     end
% end
% % n-Achse
% for n=nAxis
%     for m=1:c1
%         K(m,n) = val;
%     end
% end

end


