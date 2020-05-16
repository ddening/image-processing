% Grafik für Augen finden in einem Gesicht
%
% 30.5.16 Antje Ohlhoff
%
% gesichtGrafik(I,L)  I=Eingangsbildmatrix 
%                     L= Vektor mit Summe der Beträge Sobel_n pro Bildzeile

function gesichtGrafik(I,L1)

[hoehe,breite]=size(I);

for i=1:hoehe,
    L(hoehe+1-i)=L1(i);
end

for j=1:breite,
    jj(j)=j;
end
[m,ind]=max(L);

figure,subplot(1,2,1),
imagesc(I);title('Originalbild');colormap(gray); 
hold on;
plot(jj,hoehe+1-ind,'r*');
subplot(1,2,2),
barh(L); title('|S_n|');
axis([0 1.2*max(L) 1 hoehe]);

for i=1:uint16(1.2*max(L)),
    kk(i)=i; 
end
hold on;
plot(kk,ind,'r*');


