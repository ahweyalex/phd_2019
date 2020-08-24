clear all; close all; clc;
%
ri = 10e-3;
ra = 10e-3;
I  = 1;
G  = 'r';
N  = 1;
wT = 0.2546e-3;
Nm = 199; 
A  = importdata('Rect_N3_ri10_ra10_100.fld');
%Nm = 201; 
%Ax = importdata('Rect_ri10_ra10_200.fld');

x0  = A.data(:,1);
y0  = A.data(:,2);
z0  = A.data(:,3);

x  = reshape(A.data(:,1),Nm,Nm);
y  = reshape(A.data(:,2),Nm,Nm);
z  = reshape(A.data(:,3),Nm,Nm);
bx0 = A.data(:,4);
by0 = A.data(:,5);
bz0 = A.data(:,6);
bx  = reshape(A.data(:,4),Nm,Nm);
by  = reshape(A.data(:,5),Nm,Nm);
bz  = reshape(A.data(:,6),Nm,Nm);
[L11] = selfInductance_BFields(ri,ra,I,x,y,bz,N,G);
%}

% Rect_Loop_N3
%{
ri = 10e-3;
ra = 10e-3;
I  = 1;
G  = 'r';
N  = 3;
Nm = 199;
A  = importdata('Rect_N3_ri10_ra10_100.fld');
%x0  = A.data(:,1);
%y0  = A.data(:,2);
%z0  = A.data(:,3);
x  = reshape(A.data(:,1),Nm,Nm);
y  = reshape(A.data(:,2),Nm,Nm);
z  = reshape(A.data(:,3),Nm,Nm);
%bx = A.data(:,4);
%by = A.data(:,5);
%bz = A.data(:,6);
bx  = reshape(A.data(:,4),Nm,Nm);
by  = reshape(A.data(:,5),Nm,Nm);
bz  = reshape(A.data(:,6),Nm,Nm);
[L11] = selfInductance_BFields(ri,ra,I,x,y,bz,N,G);
%}