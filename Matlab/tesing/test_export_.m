% testing export function
%
%

clear all; close all; clc;
% construct wire antenna
ra=0.3; ri=0.3; phi=2; N=2; O=1; wT=0.1; h=(1.1)*(2*wT*N); Nxy=2;
[xS,yS,zS] = constrWireAnt(h,ra,ri,phi,N,O,wT,Nxy);
% calc B-Fields
I = 1; Nx = 50; Ny = 50; Nz = 50; Ns = [Nx,Ny,Nz];
xminb=-(h+ra); yminb=-(h+ra); zminb=-(h+ra);
xmaxb=h+ra;    ymaxb=h+ra;    zmaxb= h+ra;
bBox = [xminb,yminb,zminb; xmaxb,ymaxb,zmaxb];
% [X,Y,Z,BX,BY,BZ,normB]   = CalcBFields_Wire_Antenna_v2(I,xS,yS,zS,bBox,Ns);
[X,Y,Z,BX,BY,BZ] = CalcB_WireAnt(I,xS,yS,zS,bBox,Ns);
%% export 
[fileName,path,indx] = uiputfile('antenna_wire_data.csv');
exportAntData(X,Y,Z,BX,BY,BZ,Nx,Ny,Nz,fileName)