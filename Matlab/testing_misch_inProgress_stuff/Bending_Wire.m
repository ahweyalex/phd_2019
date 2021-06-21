% Alexander Moreno
% DATE: 06-19-2021
% ver: 0.1

clear all; close all; clc;
tic;
% --------------------------------[INPUTS]-------------------------------%
%----------------------------INPUTS:LOOP1---------------------------------%
wT      = 0.2546e-3;    % 30AWG wire gauge <scalar> [m]
%O       = 0;            % starting orientation: <scalar> [unitless] 1/0
O       = 1;            % rect
I1      = 1;            % current <scalar> [A]
u0      = 4*pi*10^-7;   % free space permeability <scalar> [H/m]
ra1     = 10e-3;        % y-axis <scalar> [m]
ri1     = 15e-3;        % x-axis <scalar> [m]
L1      = ra1;          % y-axis <scalar> [m]
W1      = ri1;          % x-axis <scalar> [m]
%=========================================================================%
Nxy1    = 1;            % number of coils <scalar>
%N       = 9;            % number of turns in z-direction <scalar>
N       = 2;            % number of turns in z-direction <scalar>
%=========================================================================%
numSeg  = 200*6;          % number of points along each coil <scalar>
gap     = 0;            % gap <scalar> [m]
h       = wT*0.35;      % height of structure
zEnd    = N*2*pi*h;     % final z-value 
%zEnd    = 10e-3;
ANT1    = struct('NXY',Nxy1,'N',N,'ra',ra1,'ri',ri1);
%----------------------------INPUTS:LOOP2---------------------------------%
I2      = 1;            % current <scalar> [A]
wT2     = 0.2546e-3;    % 30AWG wire gauge <scalar> [m]
ur      = 2.7;          % <scalar> 
ra2     = 10e-3;         % y-axis <scalar> [m]
ri2     = 15e-3;         % x-axis <scalar> [m]
L2      = ra2;          % y-axis <scalar> [m]
W2      = ri2;          % x-axis <scalar> [m]
l       = 7e-3;         % length of loop 2 <scalar> [m]
Nxy2    = 1;            % number of coils <scalar>
N2      = 3;            % number of turns in z-direction <scalar>
h2      = wT*0.35;      % height of structure
zEnd2   = N2*2*pi*h;     % final z-value 

xpos    = 0;            % center x-postion of loop 2 <scalar> [m]
ypos    = 5e-3;            % center y-postion of loop 2 <scalar> [m]
% rot 90
zpos = (4*zEnd + ri1/2)*1.5;
xshift  = 0;
yshift  = ypos;
zshift = zpos;
% a       = 0;            % yaw   <scalar> [deg] 
% b       = 0;            % pitch <scalar> [deg] 
% g       = 0;            % roll  <scalar> [deg] 
% a =  0;     % yaw   <scalar> [deg] 
% b =  0;     % pitch <scalar> [deg] 
% g = 45;     % roll  <scalar> [deg] 
% rot 90
a = 0;     % yaw   <scalar> [deg] 
b = 0;     % pitch <scalar> [deg] 
%g =  0;
g = 90;     % roll  <scalar> [deg] 
SEL2    = 'e';          % selector ellipse: 'e' or rect: 'r'
TAG = struct('xpos',xpos,'ypos',ypos,'zpos',zpos,...
             'ri',ri2,'ra',ra2,'l',l,...
             'NXY',Nxy2,'N',N2,...
             'ur',ur,...
             'a',a,'b',b,'g',g);
rotM = struct('a',a,'b',b,'g',g,...
              'xshift',xshift,'yshift',yshift,'zshift',zshift);
%--------------------------INPUTS:INDUCTANCE------------------------------%
% self-inductance
X11=[];Y11=[];Z11=[]; BX11=[];BY11=[];BZ11=[];
SELF_IND = struct('X11',  X11,'Y11',  Y11,'Z11',  Z11,...
                  'BX11',BX11,'BY11',BY11,'BZ11',BZ11);
%%% ANT 1
SEL1='e';  % indicator for ellipse self or mutual inductance 
[sx30,sy30,sz30] = constrCircWire(h,ra1,ri1,numSeg,N,O,wT,Nxy1);

%
%---------------------------PLOTTING--------------------------------------%
%%
FS=10;
hold all;
figure(1)
H = plot3(sx30./1e-3, sy30./1e-3, sz30./1e-3);      
set(H(1),'color','r'); 
xlabel('x[mm]','FontSize', FS, 'Color', 'r', 'FontWeight', 'bold'); 
ylabel('y[mm]','FontSize', FS, 'Color', 'g', 'FontWeight', 'bold'); 
zlabel('z[mm]','FontSize', FS, 'Color', 'b', 'FontWeight', 'bold');
title('Example Nxy:1 N:3','FontSize', FS,...
    'FontWeight', 'bold');
S30 = [sx30,sy30,sz30]';
view(140,45); grid on;
hold on;