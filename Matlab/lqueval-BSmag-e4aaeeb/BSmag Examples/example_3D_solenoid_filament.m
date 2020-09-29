%---------------------------------------------------
%  NAME:      example_3D_solenoid_filament.m
%  WHAT:      Calculation of the magnetic field of a solenoid
%             on a volume (+ 3D plot).
%  REQUIRED:  BSmag Toolbox 20150407
%  AUTHOR:    20150407, L. Queval (loic.queval@gmail.com)
%  COPYRIGHT: 2015, Loic Quéval, BSD License (http://opensource.org/licenses/BSD-3-Clause).
%----------------------------------------------------
%%
% Initialize
clear all, close all, clc
BSmag = BSmag_init(); % Initialize BSmag analysis

% Source points (where there is a current source)
%theta = linspace(-2*2*pi,2*2*pi,2*100);
%G     = 'r'; % rectanlge/square
G = 'c';
wT = 0.2546e-3;  % 30AWG 
N = 1;
global I0; I0 = struct('I',1);
h       = wT*0.35;  
zEnd    = h*N*2*pi;
ra      = 10e-3;
ri      = 10e-3;
W0      = ra;       
L0      = ri;  
%numSeg = 16; % rect
numSeg = 200; % circ
phi     = numSeg;
%O      = 1;
O       = 0;
Nxy     = 1;

%[Sx,Sy,Sz] = singleRectLoop(ra,ri,numSeg,wT,O);
[Sx,Sy,Sz] = singleEllipticalLoop(ra,ri,numSeg,wT,O);
plot3(Sx,Sy,Sz)
Gamma = [Sx,Sy,Sz];
%Gamma = [cos(theta'),sin(theta'),theta'/10]; % x,y,z [m,m,m]
I = 1; % filament current [A]
dGamma = 1e9; % filament max discretization step [m]
[BSmag] = BSmag_add_filament(BSmag,Gamma,I,dGamma);
%%
% Field points (where we want to calculate the field)
if (ri>=ra)
    %xyz = 2*ri;
    xyz = ri+wT;
elseif (ra>=ri)
    %xyz = 2*ra;
    xyz = ra+wT;
end
xminb = -xyz; 
xmaxb =  xyz;
yminb = -xyz; 
ymaxb =  xyz;
zminb = 0;
zmaxb = 0; 

nn = 1;
for ns=19:220
    Nz = 1;
    Nx = ns; Ny = Nx; 
    Ns = [Nx,Ny,Nz];
 
    x_M = linspace(xminb,xmaxb,Nx); % x [m]
    y_M = linspace(yminb,ymaxb,Ny); % y [m]
    z_M = linspace(zminb,zmaxb,Nz); % z [m]

    %x_M = linspace(-1.5,1.5,21); % x [m]
    %y_M = linspace(-2,2,22); % y [m]
    %z_M = linspace(-2,2,23); % z [m]
    [X_M,Y_M,Z_M]=meshgrid(x_M,y_M,z_M);
    BSmag_plot_field_points(BSmag,X_M,Y_M,Z_M); % shows the field points volume
    %
    % Biot-Savart Integration
    [BSmag,X,Y,Z,BX,BY,BZ] = BSmag_get_B(BSmag,X_M,Y_M,Z_M);
    %---------------------------------------------------------------------%
    [BSmag_L11(nn)] = selfInductance_BFields(ri,ra,I,X,Y,BZ,N,G);   
    indx(nn) = ceil(Nx/2);
    B__Z(nn)= BZ(ceil(Nx/2),ceil(Nx/2));
    nn = nn + 1;
end
%%
NN = 19:220;
fs = 12;

figure(1)
H=plot(NN,BSmag_L11(:)/1e-9,'.-');
xlabel('Resolution X/Y','FontWeight','bold','FontSize', fs);  
ylabel('L11[nH]','FontWeight','bold','FontSize', fs);
title('OTHER 2 Matlab Model[ZOOM]','FontWeight','bold','FontSize', fs);

figure(2)
H=plot(NN(2:end),B__Z(2:numel(NN))/1e-9,'.-');
xlabel('Resolution X/Y','FontWeight','bold','FontSize', fs);  
ylabel('BZ','FontWeight','bold','FontSize', fs);
title('OTHER 2 Matlab Model @approx(0,0,0)','FontWeight','bold','FontSize', fs);
disp('DONE!');