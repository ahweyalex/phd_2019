% MAIN AS OF
% 12-12-2020
%

clear all; close all; clc;
%%
% inputs 
wT   = 0.2546e-3;  % 30AWG 
wT30 = 0.2546e-3;  % 30AWG 
%wT40 = 0.07874e-3;  % 40AWG
O    = 1; %rect
%O    = 0; %circ/elli
I    = 1;
u0   = 4*pi*10^-7; % free space permeability <scalar> [H/m]
%--------------------%
ra   = 15e-3;   % y-axis
ri   = 10e-3;   % x-axis
L    = ra;      % y-axis
W    = ri;      % x-axis
Nxy  = 4;
N    = 4;
%--------------------%
c    = 1;
h30  = wT30*0.35;
h40  = wT40*0.35;
numSeg = 200; 
zEnd = h30*N*2*pi;
gap = 0;

%[sx30,sy30,sz30] = constrCircWire(h30,ra,ri,numSeg,N,O,wT30,Nxy);G = 'c';
[sx30,sy30,sz30] = constrRectWire(h30,W,L,wT30,numSeg,N,Nxy,O,gap);G = 'r';

figure
H = plot3(sx30/1e-3,sy30/1e-3,sz30/1e-3,'.-');
xlabel('x [mm]'); ylabel('y [mm]'); zlabel('z[mm]');
title('Rect ri10mm ra15mm N:3 Nxy:2');
view(45,45); grid on; 
S30 = [sx30,sy30,sz30]';
%%
% bfields and self indutance 
disp('calc bfields');
nn=1;

tic;
ns= 1005;
% resolution
Nx = ns;
Ny = Nx;
Nz = 2;   

if(ri>ra)
    b = ri;
elseif(ra>ri)
    b = ra;
elseif(ra==ri)
    b = ri;
end

xminb = -1.01*b; 
xmaxb =  1.01*b;
yminb = -1.01*b; 
ymaxb =  1.01*b;  
zminb = (h30*N*2*pi)/2;
zmaxb = (h30*N*2*pi)/2;  
Ns = [Nx,Ny,Nz];
bBox  = [xminb,yminb,zminb; xmaxb,ymaxb,zmaxb];
[X,Y,Z,BX,BY,BZ] = CalcBSLOW(I,S30,bBox,Ns);
%[X,Y,Z,BX,BY,BZ] = CalcFAST(I,S30,bBox,Ns);   


%% 
%--------- self indutance ---------%
BZ = squeeze(BZ(:,:,1));
X2 = squeeze(X(:,:,1));
Y2 = squeeze(Y(:,:,1));   
N1 = 0;
if(G=='r')
    L11_ri10_ra15_30AWG(nn) =... 
                    selfInductance_BFields(wT,ri,ra,I,X2,Y2,BZ,N1,N,G);
elseif(G=='c')
    L11_30AWG(nn) = ...
                selfInductance_BFields(wT,ra,ri,I,X2,Y2,BZ,N1,N,G);
end
N1 = 1;
L11_wT2_ri10_ra15_30AWG(nn) = ... 
                        selfInductance_BFields(wT,ri,ra,I,X2,Y2,BZ,N1,N,G);
N1 = 2;
L11_wT4_ri10_ra15_30AWG(nn) =....
                        selfInductance_BFields(wT,ri,ra,I,X2,Y2,BZ,N1,N,G);
N1 = 4;
L11_wT50_ri10_ra15_30AWG(nn) =....
                        selfInductance_BFields(wT,ri,ra,I,X2,Y2,BZ,N1,N,G);
%%
% --- Mutual Indutance --- %

disp(num2str(nn));
nn=nn+1;
disp('done!');
toc;