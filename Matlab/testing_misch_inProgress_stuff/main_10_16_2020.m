% run through Nx and Ny
% MAIN AS OF
% 11-29-2020
%
clear all; close all; clc;
%%
% inputs 
wT   = 0.2546e-3;  % 30AWG 
wT30 = 0.2546e-3;  % 30AWG 
wT40 = 0.07874e-3;  % 40AWG
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
%numSeg = 204; % rect (true res is about 4*numSeg)
numSeg = 200; % ellipse/circ %low end (initial)
%numSeg = 1e3; % ellipse/circ 
zEnd = h30*N*2*pi;
gap = 0;
%
% wire 
%[sx,sy,sz] = singleRectLoop(ra,ri,numSeg,wT,O); G = 'r';
%[sx,sy,sz] = singleRectLoop_roundEdge(W,L,numSeg,wT,O,c); 
%[sx,sy,sz] = singleEllipticalLoop(ra,ri,numSeg,wT,O); G = 'c';

%[sx30,sy30,sz30] = constrCircWire(h30,ra,ri,numSeg,N,O,wT30,Nxy); G = 'c';
[sx30,sy30,sz30] = constrRectWire(h30,W,L,wT30,numSeg,N,Nxy,O,gap); G = 'r';
%
figure
H = plot3(sx30/1e-3,sy30/1e-3,sz30/1e-3,'.-');
grid on; 
xlabel('x [mm]'); ylabel('y [mm]'); zlabel('z[mm]');
%title('s:10mm N:1 Nxy:1');
title('Rect ri10mm ra15mm N:3 Nxy:2');
%title('d:5mm')
view(45,45);
%xlim([-1.1*ri/1e-3,1.1*ri/1e-3]); ylim([-1.1*ri/1e-3,1.1*ri/1e-3]);
%xlim([-6 6]); 
%ylim([-8 8]);
%}
S30 = [sx30,sy30,sz30]';
%view(150,40);
%S40 = [sx30,sy30,sz30]';
%%
% bfields and self indutance 
disp('calc bfields');
nn=1;

tic;
%NN = 20:220;
%for ns= 20:220

% upper parametric   
% NN = 980:1005;
% for ns= 980:1005

% single (upper)
NN = 1005:1005;
for ns= 1005:1005

%NN = 200:799;
%for ns = 200:799
    % resolution
    Nx = ns;
    Ny = Nx;
    Nz = 2;   
    % bounds
%     xminb = -1.01*(ri+wT*Nxy); 
%     xmaxb =  1.01*(ri+wT*Nxy);
%     yminb = -1.01*(ra+wT*Nxy); 
%     ymaxb =  1.01*(ra+wT*Nxy);    
%    
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
    
%--------- self indutance ---------%
    %%
    BZ = squeeze(BZ(:,:,1));
    X2 = squeeze(X(:,:,1));
    Y2 = squeeze(Y(:,:,1));   
    N1 = 0;
    L11_ri10_ra15_30AWG(nn) = selfInductance_BFields(wT,ri,ra,I,X2,Y2,BZ,N1,N,G)
    %
    N1 = 1;
    L11_wT2_ri10_ra15_30AWG(nn) = selfInductance_BFields(wT,ri,ra,I,X2,Y2,BZ,N1,N,G)
    
    N1 = 2;
    L11_wT4_ri10_ra15_30AWG(nn) = selfInductance_BFields(wT,ri,ra,I,X2,Y2,BZ,N1,N,G);
    
    N1 = 3;
    L11_wT100_ri10_ra15_30AWG(nn) = selfInductance_BFields(wT,ri,ra,I,X2,Y2,BZ,N1,N,G);

    N1 = 4;
    L11_wT50_ri10_ra15_30AWG(nn) = selfInductance_BFields(wT,ri,ra,I,X2,Y2,BZ,N1,N,G);
    
    N1 = 5;
    L11_wT75_ri10_ra15_30AWG(nn) = selfInductance_BFields(wT,ri,ra,I,X2,Y2,BZ,N1,N,G);
    
    N1 = 0;
    ri1 = ri+wT*1;
    ra1 = ra+wT*1;
    L11_1wT_ri10_ra15_30AWG(nn) = selfInductance_BFields(wT,ri,ra,I,X2,Y2,BZ,N1,N,G);
    
    N1 = 0;
    ri2 = ri+wT*2;
    ra2 = ra+wT*2;
    L11_2wT_ri10_ra15_30AWG(nn) = selfInductance_BFields(wT,ri,ra,I,X2,Y2,BZ,N1,N,G);
    
    N1 = 0;
    ri2 = ri+wT*3;
    ra2 = ra+wT*3;
    L11_3wT_ri10_ra15_30AWG(nn) = selfInductance_BFields(wT,ri,ra,I,X2,Y2,BZ,N1,N,G);
    
    %%
    N1=0;
    L11_30AWG(nn) = selfInductance_BFields(wT,ra,ri,I,X2,Y2,BZ,N1,N,G)

%%
%{
% new self ind
N1 = 0;
L11_rec_ri10_ra15_30AWG_Nxy2_N1(nn) = selfInductance_BFields_2(wT,ri,ra,I,X2,Y2,BZ,N1,N,G);
%L11_squ_s10mm_30AWG_Nxy2_N3(nn) = selfInductance_BFields(wT,ri,ra,I,X2,Y2,BZ,N1,N,G);
%L11_circ_r5mm_30AWG_Nxy1_N3(nn) = selfInductance_BFields(wT,ri,ra,I,X2,Y2,BZ,N1,N,G);
%L11_circ_r5mm_40AWG(nn) = selfInductance_BFields(wT40,ri,ra,I,X2,Y2,BZ,N1,N,G);
%}
%%
    disp(num2str(nn));
    nn=nn+1;
end
disp('done!');
toc;