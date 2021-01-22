clear all; close all; clc;
% P0 = [1,2,4];
% P1 = [2,1,4];
% P2 = [9,2,4];
% normalV = cross(P1-P0,P2-P0);
%%
clear all; close all; clc;

Nx   = 1000;  % resolution along x-direction  <scalar> [int]
Ny   = 1000;  % resolution along y-direction  <scalar> [int]
Nx   = 10;  % resolution along x-direction  <scalar> [int]
Ny   = 10;  % resolution along y-direction  <scalar> [int]

Nz   = 2;
wT   = 0.2546e-3;    % 30AWG wire gauge <scalar> [m]
h    = wT*0.35;      % height of structure
N    = 3;
zEnd = N*2*pi*h;     % final z-value 
ri1  = 15e-3;        % x-axis <scalar> [m]
zpos = 4*zEnd + ri1/2;
%zpos = 4;

b2 = 2*zpos;
xminb12 = -1.01*b2;   % lower x-bound  
yminb12 = -1.01*b2;   % lower y-bound
zminb12 = zpos;      % lower z-bound (mutual-inductance)
% upper bounds 
xmaxb12 = 1.01*b2;    % maximum x-bound
ymaxb12 = 1.01*b2;    % maximum y-bound
zmaxb12 = zpos;    % maximum y-bound
x_M = linspace(xminb12, xmaxb12, Nx);
y_M = linspace(yminb12, ymaxb12, Ny);
z_M = linspace(zminb12, zmaxb12, Nz);
zn  = 1;
[X1,Y1,Z1]=meshgrid(x_M,y_M,z_M);
X = squeeze(X1(:,:,zn));
Y = squeeze(Y1(:,:,zn));
Z = squeeze(Z1(:,:,zn));
figure(1)
H = surf(X,Y,Z);
xlabel('x');ylabel('y');zlabel('z');
title('[0,0,1]');
view(140,45)
axis tight   % set tight range

P0 = [X(1,1),   Y(1,1),    Z(1,1)];
P1 = [X(2,2),   Y(2,2),    Z(2,2)];
P2 = [X(end,1), Y(2,end),  Z(1,3)];
nV0 = cross(P1-P0,P2-P0);
nV  = nV0/norm(nV0)
% rotate
a  = 0;
b  = 90;
g  = 0;
rotM = struct('a',a,'b',b,'g',g);
[X2,Y2,Z2] = rotate_loop2(X,Y,Z,a,b,g);
[rx,ry,rz] = rotate_loop2(0,0,1,a,b,g);

P0_2 = [X2(1,1),   Y2(1,1),    Z2(1,1)];
P1_2 = [X2(2,2),   Y2(2,2),    Z2(2,2)];
P2_2 = [X2(end,1), Y2(2,end),  Z2(3,3)];
nV0_2 = cross(P1_2-P0_2,P2_2-P0_2);
nV_2  = nV0_2/norm(nV0_2)
normV = cross(nV_2,nV)
rV    = [rx,ry,rz]
figure(2)
H = surf(X2,Y2,Z2);
xlabel('x');ylabel('y');zlabel('z');
title('[1,0,0]');
axis tight   % set tight range
view(140,45)