clear all; close all; clc;

Nx   = 10;  % resolution along x-direction  <scalar> [int]
Ny   = 10;  % resolution along y-direction  <scalar> [int]
Nz   = 10;
wT   = 0.2546e-3;    % 30AWG wire gauge <scalar> [m]
h    = wT*0.35;      % height of structure
N    = 3;
zEnd = N*2*pi*h;     % final z-value 
ri1  = 15e-3;        % x-axis <scalar> [m]
zpos = 4*zEnd + ri1/2;
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
%%
figure(1)
H1= surf(X,Y,Z);
xlabel('x');ylabel('y');zlabel('z');
title('z-direction norm:[0,0,1]');
grid on;
% rotate
a  = 0;
b  = 0;
g  = 90;
rotM = struct('a',a,'b',b,'g',g);
tx = 0; ty = 0; tz = 1;
normV = [0,0,1];
A = normV
[tx1,ty1,tz1] = rotate_loop2(tx,ty,tz,a,b,g);
rot_normV = [tx1,ty1,tz1];
B = rot_normV
%
clc;
[X2,Y2,Z2] = rotate_loop2(X1,Y1,Z1,a,b,g);
% finding normal vector
P0 = [X(1,1),Y(1,1),0];
P1 = [X(1,end-1),Y(end-1,1),Z(1,end-1)];
%P2 = [X(1,end),Y(end,1),Z(1,end)];
P2 = [X(end-1,1),Y(1,end-1),Z(end-1,1)];

% P0 = [X2(1,1),Y2(1,1),Z2(1,2)]
% P1 = [X2(1,2),Y2(2,1),Z2(1,2)]
% P2 = [X2(1,3),Y2(3,1),Z2(1,3)]
normalV = cross(P1-P0,P2-P0);
%B = normalV;
%
%C = cross(A,B);
%dot(C,A)==0 & dot(C,B)==0
%
figure(2)
H1= surf(X2,Y2,Z2);
xlabel('x');ylabel('y');zlabel('z');
title('rot, norm:[1,0,0]');
grid on;