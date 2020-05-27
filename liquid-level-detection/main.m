% Bildverarbeitung Praktikum 03
% Fuellstandserkennung
% Erstellt am 20.05.2020
% Author: Dimitri Dening
% Praktikumsgruppe: Y
%% 
close all % schlie�t alle offenen figures
clear all % l�scht alle Variablen im Workspace
clc % l�scht das Command Window
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
%% Erkennung der Fl�ssigkeitskante
% liquidHeight(I);
%% Segmentation
% segmentation(I);
% segmentation2(I);

