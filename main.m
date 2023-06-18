clc
clear all
close all
[filename, pathname, filterindex] = uigetfile('*.jpg; *.png', 'Pick a image file');
s=[pathname filename];
f=imread(s);
% v=videoinput('winvideo',3,'YUY2_320x240');
% set(v,'ReturnedColorSpace','rgb');
% preview(v)
% pause(10);
% f=getsnapshot(v);
% closepreview(v)
cropped(f);
    