clear all; close all; clc;

%global gData;
%gData = struct('h',v0,'W',v0,'L',v0,'wT',v0,'N',v0,'O',v0,'Nxy',v0,'phi',v0,'ra',v0,'ri',v0); 
%{
global Units;
global AntDim; 
global Bdim;
v0 = 'm';
Units = struct('h',v0,'W',v0,'L',v0,'wT',v0,'phi',v0,'dimx',v0,'dimy',...
    v0,'dimz',v0,'dimI',v0,'dimBF',v0);
v0 = 0;
AntDim = struct('h',v0,'ra',v0,'ri',v0,'wT',v0,'N',v0,'O',v0,'phi',v0,...
    'W',v0,'L',v0,'Nxy',v0);
Bdim  = struct('Nx',v0,'xmin',v0,'xmax',v0,'Ny',v0,'ymin',v0,...
    'ymax',v0,'Nz',v0,'zmin',v0,'zmax',v0,'I',v0,'v','v0'); 

%global A;
global S;
global B;
A = struct('X',v0,'Y',v0,'Z',v0);
S = struct('X',v0,'Y',v0,'Z',v0);
B = struct('BX',v0,'BY',v0,'BZ',v0,'X',v0,'Y',v0,'Z',v0);
%}

Ant_Wire_GUI()
