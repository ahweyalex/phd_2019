clear all; close all; clc;
% lower bounds
xminb11 = -4.0;
yminb11 = -4.0;
zminb11 = -4.0;
% upper bounds
xmaxb11 = 4.0;
ymaxb11 = 4.0;
zmaxb11 = 4.0;
% 
w = abs(xminb11-xmaxb11);
l = abs(yminb11-ymaxb11);
h = abs(zminb11-zmaxb11);
v = w*l*h;
% number of samples 
NN = 100;
Nx = 2;
Ny = 2;
Nz = 2;
% set up (1D) arrays
x_M = linspace(xminb11, xmaxb11, Nx);
y_M = linspace(yminb11, ymaxb11, Ny);
z_M = linspace(zminb11, zmaxb11, Nz);
% set up multi-dim arrays 
[X,Y,Z]=meshgrid(x_M,y_M,z_M);
% deltas 
delx = abs( X(1,1,1) - X(1,2,1) );
dely = abs( Y(1,1,1) - Y(2,1,1) );
delz = abs( Z(1,1,1) - Z(1,1,2) );
res  = delx*dely*delz;
xDEL = delx.*ones([(Ny-1) (Nx-1) (Nz-1)]); 
yDEL = dely.*ones([(Ny-1) (Nx-1) (Nz-1)]); 
zDEL = delz.*ones([(Ny-1) (Nx-1) (Nz-1)]); 
xyzDEL = xDEL.*yDEL.*zDEL;
sumDEL = sum(xyzDEL,'all') %<=== maybe working 

% summations 
sumXM = sum(abs(x_M),'all');
sumYM = sum(abs(y_M),'all');
sumZM = sum(abs(z_M),'all');
sumXYZM = sumXM+sumYM+sumZM;
sXYZMr  = sumXYZM*delx*dely*delz;
sxYZMv  = sumXYZM*res*(Nx*Ny*Nz);

sumX0 = sum(X,'all');
sumY0 = sum(Y,'all');
sumZ0 = sum(Z,'all');
sumXYZ = sumX0+sumY0+sumZ0;
sXYZr  = sumXYZ*delx*dely*delz;
sxYZv  = sumXYZ*res*(Nx*Ny*Nz);