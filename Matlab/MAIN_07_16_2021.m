% Alexander Moreno
% DATE: 06-16-2021
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
N       = 3;            % number of turns in z-direction <scalar>
%=========================================================================%
numSeg  = 200*6*N;          % number of points along each coil <scalar>
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
%ra2     = 5e-3;         % y-axis <scalar> [m]
%ri2     = 7e-3;         % x-axis <scalar> [m]
L2      = ra2;          % y-axis <scalar> [m]
W2      = ri2;          % x-axis <scalar> [m]
l       = 7e-3;         % length of loop 2 <scalar> [m]
Nxy2    = 1;            % number of coils <scalar>
N2      = 3;            % number of turns in z-direction <scalar>
h2      = wT*0.35;      % height of structure
zEnd2   = N2*2*pi*h;     % final z-value 

xpos    = 0;            % center x-postion of loop 2 <scalar> [m]
%ypos    = 0;            % center y-postion of loop 2 <scalar> [m]
ypos    = 5e-3;            % center y-postion of loop 2 <scalar> [m]
% no rotation
%zpos    = (4*zEnd + ri1/2)*(1/4);
%zpos    = (4*zEnd + ri1/2)*(1/2);
%zpos    = (4*zEnd + ri1/2);
%zpos    = (4*zEnd + ri1/2)*(1/2) + zEnd;
% rot 45
%zpos = (4*zEnd+ri1/2);
% zpos = (4*zEnd + ri1/2)*2
%zpos = (4*zEnd+ri1/2)*(1.5);
%zpos = (4*zEnd+ri1/2)*(2);
%zpos    = (4*zEnd + ri1/2);
% rot 90
zpos = (4*zEnd + ri1/2)*1.5;
%zpos = (4*zEnd + ri1/2)*2;
xshift  = 0;
%yshift  = 0;
yshift  = ypos;
zshift = zpos;
%zshift  = zpos + ra2;

%zshift  = zpos + zEnd2/2;
%%zshift  = 4*zEnd + ri1; 
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
%X11=[];Y11=[];Z11=[]; BX11=[];BY11=[];BZ11=[];
%SELF_IND = struct('X11',  X11,'Y11',  Y11,'Z11',  Z11,...
%                  'BX11',BX11,'BY11',BY11,'BZ11',BZ11);

% mutual-inductance
X12=[];Y12=[];Z12=[]; BX12=[];BY12=[];BZ12=[];
MULT_IND = struct('X12',  X12,'Y12',  Y12,'Z12',  Z12,...
                  'BX12',BX12,'BY12',BY12,'BZ12',BZ12);
%=========================================================================%
%===============================[END:INPUTS]==============================%
%=========================================================================%


% ----------------------------[CONSTRUCT]--------------------------------%
%--------------------------CONSTRUCT:LOOP1--------------------------------%

% construct ellipse multi-coil wire 
%
%%% ANT 1
SEL1='e';  % indicator for ellipse self or mutual inductance 
[sx30,sy30,sz30] = constrCircWire(h,ra1,ri1,numSeg,N,O,wT,Nxy1);
%%% ANT 2
SEL2='e';  % indicator for ellipse self or mutual inductance 
[sx30_2,sy30_2,sz30_2]  = constrCircWire(h2,ra2,ri2,numSeg,N2,O,wT2,Nxy2);
[sx30_2r,sy30_2r,sz30_2r] = rotate_loop2(sx30_2,sy30_2,sz30_2,a,b,g);
sx30_2r = sx30_2r + xpos;
sy30_2r = sy30_2r + ypos;
sz30_2r = sz30_2r + zpos;
%}


%{
%%% ANT 1
% construct rect multi-coil wire 
SEL1='r'; % indicator for rectangle self or mutual inductance 
[sx30,sy30,sz30] =  constrRectWire(h,W1,L1,numSeg,N,O,wT,Nxy1,gap);

%%% ANT 2
SEL2='r'; % indicator for rectangle self or mutual inductance 
[sx30_2,sy30_2,sz30_2] =  constrRectWire(h2,W2,L2,numSeg,N2,O,wT,Nxy2,gap);
[sx30_2r,sy30_2r,sz30_2r] = rotate_loop2(sx30_2,sy30_2,sz30_2,a,b,g);
sx30_2r = sx30_2r + xpos;
sy30_2r = sy30_2r + ypos;
sz30_2r = sz30_2r + zpos;
%}

%
%---------------------------PLOTTING--------------------------------------%
%%
FS=10;
hold all;
figure(1)
%H = plot3(sx30(1:numel(sx30)/2)./1e-3, sy30(1:numel(sx30)/2)./1e-3,...
%          sz30(1:numel(sx30)/2)./1e-3,'.-',...
%          sx30(numel(sx30)/2+1:end)./1e-3,... 
%          sy30(numel(sx30)/2+1:end)./1e-3,...
%          sz30(numel(sx30)/2+1:end)./1e-3,'.-');
H = plot3(sx30./1e-3, sy30./1e-3, sz30./1e-3);      
set(H(1),'color','r'); 
%set(H(2),'color','b');      
%H = plot3(sx30(numel(sx30)/2+1:end)/1e-3,... 
%          sy30(numel(sx30)/2+1:end)/1e-3,...
%          sz30(numel(sx30)/2+1:end)/1e-3,'.-','Color','r');
xlabel('x[mm]','FontSize', FS, 'Color', 'r', 'FontWeight', 'bold'); 
ylabel('y[mm]','FontSize', FS, 'Color', 'g', 'FontWeight', 'bold'); 
zlabel('z[mm]','FontSize', FS, 'Color', 'b', 'FontWeight', 'bold');
%title('Rect ri35.25mm ra35.25mm N:3 Nxy:1','FontSize', FS,...
%    'FontWeight', 'bold');
title('Example Nxy:1 N:3','FontSize', FS,...
    'FontWeight', 'bold');
S30 = [sx30,sy30,sz30]';
%legend('Inner','Outer');
view(140,45); grid on;
%view(0,90);
hold on;
%%
%figure(5);
H = plot3(sx30_2r/1e-3,sy30_2r/1e-3,sz30_2r/1e-3,'.-');
xlabel('x[mm]','FontSize', FS, 'Color', 'r', 'FontWeight', 'bold'); 
ylabel('y[mm]','FontSize', FS, 'Color', 'g', 'FontWeight', 'bold');
zlabel('z[mm]','FontSize', FS, 'Color', 'b', 'FontWeight', 'bold');
title('Rect ri10mm ra15mm N:3 Nxy:1','FontSize', FS,'FontWeight', 'bold');
view(140,45);
%view(90,0);
%view(180,0);
grid on;
S30 = [sx30,sy30,sz30]'; 
%xlim([-20 20]); ylim([-20 20]); view(90,90); clc;
legend('ANT1','ANT2');
t = 't';
%%
%-----------------------CONSTRUCT:SPATIAL PTS-----------------------------%
%-------------------------TO SOLVE BFIELDS--------------------------------%
%Nx = 1e3;  % resolution along x-direction  <scalar> [int]
%Ny = 1e3;  % resolution along y-direction  <scalar> [int]
%Nz = 100;     % resolution along z-direction  <scalar> [int]

NN = 400;
Nx = NN;  % resolution along x-direction  <scalar> [int]
Ny = NN;  % resolution along y-direction  <scalar> [int]
Nz = NN;
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
%b2 = 2*zpos;
%-------------------min/max bounds for spatial points---------------------%
%---------------------------self-inductance-------------------------------% 
% lower bounds
%bds = 3.00; % 200%
bds = 2.00; % 100%
%bds = 1.75;
%bds = 1.02;
%bds = 1.25;
%bds = 1.10;
%bds = 1.50;

%%xminb11 = -bds*b1;   % lower x-bound
%%yminb11 = -bds*b1;   % lower y-bound
%zminb11 = zEnd/2;     % lower z-bound (self-inductance)
%zminb11 = 0;     % lower z-bound (self-inductance)
%%zminb11 = -bds*zEnd + zEnd;

%zminb11 = -bds*b1;

% upper bounds 
%%xmaxb11 = bds*b1;    % maximum x-bound
%%ymaxb11 = bds*b1;    % maximum y-bound
%zmaxb11 = zEnd*1.10;
%zmaxb11 = zEnd/2;     % maximum z-bound (self-inductance)
%%zmaxb11 = bds*zEnd;     % maximum z-bound (self-inductance)
%zmaxb11 = bds*b1;
%zmaxb11 = zEnd;

% abs bounds
bb = 20e-3;
% lower bounds
xminb11 = -bb;
yminb11 = -bb;
zminb11 = -bb;
% upper bounds 
xmaxb11 = +bb;
ymaxb11 = +bb;
zmaxb11 = +bb;

% ------------------------ ADD: 08-16-2021------------------%
% rewrite NN: 
% set delta: 
xd = (2*10e-3)/200;
x_M = xminb11:xd:xmaxb11;
NN = round(numel(x_M));
disp(strcat('NN:',num2str(NN)));
Nx = NN;  % resolution along x-direction  <scalar> [int]
Ny = NN;  % resolution along y-direction  <scalar> [int]
Nz = NN;
% ------------------------ ADD: 08-16-2021------------------%

%-------------------------mutual-inductance-------------------------------% 
% upper bounds
if(max(sx30_2r)>max(sy30_2r))
    b2mx = max(sx30_2r);
elseif(max(sy30_2r)>max(sx30_2r))
    b2mx = max(sy30_2r);
else
    b2mx = max(sx30_2r);
end
% % lower bounds
% if(min(sx30_2r)>min(sy30_2r))
%     b2mn = max(sy30_2r);
% elseif(min(sy30_2r)>min(sx30_2r))
%     b2mn = min(sx30_2r);
% else
%     b2mn = min(sx30_2r);
% end

b2mn = b2mx;

% % rotated 45 deg
% if(max(sx30_2)>max(sy30_2))
%     b2 = max(sx30_2);
% elseif(max(sy30_2)>max(sx30_2))
%     b2 = max(sy30_2);
% else
%     b2 = max(sx30_2);
% end
% b2mn = b2;
% b2mx = b2;

%b_offst = 1.01; % no rot
b_offst1 = 1.65; % rot
b_offst2 = 1.50; % rot
xminb12 = -b2mn*b_offst1 +xpos;
xmaxb12 =  b2mx*b_offst1 +xpos;
yminb12 = -b2mn*b_offst2 +ypos;
ymaxb12 =  b2mx*b_offst2 +ypos;
%
% xminb12 = -6e-3;
% xmaxb12 = +6e-3;
% yminb12 = -22e-3;
% ymaxb12 = +22e-3;

zminb12 = 0;
zmaxb12 = 0;
t = 't'
%-------------------------------------------------------------------------%
Ns      = [Nx,Ny,Nz];
% self-inductance
bBox11  = [xminb11,yminb11,zminb11; xmaxb11,ymaxb11,zmaxb11];
% mutual-inductance
bBox12  = [xminb12,yminb12,zminb12; xmaxb12,ymaxb12,zmaxb12];
%%
%--------------------------PLOT BFIELD LOC--------------------------------%
%
% create 1D arrays for each axis
x_M  = linspace(xminb11, xmaxb11, Nx);
xdel = abs(x_M(1) - x_M(2))/Nx
y_M  = linspace(yminb11, ymaxb11, Ny);
ydel = abs(y_M(1) - y_M(2))/Ny
z_M  = linspace(zminb11, zmaxb11, Nz);
zdel = abs(z_M(1) - z_M(2))/Nz
% get a single plane
zn = 1;
[X0,Y0,Z0]=meshgrid(x_M,y_M,z_M);
X2 = squeeze(X0(:,:,zn));
Y2 = squeeze(Y0(:,:,zn));
Z2 = squeeze(Z0(:,:,zn));
[Xr,Yr,Zr] = rotate_loop2(X2,Y2,Z2,a,b,g);
%xshift=0; yshift=0; zshift=0;
X = Xr + xshift;
Y = Yr + yshift;
Z = Zr + zshift;
H = surf(X,Y,Z);
FS = 14;
xlabel('x[mm]','FontSize', FS, 'Color', 'r', 'FontWeight', 'bold'); 
ylabel('y[mm]','FontSize', FS, 'Color', 'g', 'FontWeight', 'bold');
zlabel('z[mm]','FontSize', FS, 'Color', 'b', 'FontWeight', 'bold');
title('BF LOC ROT','FontSize', FS,'FontWeight', 'bold');
view(110,45); grid on; 
t = 't';
%}
%=========================================================================%
%============================[END:CONSTRUCT]==============================%
%=========================================================================%

%% -----------------------------[COMPUTE]---------------------------------%
%--------------------------COMPUTE BFIELDS--------------------------------%
d = 'SELF_IND';
%[X11,Y11,Z11,BX11,BY11,BZ11,A] = CalcBSLOW(I1,S30,bBox11,Ns,rotM,d); 
[X11,Y11,Z11,BX11,BY11,BZ11,AX,AY,AZ] = CalcBSLOW(I1,S30,bBox11,Ns,rotM,d);
[AXH,AYH,AZH] = ThreeMulti_cross(AX,AY,AZ,BX11,BY11,BZ11);
AcrossH = struct('AXH',AXH,'AYH',AYH,'AZH',AZH);

% %[X11,Y11,Z11,BX11,BY11,BZ11] = CalcFAST(I1,S30,bBox11,Ns,rotM,d);
SELF_IND = struct('X',  X11, 'Y', Y11, 'Z',Z11,...
                  'BX',BX11,'BY',BY11,'BZ',BZ11);
%d = 'MULT_IND';
%[X12,Y12,Z12,BX12,BY12,BZ12] = CalcBSLOW(I1,S30,bBox12,Ns,rotM,d);
%[X12,Y12,Z12,BX12,BY12,BZ12] = CalcFAST(I1,S30,bBox12,Ns,rotM,d);
%MULT_IND = struct('X',  X12,'Y',  Y12, 'Z', Z12,...
%                  'BX',BX12,'BY',BY12,'BZ',BZ12);

%=========================================================================%
%=============================[END:COMPUTE]===============================%
%=========================================================================%
%%
% compute self indutance via mag energy 
%[Wm, L11] = Calc_MagEng(SELF_IND,I1);
%[Wm, L11] = Calc_MagEng_v2(SELF_IND,I1);
SEL = 'E';
%[Wm, L11] = Calc_MagEng_v3(SELF_IND, ANT1, A, I1, SEL);
[Wm,WMA,WMB,L11] = Calc_MagEng_v4(SELF_IND, ANT1, AcrossH, I1, SEL);

%L11/1e-9
toc;
disp('done')
