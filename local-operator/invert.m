% Invertierung eines Bildes
%
% K=invert(I)  I=Eingangsbildmatrix
%              K=invertierte Bildmatrix
%
% diese ersten Kommentarzeilen vor der eigentlichen Funktion werden von
% 'help invert' angezeigt

function K=invert(I)

% liefert die Groesse des Bildes
[hoehe,breite]=size(I);
anz=hoehe*breite;

% Bild in double konvertieren
I=double(I);

% einlesen einer Variable
gmax=input('maximaler Grauwert (Standard=255) = ');

% Invertierung des Bildes I in das Bild K
for i=1:hoehe
    for j=1:breite
        K(i,j)=gmax-I(i,j);
    end
end

% Bild in uint8 konvertieren
K=uint8(K);

% falls das invertierte Bild K sofort hier angezeigt werden soll 
% figure,imshow(K);