% Bildverarbeitung Praktikum 01
% Digitalisierung & Punktoperatoren
% Erstellt am 29.04.2020
% Author: Dimitri Dening
% Praktikumsgruppe: Y
%% 
close all % schließt alle offenen figures
clear all % löscht alle Variablen im Workspace
clc % löscht das Command Window     
%% Main
I = imread('sinxx22.bmp');
% I = imread('gesicht1.jpg');
k = resize_image(I);
figure('Name', 'Originalbild'), imshow(I);
figure('Name', 'verkleinertes Bild'), imshow(k);
%% Plotte Histogramm und kummuliertes Histogramm
[gHisto, kHisto] = histo(I);
%% Probe mit Inbuilt-Tools
% figure, imhist(I)
% figure, histogram(I, 'Normalization', 'probability')
% figure, histogram(I, 'Normalization', 'cdf')