clear all; close all; clc;
% 
N  = 100; 
ri = 10e-3;
ra = 10e-3;
I  = 1;
G  = 's';
A  = importdata('rect_bvector_xy.fld');
x  = reshape(A.data(:,1),N,N);
y  = reshape(A.data(:,2),N,N);
z  = reshape(A.data(:,3),N,N);
bx = reshape(A.data(:,4),N,N);
by = reshape(A.data(:,5),N,N);
bz = reshape(A.data(:,6),N,N);

[L11] = selfInductance_BFields(ri,ra,I,x,y,bz,N,G)