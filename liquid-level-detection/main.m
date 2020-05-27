% Bildverarbeitung Praktikum 03
% Fuellstandserkennung
% Erstellt am 20.05.2020
% Author: Dimitri Dening
% Praktikumsgruppe: Y
%% 
close all % schließt alle offenen figures
clear all % löscht alle Variablen im Workspace
clc % löscht das Command Window
%% load images
% I = imread('blutbild.bmp');
% I = imread('gl4k.jpg');
% [J,K] = liquidHeight(I);
% imshow(K);

%% Main Detection Script
detection;
%% Histogramme plotten
% h = histo(I);
% h=imhist(I);
% [hG, ML, MR, minima] = glatt(h, 10, 26);
%% Erkennung der Flüssigkeitskante
% liquidHeight(I);
%% Segmentation
% segmentation(I);
% segmentation2(I);

