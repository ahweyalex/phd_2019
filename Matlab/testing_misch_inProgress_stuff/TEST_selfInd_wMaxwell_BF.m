clear all; close all; clc; 

A  = importdata('Rect_ri10_ra10_.fld');
wT = 0.2546e-3;
ri = 10e-3;
ra = 10e-3;
I  = 1;
G  = 'r';
N = 100;
x  = reshape(A.data(:,1),N,N);
y  = reshape(A.data(:,2),N,N);
z  = reshape(A.data(:,3),N,N);
%bx0 = A.data(:,4);
%by0 = A.data(:,5);
%bz0 = A.data(:,6);
bx  = reshape(A.data(:,4),N,N);
by  = reshape(A.data(:,5),N,N);
bz  = reshape(A.data(:,6),N,N);

[L11] = selfInductance_BFields(ri,ra,I,x,y,bz,N,G)