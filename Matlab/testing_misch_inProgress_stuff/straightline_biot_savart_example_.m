%% (A)
clear all; close all; clc;
I  = 1;
u0 = 4*pi*10^-7; % free space permeability <scalar> [H/m]
W  = 10e-3;
L  = W/2;
r  = W/2;
B = (u0*I*L)/(2*pi*r*sqrt(L^2 + r^2));

%% (B)
clear all; close all; clc;
I  = 1;
u0 = 4*pi*10^-7; % free space permeability <scalar> [H/m]
W  = 10e-3;
L  = W/2;
r  = W/2;
W  = 10e-3;
% define: source line 
resL = 4; % resolution of source line
x = linspace(-W/2, W/2, resL)'; % x-coordinates of source line
y = linspace(W/2,  W/2, resL)'; % y-coordinates of source line
z = linspace(   0,   0, resL)'; % z-coordinates of source line
l = [x,y,z]';
% point of interest (solve B-Field at this location)
px = 0;
py = W/2;
pz = 0;
r = [px;py;pz];
% define dl
dl = [];
dl_k = my_diff(l);
dl   = cat(2,dl,dl_k);
% define R 
R  = r - l;
%%
% define dB
dB = my_cross(dl,R); 


