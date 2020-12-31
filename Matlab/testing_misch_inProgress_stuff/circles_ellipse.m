
clear all; close all; clc;
% define grid
Sx = 10;
Sy = 10;
Nx = 100;
Ny = round(Nx*Sy/Sx);
%meshgrid
dx = Sx/Nx;
dy = Sy/Ny;
xa = [0.5:Nx-0.5]*dx;       xa = xa-mean(xa);
ya = [0.5:Ny-0.5]*dy;       ya = ya-mean(ya);
[Y,X] = meshgrid(ya,xa);
RSQ = X.^2 + Y.^2;
imagesc(xa,ya,RSQ.')
%%
%clear all; close all; clc;
% define grid
Sx = 10;
Sy = 10;
Nx = 1000;
Ny = round(Nx*Sy/Sx);
%meshgrid
dx = Sx/Nx;
dy = Sy/Ny;
% OLD
% xa = [0.5:Nx-0.5]*dx;      
% xa = xa-mean(xa);
% ya = [0.5:Ny-0.5]*dy;       
% ya = ya-mean(ya);
% [Y,X] = meshgrid(ya,xa);

% NEW
xminb = -30e-3;
xmaxb =  30e-3;
yminb = -30e-3;
ymaxb =  30e-3;
x_M = linspace(xminb, xmaxb, Nx);
y_M = linspace(yminb, ymaxb, Ny);
[X2,Y2]=meshgrid(x_M,y_M);

% rotate coordinates
degrees = pi/180;
phi     = 30*degrees;
[THETA,R] = cart2pol(X2,Y2);
[X,Y]   = pol2cart(THETA +phi,R);
xpos = -1e-3;
ypos = -2e3;
% build object
ra   = 5e-3;   % y-axis
ri   = 2e-3;   % x-axis
x1 = -ri;
x2 =  ri;
y1 = -ra;
y2 =  ra;
% OLD
% x1 = -3;
% x2 =  3; 
% y1 = -1.5;
% y2 =  1.5;
p=10e-3; 
q=5e-3;

O1 = (X>=x1+p & X<=x2+p & Y>=y1+q & Y<=y2+q);
%O1 = (X>=x1 & X<=x2 & Y>=y1 & Y<=y2);

%figure(1)
imagesc(x_M./1e-3,y_M./1e-3,O1.')
%imagesc(xa,ya,O1.')
%imagesc(xa,ya,THETA.');
%imagesc(xa,ya,R.');
axis equal tight;
colorbar;
grid on;
%%
% visualize radial grid
figure(2)
%subplot(1,2,1);
%imagesc(xa,ya,RSQ.');
%imagesc(xa,ya,THETA.');
imagesc(xa,ya,R.');
axis equal tight;
colorbar;
title('RSQ');

%% build a circle
r = 4;
C = (RSQ <= r^2);

% visualize radial grid
subplot(1,2,2);
imagesc(xa,ya,C.');
axis equal tight;
colorbar;
title('object');

%% build a ellipse
x0 = -2.5;
y0 = -3; 
rx = 4;
ry = 2;
E = ((X-x0)/rx).^2 + ((Y-y0)/ry).^2 <= 1;
subplot(2,2,2);
imagesc(xa,ya,E.');
axis equal tight;
colorbar;
title('object');