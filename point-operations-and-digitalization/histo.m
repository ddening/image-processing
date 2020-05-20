% Berechnet und plottet das Grauwerthistogramm und kummulierte Histogramm
% einer Bildmatrix I
%
% [gHisto, kHisto]=histo(I)   I=Eingangsbildmatrix
%                             nHisto=Grauwerthistogramm
%                             kHisto=kummuliertest Histogramm
function [gHisto, kHisto]=histo(I)
%% Erstellt das Grauerthistogramm
numberOfElements = numel(I);    % bestimmt Anzahl an Elementen in Matrix
minValue = min(I,[], 'all');    % kleinstes Element in Bildmatrix
maxValue = max(I,[], 'all');    % groesstes Element in Bildmatrix

gHisto = [];
for g = minValue:maxValue
    count = I(I==g);
    gHisto(end+1) = numel(count) / numberOfElements;
end
% erstelle x-Achse fuers plotten des Grauwerthistogramms
x = minValue : 1 : maxValue;

%% Erstellt das kummulierte Histogramm
s = 0;                          % Hilfsvariable zum zaehlen
kHisto = [];
for i = 1:length(gHisto)        % laufe durch das gesamte Array 'gHisto'
    s = s + gHisto(i);          % addiere Werte auf
    kHisto(end+1) = s;
end
%% Plottet Ergebnisse
figure('Name', 'Kummuliertes Histogramm'), bar(kHisto, 'BarWidth', 0.3)
figure('Name', 'Grauwerthistogramm'), bar(x, gHisto, 'BarWidth', 0.3)
end