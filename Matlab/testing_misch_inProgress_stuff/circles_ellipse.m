%close all; clc; clear all;
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
% rotate coordinates
degrees = pi/180;
phi     = 0*degrees;
[THETA,R] = cart2pol(X,Y);
[X,Y]     = pol2cart(THETA +phi,R);
% build object
x1 = -3;
x2 =  3; 
y1 = -1.5;
y2 =  1.5;
O1 = (X>=x1 & X<=x2 & Y>=y1 & Y<=y2);

figure(1)
imagesc(xa,ya,O1.')
%imagesc(xa,ya,THETA.');
%imagesc(xa,ya,R.');
axis equal tight;
colorbar;
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