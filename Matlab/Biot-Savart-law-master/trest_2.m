clear all; close all; clc;
I  = 1;
u0 = 4*pi*10^-7; % free space permeability <scalar> [H/m]
%W  = 10e-3;
%W  = 5e-3;
W = 2.5e-3;
ra = W;
ri = W;
L  = W/2;
r  = W/2;

%numSeg = 250e3;
numSeg = 200;
%numSeg = 1e3;
%numSeg = 100e3;
wT = 0.2546e-3;  % 30AWG 
O  = 0;
% This functions calculates points on a coil curve
%line = define_coil([0, 0, -4]', 0.5, 5, 7, 4);
% define: source line 
%{
resL = 1e4; % resolution of source line
sx = linspace( W/2,-W/2, resL)'; % x-coordinates of source line
sy = linspace( W/2, W/2, resL)'; % y-coordinates of source line
sz = linspace(   0,   0, resL)'; % z-coordinates of source line
l = [sx,sy,sz]';
line = l;
%}
%{
resL = 100e3; % resolution of source line %kinda works?
incL = abs((W)/resL);
ntp = linspace(-W/2, W/2, resL)'; % x-coordinates of source line
%size(ntp)
ptn = linspace(W/2, -W/2, resL)';
con = linspace(W/2,  W/2, resL)'; % y-coordinates of source line
sz0 = linspace(   0,   0, resL)'; % z-coordinates of source line
%sx = [ntp(1:end-1);    con(1:end-1); ptn(1:end-1); -1*con(1:end-1)];
%sy = [-1*con(1:end-1); ntp(1:end-1); con(1:end-1);    ntp(1:end-1)];
sx = [ntp(1:end-1);    con(1:end-1); ptn(1:end-1); -con];
sy = [-1*con(1:end-1); ntp(1:end-1); con(1:end-1);  ptn];
sz = zeros(numel(sy),1);
%}
%[sx,sy,sz] = singleEllipticalLoop(ra,ri,numSeg,wT,O);
[sx,sy,sz] = singleRectLoop(ra,ri,numSeg,wT,O);
figure
H = plot3(sx/1e-3,sy/1e-3,sz/1e-3,'.');
grid on; 
xlabel('x [mm]'); ylabel('y [mm]'); zlabel('z');
title('Length 10mm')
view(0,90);
%%
l = [sx,sy,sz]';
S = [sx,sy,sz]';
line = l;
% This function calculates dl vectors
[curve, dl] = define_curve(line);

nn = 1;

%NN = 100:105;
%L11 = zeros(numel(NN),1);
%NS = 410;
%NI = 10;
%NN = NI:NS;

ns = 1e3;
tic;
%for ns=NI:NS
    % X, Y, and Z MESH (this specefies the drawing box
    % x_inst is number of points from x_start to x_stop to calculate mag field.
    % Ns = 101;
    Nx = ns;
    Ny = Nx;
    Nz = 2;
    %{
    %x_start =   W;
    %x_stop  =  -W;
    x_start = 0;
    x_stop  = 0;
    x_inst  =  Nx;
    %y_start =   W;
    %y_stop  =  -W;
    y_start = 0;
    y_stop  = 0;
    y_inst  =  Ny;
    z_start =  0;
    z_stop  =  0;
    z_inst  =  Nz;
    % PARAMETRIZATION VARIABLE
    x = linspace(x_start, x_stop, x_inst);
    y = linspace(y_start, y_stop, y_inst);
    z = linspace(z_start, z_stop, z_inst);
    [X,Y,Z] = meshgrid(x,y,z);
    % This function calculates magnetic field with Bivot-Savart Law.
    %[B_abs, B_x, B_y, B_z] = b_calc(x, y, z, curve, dl);
    %}
    %%
    % ALEX:
    xminb = -2*ri; 
    xmaxb =  2*ri;
    yminb = -2*ri; 
    ymaxb =  2*ri;
    zminb = 0;
    zmaxb = 0;  
    Ns = [Nx,Ny,Nz];
    bBox  = [xminb,yminb,zminb; xmaxb,ymaxb,zmaxb];
    [X,Y,Z,BX,BY,BZ] = CalcBSLOW(I,S,bBox,Ns);
    %[X,Y,Z,BX,BY,BZ] = CalcFAST(I,S,bBox,Ns);
    %toc;
    %B_z(:,:,nn) = B_z;
    %
    G = 'r';
    N = 1;
    %ra = W; ri = W;
    ri = W/2;
    ra = W/2;
    N = 1;
    G = 'r';
    BZ = squeeze(BZ(:,:,1));
    X2 = squeeze(X(:,:,1));
    Y2 = squeeze(Y(:,:,1));
    [L11(nn)] = selfInductance_BFields(ri,ra,I,X2,Y2,BZ,N,G);
    
%     nn=nn+1;
%     if(mod(10,ns)==0)
%         disp(strcat(num2str(ns),'/',num2str(NS)));
%     elseif(ns==NS)
%         disp(strcat(num2str(ns),'/',num2str(NS)));
%     end
    nn
%end
toc;
disp('DONE!');

%
%{
x_inst = 500; y_inst = x_inst; 
xq = linspace(x_start, x_stop, x_inst);
yq = linspace(y_start, y_stop, y_inst);
%zq = linspace(z_start, z_stop, z_inst);
%[Xq,Yq,Zq] = meshgrid(xq,yq,zq);
[Xq,Yq] = meshgrid(xq,yq);

Bzq = interp2(X,Y,B_z,Xq,Yq,'cubic');
%Bzq = interp3(X,Y,Z,B_z,Xq,Yq,Zq,'cubic');
%
N = 1;
L11q = [];
[L11q,r,c] = selfInductance_BFields(ri,ra,I,Xq,Yq,Bzq,N,G);
L11q 
%}
% This is the same function as above but uses paralel for loop for speedup.
% [B_abs, B_x, B_y, B_z] = b_calc_par(x, y, z, curve, dl);
