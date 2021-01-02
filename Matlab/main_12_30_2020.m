% Alexander Moreno
% DATE: 12-30-2020
clear all; close all; clc;
%% --------------------------------[INPUTS]-------------------------------%
%----------------------------INPUTS:LOOP1---------------------------------%
wT      = 0.2546e-3;    % 30AWG wire gauge <scalar> [m]
O       = 1;            % starting orientation: <scalar> [unitless] 1/0
I1      = 1;            % current <scalar> [A]
u0      = 4*pi*10^-7;   % free space permeability <scalar> [H/m]
ra1     = 15e-3;        % y-axis <scalar> [m]
ri1     = 10e-3;        % x-axis <scalar> [m]
L1      = ra1;          % y-axis <scalar> [m]
W1      = ri1;          % x-axis <scalar> [m]
Nxy1    = 1;            % number of coils <scalar>
N       = 3;            % number of turns in z-direction <scalar>
numSeg  = 200;          % number of points along each coil <scalar>
gap     = 0;            % gap <scalar> [m]
zEnd    = N*2*pi*h;     % final z-value 
%----------------------------INPUTS:LOOP2---------------------------------%
I2      = 1;           % current <scalar> [A]
ur      = 2.7;          % <scalar> 
ra2     = 15e-3;        % y-axis <scalar> [m]
ri2     = 10e-3;        % x-axis <scalar> [m]
L1      = ra2;          % y-axis <scalar> [m]
W1      = ri2;          % x-axis <scalar> [m]
l       = 7e-3;         % length of loop 2 <scalar> [m]
Nxy2    = 1;            % number of coils <scalar>
N2      = 3;            % number of turns in z-direction <scalar>
xpos    = 0;            % center x-postion of loop 2 <scalar> [m]
ypos    = 0;            % center y-postion of loop 2 <scalar> [m]
zpos    = 4*zEnd;       % center z-postion of loop 2 <scalar> [m]
a       = 0;            % yaw   <scalar> [deg] 
b       = 0;            % pitch <scalar> [deg] 
g       = 0;            % roll  <scalar> [deg] 
SEL2     = 'e';          % selector ellipse: 'e' or rect: 'r'
tag = struct('I',I2,'ur',ur,'rx',ri2,'ry',ra2,'l',l,'Nxy',Nxy2,'N',N2,...
             'xpos',xpos,'ypos',ypos,'zpos',zpos,...
             'a',a,'b',b,'g',g);
%--------------------------INPUTS:INDUCTANCE------------------------------%
% self-inductance
X11=[];Y11=[];Z11=[]; BX11=[];BY11=[];BZ11=[];
SELF_IND = struct('X11',  X11,'Y11',  Y11,'Z11',  Z11,...
                  'BX11',BX11,'BY11',BY11,'BZ11',BZ11);
% mutual-inductance
X12=[];Y12=[];Z12=[]; BX12=[];BY12=[];BZ12=[];
MULT_IND = struct('X12',  X12,'Y12',  Y12,'Z12',  Z12,...
                  'BX12',BX12,'BY12',BY12,'BZ12',BZ12);
%=========================================================================%
%===============================[END:INPUTS]==============================%
%=========================================================================%


%% ----------------------------[CONSTRUCT]--------------------------------%
%--------------------------CONSTRUCT:LOOP1--------------------------------%
% construct ellipse multi-coil wire 
G='c';  % indicator for self or mutual inductance 
[sx30,sy30,sz30] = constrCircWire(h,ra,ri2,numSeg,N,O,wT,Nxy);
% construct rect multi-coil wire 
%G='r';
%[sx30,sy30,sz30] = constrRectWire(h30,W,L,wT30,numSeg,N,Nxy,O,gap);
figure(1)
H = plot3(sx30/1e-3,sy30/1e-3,sz30/1e-3,'.-');
xlabel('x[mm]','FontSize', FS, 'Color', 'g', 'FontWeight', 'bold'); 
ylabel('y[mm]','FontSize', FS, 'Color', 'r', 'FontWeight', 'bold');
zlabel('z[mm]','FontSize', FS, 'Color', 'b', 'FontWeight', 'bold');
title('Rect ri10mm ra15mm N:3 Nxy:1');
view(45,45); grid on; 
S30 = [sx30,sy30,sz30]';
%-----------------------CONSTRUCT:SPATIAL PTS-----------------------------%
%-------------------------TO SOLVE BFIELDS--------------------------------%
Nx = 1000;  % resolution along x-direction  <scalar> [int]
Ny = 1000;  % resolution along y-direction  <scalar> [int]
Nz = 2;     % resolution along z-direction  <scalar> [int]
% upper/lower bounds based off the largest dim of loop
if(ri2>ra)
    b = ri2;
elseif(ra>ri2)
    b = ra;
elseif(ra==ri2)
    b = ra;
end
% lower bounds
xminb = -1.01*b;    % lower x-bound
yminb = -1.01*b;    % lower y-bound
zminb11 = zEnd/2;   % lower z-bound (self-inductance)
zminb12 = zpos;     % lower z-bound (mutual-inductance)
% upper bounds 
xmaxb = 1.01*b;     % maximum x-bound
ymaxb = 1.01*b;     % maximum y-bound
zmaxb11 = zEnd/2;   % maximum z-bound (self-inductance)
zminb12 = zpos;     % maximum z-bound (mutual-inductance)
Ns    = [Nx,Ny,Nz];
% self-inductance
bbox11  = [xminb,yminb,zminb11; xmaxb,ymaxb,zmaxb11];
% mutual-inductance
bbox12  = [xminb,yminb,zminb11; xmaxb,ymaxb,zmaxb12];
%=========================================================================%
%============================[END:CONSTRUCT]==============================%
%=========================================================================%

%% -----------------------------[COMPUTE]---------------------------------%
%--------------------------COMPUTE BFIELDS--------------------------------%
[X11,Y11,Z11,BX11,BY11,BZ11] = CalcBSLOW(I,S30,bBox1,Ns); 
%[X11,Y11,Z11,BX11,BY11,BZ11] = CalcFAST(I,S30,bBox1,Ns);
SELF_IND = struct('X11',  X11,'Y11',  Y11,'Z11',  Z11,...
                  'BX11',BX11,'BY11',BY11,'BZ11',BZ11);
              
[X12,Y12,Z12,BX12,BY12,BZ12] = CalcBSLOW(I,S30,bBox1,Ns);
%[X12,Y12,Z12,BX12,BY12,BZ12] = CalcFAST(I,S30,bBox1,Ns);
MULT_IND = struct('X12',  X12,'Y12',  Y12,'Z12',  Z12,...
                  'BX12',BX12,'BY12',BY12,'BZ12',BZ12);
%---------------------------SELF-INDUCTANCE-------------------------------%
zn    = 1; % choose which XY-Plane do you want to use 
X2    = squeeze(X11(:,:,zn));
Y2    = squeeze(Y11(:,:,zn));
% BFields normal to a loop 1 is in z-direction, assuming the coils are only
% upon the xy-plane
Bnorm = squeeze(BZ11(:,:,zn));  
SEL   = 0;
L11 = selfInductance_BFields(wT,ri1,ra1,I,X2,Y2,Bnorm,SEL,N,G);
%---------------------------MUTUAL-INDUCTANCE-----------------------------%
zn    = 1; % choose which XY-PLane do you want to use 
X2    = squeeze(X11(:,:,zn));
Y2    = squeeze(Y11(:,:,zn));
Bnorm = squeeze(BZ11(:,:,zn));
SEL2   = 0;
M12 = multInductance_BFields(wT,ri1,ra1,I,X2,Y2,Bnorm,SEL,N,G);
%=========================================================================%
%=============================[END:COMPUTE]===============================%
%=========================================================================%















