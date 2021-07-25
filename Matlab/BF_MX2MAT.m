clear all; close all; clc;

%A  = importdata('bf2_200_200_200.fld');
%Nx=201; Ny=201; Nz=201;
A  = importdata('bf2_200_300_100.fld');
Nx=201; Ny=301; Nz=101;
%C  = importdata('bf2_250_300_100.fld');
%Nx=251; Ny=301; Nz=101;
%%
X0  = reshape(A.data(:,1),Nz,Ny,Nx);
Y0  = reshape(A.data(:,2),Nz,Ny,Nx);
Z0  = reshape(A.data(:,3),Nz,Ny,Nx);
BX0 = reshape(A.data(:,4),Nz,Ny,Nx);
BY0 = reshape(A.data(:,5),Nz,Ny,Nx);
BZ0 = reshape(A.data(:,6),Nz,Ny,Nx);
