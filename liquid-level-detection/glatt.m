% Glättung durch gleitenden Mittwert des Histogramm I und berechnet links- und rechtseitige
% Mittelwerte. Bestimmt zusätzlich ein bzw. mehrere Minima.
%
% [hGlatt, ML, MR, minima]=glatt(h,b,p,optionalArgument) 
%                                       h=Eingangshistogramm
%                                       b=Glättung in g-Richtung (int value)
%                                       p=Glättung in h-Richtung (float value)
%
%                                       --optionalArgument:
%                                       'show'  zeigt geglättetes Histogramm mit Minima
% Erstellt am 20.05.2020
% Author: Dimitri Dening
function [hGlatt, ML, MR, minima]=glatt(h,b,p,varargin)
par = inputParser;
par.addOptional('display','no',@(x) true);
par.parse(varargin{:});
display = par.Results.display;

[x,y]=size(h);
hGlatt = zeros(x,y);
%% Glätten vom Histogramm
for g=1+b:x-b
    summe=0;
    for n=-b:1:b
        summe=summe+h(g+n);
    end
    hGlatt(g, 1)= 1/((2*b)+1)*summe;
end
%% Linke Mittelwerte
ML = zeros(x,1);
for g=1+b:x-b
    summe=0;
    for n=-b:0
        summe=summe+hGlatt(g+n);
    end
    ML(g,1)= 1/(b+1)*summe;
end
%% Rechte Mittelwerte
MR = zeros(x,1);
for g=1+b:x-b
    summe=0;
    for n=0:b
        summe=summe+hGlatt(g+n);
    end
    MR(g,1)= 1/(b+1)*summe;
end
%% Bestimmung von Minima
minima=[];
n=size(ML, 1);

for g=1:n
    if ML(g,1) >= hGlatt(g)+p && MR(g) >= hGlatt(g)+p
        minima(end+1, 1)=g;
    end
end
%% Plotten der Ergebnisse
if strcmp(display,'show')
    figure('Name', 'Geglättetes Histogramm (255 hell) (0 dunkel)'), bar(hGlatt, 'BarWidth', 0.3)
    if numel(minima) > 0
        hold on;
        maxYValue = ylim;
        line([minima, minima], maxYValue, 'color', 'r');
    end
end

end

