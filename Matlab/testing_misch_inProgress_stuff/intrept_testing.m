clear all; close all; clc;

I  = -1;
u0 = 4*pi*10^-7; % free space permeability <scalar> [H/m]
W  = 10e-3;
L  = W/2;
r  = W/2;
W  = 10e-3;

resL = 100e3; % resolution of source line
incL = abs((W)/resL);

ntp = linspace(-W/2, W/2, resL)'; % x-coordinates of source line
size(ntp)
ptn = linspace(W/2, -W/2, resL)';
con = linspace(W/2,  W/2, resL)'; % y-coordinates of source line
sz0 = linspace(   0,   0, resL)'; % z-coordinates of source line

%sx = [ntp(1:end-1);    con(1:end-1); ptn(1:end-1); -1*con(1:end-1)];
%sy = [-1*con(1:end-1); ntp(1:end-1); con(1:end-1);    ntp(1:end-1)];

sx = [ntp(1:end-1);    con(1:end-1); ptn(1:end-1); -con];
sy = [-1*con(1:end-1); ntp(1:end-1); con(1:end-1);  ptn];
sz = zeros(numel(sy),1);
l = [sx,sy,sz]';
line = l;
%% 1D arrays
%{
x = 0:pi/4:2*pi; 
v = sin(x);
H=plot(x,v,'.');
% Define the query points to be a finer sampling over the range of x.
xq = 0:pi/16:2*pi;
% Interpolate the function at the query points and plot the result.
figure
vq1 = interp1(x,v,xq,'spline','extrap');
plot(x,v,'o',xq,vq1,':.');
xlim([0 2*pi]);
title('(Default) Linear Interpolation');
%}
%% 3D dim
[X,Y,Z,V] = flow(10);
figure
slice(X,Y,Z,V,[6 9],2,0);
shading flat

[Xq,Yq,Zq] = meshgrid(.1:.25:10,-3:.25:3,-3:.25:3);
Vq = interp3(X,Y,Z,V,Xq,Yq,Zq);
figure
slice(Xq,Yq,Zq,Vq,[6 9],2,0);
shading flat
