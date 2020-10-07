clear all; close all; clc;

wT = 0.2546e-3;  % 30AWG 
O  = 1;
I  = 1;
u0 = 4*pi*10^-7; % free space permeability <scalar> [H/m]
%W  = 10e-3;
W  = 5e-3;
%W = 2.5e-3;
ra = W;
ri = W;
L  = W/2;
r  = W/2;
numSeg = 200;
% make wire antenna
[sx,sy,sz] = singleEllipticalLoop(ra,ri,numSeg,wT,O);
%[sx,sy,sz] = singleRectLoop(ra,ri,numSeg,wT,O);
figure
H = plot3(sx/1e-3,sy/1e-3,sz/1e-3,'.');
grid on; 
xlabel('x [mm]'); ylabel('y [mm]'); zlabel('z');
title('Length 10mm')
view(0,90);
%% calc b fields
l = [sx,sy,sz]';
S = [sx,sy,sz]';
line = l;
[curve, dl] = define_curve(line);
ns = 1e3;
disp('calc bfields');
nn=1;
%NN = 221:1005;
%for ns=221:1005
%NN = 99:106;
%for ns=599:606
Nx = ns;
Ny = Nx;
Nz = 2;
%ALEX
xminb = -2*ri; 
xmaxb =  2*ri;
yminb = -2*ri; 
ymaxb =  2*ri;
% xminb = -1.5*ri; 
% xmaxb =  1.5*ri;
% yminb = -1.5*ri; 
% ymaxb =  1.5*ri;
zminb = 0;
zmaxb = 0;  
Ns = [Nx,Ny,Nz];
bBox  = [xminb,yminb,zminb; xmaxb,ymaxb,zmaxb];
%[X,Y,Z,BX,BY,BZ] = CalcBSLOW(I,S,bBox,Ns);
[X,Y,Z,BX,BY,BZ] = CalcFAST(I,S,bBox,Ns);
%% self indutance 
G = 'c';
%G = 'r';
BZ = squeeze(BZ(:,:,1));
X2 = squeeze(X(:,:,1));
Y2 = squeeze(Y(:,:,1));
%[L11(nn)] = selfInductance_BFields(wT,ri,ra,I,X2,Y2,BZ,N1,G);
N1 = 0;
L11_circ_r5mm(nn) = selfInductance_BFields(wT,ri,ra,I,X2,Y2,BZ,N1,G);
N1 = 1;
L11_wT2_circ_r5mm(nn) = selfInductance_BFields(wT,ri,ra,I,X2,Y2,BZ,N1,G);
N1 = 2;
L11_notEq_circ_r5mm(nn) = selfInductance_BFields(wT,ri,ra,I,X2,Y2,BZ,N1,G);
nn=nn+1;

if(mod(ns,100)==0)
   disp(num2str(ns));
end

%end
disp('DONE');
%%
%figure
%H=plot(NN,L11_wT2./1e-9,'.-');