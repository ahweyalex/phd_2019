clear all; close all; clc;

Nx   = 10;  % resolution along x-direction  <scalar> [int]
Ny   = 10;  % resolution along y-direction  <scalar> [int]
Nz   = 10;
wT   = 0.2546e-3;    % 30AWG wire gauge <scalar> [m]
h    = wT*0.35;      % height of structure
N    = 3;            % Number of turns (z-dir)
zEnd = N*2*pi*h;     % final z-value 
ri1  = 15e-3;        % x-axis <scalar> [m]
zpos = 4*zEnd + ri1/2;
b2 = 2*zpos;
% lower bounds
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
% XY-plane
[X1,Y1,Z1]=meshgrid(x_M,y_M,z_M);
X = squeeze(X1(:,:,zn));
Y = squeeze(Y1(:,:,zn));
Z = squeeze(Z1(:,:,zn));
tx = 0; ty = 0; tz = 1;
normV1 = [0,0,1]    % normal vector is in z-direction
% finding normal vector
P0 = [X(1,1),   Y(1,1),     Z(1,1)];
P1 = [X(2,2),   Y(2,2),     Z(2,2)];
P2 = [X(end,1), Y(2,end),   Z(3,3)];
nV = cross(P1-P0,P2-P0);
normalV1 = nV/norm(nV)
%% rotated 
% obtain a plane
X = squeeze(X1(:,:,zn));
Y = squeeze(Y1(:,:,zn));
Z = squeeze(Z1(:,:,zn));
% rotate
a  = 0;     % yaw (rotate in xy-plane) 
b  = 0;     % pitch (z <==> x planes)
g  = 90;    % roll  (z <==> -y planes)
rotM = struct('a',a,'b',b,'g',g);
[X2,Y2,Z2] = rotate_loop2(X1,Y1,Z1,a,b,g);
X3 = squeeze(X2(:,:,zn));
Y3 = squeeze(Y2(:,:,zn));
Z3 = squeeze(Z2(:,:,zn));
[rx1,ry1,rz1] = rotate_loop2(tx,ty,tz,a,b,g);
normV2 = [rx1,ry1,rz1]
P0r = [X3(1,1),     Y3(1,1),    Z3(1,1)];
P1r = [X3(2,2),     Y3(2,1),    Z3(2,2)];
P2r = [X3(end,1),   Y3(2,end),  Z3(3,3)];
nV2 = cross(P1r-P0r,P2r-P0r);
normalV2 = nV2/norm(nV2)
%% plots
figure(1)
H1 = surf(X,Y,Z);
xlabel('x');ylabel('y');zlabel('z');
title('z-direction norm:[0,0,1]');
grid on;

figure(2)
H2 = surf(X2,Y2,Z2);
xlabel('x');ylabel('y');zlabel('z');
title('rotated');
grid on;
