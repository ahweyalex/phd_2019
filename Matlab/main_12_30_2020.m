% Alexander Moreno
% DATE: 12-30-2020
clear all; close all; clc;
%% --------------------------------[INPUTS]-------------------------------%
%----------------------------INPUTS:LOOP1---------------------------------%
wT      = 0.2546e-3;    % 30AWG wire gauge <scalar> [m]
O       = 1;            % starting orientation: <scalar> [unitless] 1/0
I1      = 1;            % current <scalar> [A]
u0      = 4*pi*10^-7;   % free space permeability <scalar> [H/m]
ra1     = 10e-3;        % y-axis <scalar> [m]
ri1     = 15e-3;        % x-axis <scalar> [m]
L1      = ra1;          % y-axis <scalar> [m]
W1      = ri1;          % x-axis <scalar> [m]
Nxy1    = 1;            % number of coils <scalar>
N       = 3;            % number of turns in z-direction <scalar>
numSeg  = 200;          % number of points along each coil <scalar>
gap     = 0;            % gap <scalar> [m]
h       = wT*0.35;      % height of structure
zEnd    = N*2*pi*h;     % final z-value 
ANT1    = struct('NXY',Nxy1,'N',N,'ra',ra1,'ri',ri1);
%----------------------------INPUTS:LOOP2---------------------------------%
I2      = 1;            % current <scalar> [A]
ur      = 2.7;          % <scalar> 
ra2     = 10e-3;         % y-axis <scalar> [m]
ri2     = 15e-3;         % x-axis <scalar> [m]
L1      = ra2;          % y-axis <scalar> [m]
W1      = ri2;          % x-axis <scalar> [m]
l       = 7e-3;         % length of loop 2 <scalar> [m]
Nxy2    = 1;            % number of coils <scalar>
N2      = 3;            % number of turns in z-direction <scalar>
h2       = wT*0.35;      % height of structure
zEnd2    = N2*2*pi*h;     % final z-value 
xpos    = 0;            % center x-postion of loop 2 <scalar> [m]
ypos    = 0;            % center y-postion of loop 2 <scalar> [m]
%zpos    = 4*zEnd + zEnd/2;  % center z-postion of loop 2 <scalar> [m]
%zpos    = 4*zEnd2;  % center z-postion of loop 2 <scalar> [m]
zpos    = 4*zEnd + ri1/2;
a       = 0;            % yaw   <scalar> [deg] 
b       = 0;            % pitch <scalar> [deg] 
g       = 0;            % roll  <scalar> [deg] 
SEL2    = 'e';          % selector ellipse: 'e' or rect: 'r'
TAG = struct('xpos',xpos,'ypos',ypos,'zpos',zpos,...
             'ri',ri2,'ra',ra2,'l',l,...
             'NXY',Nxy2,'N',N2,...
             'ur',ur,...
             'a',a,'b',b,'g',g);
a=[];b=[];g=[];
rotM = struct('a',a,'b',b,'g',g);
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
SEL1='e';  % indicator for ellipse self or mutual inductance 
[sx30,sy30,sz30] = constrCircWire(h,ra1,ri1,numSeg,N,O,wT,Nxy1);
% construct rect multi-coil wire 
%SEL1='r'; % indicator for rectangle self or mutual inductance 
%[sx30,sy30,sz30] = constrRectWire(h30,W,L,wT30,numSeg,N,Nxy,O,gap);
%---------------------------PLOTTING--------------------------------------%
FS=14;
figure(1)
H = plot3(sx30/1e-3,sy30/1e-3,sz30/1e-3,'.-');
xlabel('x[mm]','FontSize', FS, 'Color', 'g', 'FontWeight', 'bold'); 
ylabel('y[mm]','FontSize', FS, 'Color', 'r', 'FontWeight', 'bold');
zlabel('z[mm]','FontSize', FS, 'Color', 'b', 'FontWeight', 'bold');
title('Rect ri10mm ra15mm N:3 Nxy:1','FontSize', FS,'FontWeight', 'bold');
view(45,45); grid on; 
S30 = [sx30,sy30,sz30]';
%-----------------------CONSTRUCT:SPATIAL PTS-----------------------------%
%-------------------------TO SOLVE BFIELDS--------------------------------%
Nx = 1000;  % resolution along x-direction  <scalar> [int]
Ny = 1000;  % resolution along y-direction  <scalar> [int]
Nz = 2;     % resolution along z-direction  <scalar> [int]

%Nx = 10;  % resolution along x-direction  <scalar> [int]
%Ny = 10;  % resolution along y-direction  <scalar> [int]
%Nz = 10;
% upper/lower bounds based off the largest dim of loop
% loop 1 (self)
if(ri1>ra1)
    b1 = ri1;
elseif(ra1>ri1)
    b1 = ra1;
elseif(ra1==ri1)
    b1 = ra1;
end
% % loop 2 (mutual)
% if(ri2>ra2)
%     b2 = ri2;
% elseif(ra2>ri2)
%     b2 = ra2;
% elseif(ra2==ri2)
%     b2 = ra2;
% end
b2 = 2*zpos;
%-------------------min/max bounds for spatial points---------------------%
%---------------------------self-inductance-------------------------------% 
% lower bounds
xminb11 = -1.01*b1;   % lower x-bound
yminb11 = -1.01*b1;   % lower y-bound
zminb11 = zEnd/2;     % lower z-bound (self-inductance)
% upper bounds 
xmaxb11 = 1.01*b1;    % maximum x-bound
ymaxb11 = 1.01*b1;    % maximum y-bound
zmaxb11 = zEnd/2;     % maximum z-bound (self-inductance)
%-------------------------mutual-inductance-------------------------------% 
% lower bounds
xminb12 = -1.01*b2;   % lower x-bound
yminb12 = -1.01*b2;   % lower y-bound
zminb12 = zpos;      % lower z-bound (mutual-inductance)
% upper bounds 
xmaxb12 = 1.01*b2;    % maximum x-bound
ymaxb12 = 1.01*b2;    % maximum y-bound
zmaxb12 = zpos;    % maximum y-bound
a  = 0;
b  = 0;
g  = -90;
rotM = struct('a',a,'b',b,'g',g);
%-------------------------------------------------------------------------%
Ns      = [Nx,Ny,Nz];
% self-inductance
bBox11  = [xminb11,yminb11,zminb11; xmaxb11,ymaxb11,zmaxb11];
% mutual-inductance
bBox12  = [xminb12,yminb12,zminb12; xmaxb12,ymaxb12,zmaxb12];
%=========================================================================%
%============================[END:CONSTRUCT]==============================%
%=========================================================================%

%% -----------------------------[COMPUTE]---------------------------------%
%--------------------------COMPUTE BFIELDS--------------------------------%
% d = 'SELF_IND';
% [X11,Y11,Z11,BX11,BY11,BZ11] = CalcBSLOW(I1,S30,bBox11,Ns,rotM,d); 
% %[X11,Y11,Z11,BX11,BY11,BZ11] = CalcFAST(I1,S30,bBox11,Ns,rotM,d);
% SELF_IND = struct('X',  X11,'Y',  Y11,'Z',  Z11,...
%                   'BX',BX11,'BY',BY11,'BZ',BZ11);

d = 'MULT_IND';
[X12,Y12,Z12,BX12,BY12,BZ12] = CalcBSLOW(I1,S30,bBox12,Ns,rotM,d);
%[X12,Y12,Z12,BX12,BY12,BZ12] = CalcFAST(I1,S30,bBox12,Ns,rotM,d);
MULT_IND = struct('X',  X12,'Y',  Y12, 'Z', Z12,...
                  'BX',BX12,'BY',BY12,'BZ',BZ12);
%---------------------------SELF-INDUCTANCE-------------------------------%
% BFields normal to a loop 1 is in z-direction, assuming the coils are only
% upon the xy-plane
% [L11] = self_Inductance_BFields(SELF_IND,ANT1,I1,SEL1);
% %L11 = selfInductance_BFields(wT,ri1,ra1,I,X2,Y2,Bnorm,SEL,N,G); %OLD VER
%%
%---------------------------MUTUAL-INDUCTANCE-----------------------------%
clc;
[M12] = mutual_Inductance_BFields(MULT_IND,ANT1,TAG,I1,SEL2,rotM);
%=========================================================================%
%=============================[END:COMPUTE]===============================%
%=========================================================================%
disp('done')