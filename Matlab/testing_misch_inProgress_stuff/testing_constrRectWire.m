clear all; close all; clc;
% inputs 
wT   = 0.2546e-3;  % 30AWG 
wT30 = 0.2546e-3;  % 30AWG 
wT40 = 0.07874e-3;  % 40AWG
I    = 1;
u0   = 4*pi*10^-7; % free space permeability <scalar> [H/m]
W    = 5e-3;
L    = 5e-3;
ra   = W;
ri   = W;
c    = 1;
h30  = wT30*0.35;
h40  = wT40*0.35;

O    = 0;
Nxy  = 1;
N    = 1;
numSeg = 50;
% wire 

gap  = 0;
zEnd = h30*N*2*pi;
%
[sx,sy,sz] = constrRectWire_(h30,W,L,wT,numSeg,N,Nxy,O,gap);
H = plot3(sx,sy,sz,'.-');
xlabel('x'); ylabel('y'); zlabel('z'); grid on;

%%
armSize = floor((numSeg/4)/N); % number of points along each arm
sx=[]; sy=[]; % initialize final x and y 1-D arrays
%-------------------------- front arm ------------------------------------%
    xf = linspace( W/2,  W/2, armSize)';
    yf = linspace( -L/2, L/2, armSize)';
%---------------------- front left arm -----------------------------------%
    xfl = linspace(W/2, W/2, armSize)';
    yfl = linspace(gap, L/2, armSize)';
%-------------------------- left arm -------------------------------------%
    xl = linspace( W/2, -W/2, armSize)';
    yl = linspace( L/2,  L/2, armSize)';
%-------------------------- back arm -------------------------------------%
    xb = linspace(-W/2, -W/2, armSize)';
    yb = linspace( L/2, -L/2, armSize)';
%-------------------------- right arm ------------------------------------%
    xr = linspace(-W/2,  W/2, armSize)';
    yr = linspace(-L/2, -L/2, armSize)';
%-------------------- front right arm ------------------------------------%
    xfr = linspace( W/2, W/2, armSize)';
    yfr = linspace(-L/2, gap, armSize)';
%---------------construct multi-turn rectangle coil-----------------------%
    for n=1:N
        % first iteration
        if(n==1)
            sx = [sx;xfl;xl;xb;xr];
            sy = [sy;yfl;yl;yb;yr;];
        % last iteration
        elseif(n==N)
            sx = [sx;xf;xl;xb;xr;xfr];
            sy = [sy;yf;yl;yb;yr;yfr];
        % in between 
        else
            sx = [sx;xf;xl;xb;xr];
            sy = [sy;yf;yl;yb;yr;];
        end
    end
    
sz = linspace(0,zEnd, numel(sx)); 
H=plot3(sx,sy,sz,'.-');
grid on; 
xlabel('x'); ylabel('y');

%%
zs = linspace(0,zEnd, numel(xs));
%H=plot3(sx,sy,sz,'o');
H=plot3(xs,ys,zs,'o');
grid on;
xlabel('x'); ylabel('y'); zlabel('z');
view(45,45);
xlim([-3e-3 3e-3]); ylim([-3e-3 3e-3]);