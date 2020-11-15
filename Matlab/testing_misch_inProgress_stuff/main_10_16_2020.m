% run through Nx and Ny
% MAIN AS OF
% 11-02-2020
%
clear all; close all; clc;
% inputs 
wT   = 0.2546e-3;   % 30AWG 
wT30 = 0.2546e-3;   % 30AWG 
wT40 = 0.07874e-3;  % 40AWG
O    = 1;
I    = 1;
u0   = 4*pi*10^-7; % free space permeability <scalar> [H/m]

%--------------------%
ra   = 15e-3;   % y-axis
ri   = 10e-3;   % x-axis
L    = ra;      % y-axis
W    = ri;      % x-axis
Nxy  = 2;
N    = 2;
%--------------------%
c    = 1;
h30  = wT30*0.35;
h40  = wT40*0.35;
zEnd = h30*N*2*pi;
numSeg = 204; % rect (true res is about 4*numSeg)
gap = 0;
%
% wire 
%[sx,sy,sz] = singleRectLoop(ra,ri,numSeg,wT,O); G = 'r';
%[sx,sy,sz] = singleRectLoop_roundEdge(W,L,numSeg,wT,O,c); 
%[sx,sy,sz] = singleEllipticalLoop(ra,ri,numSeg,wT,O); G = 'c';

%[sx30,sy30,sz30] = constrCircWire(h30,ra,ri,numSeg,N,O,wT,Nxy); G = 'c';
[sx30,sy30,sz30] = constrRectWire(h30,W,L,wT,numSeg,N,Nxy,O,gap); G = 'r';
%
figure
H = plot3(sx30/1e-3,sy30/1e-3,sz30/1e-3,'.');
grid on; 
xlabel('x [mm]'); ylabel('y [mm]'); zlabel('z[mm]');
title('d:10mm N:2 Nxy:1')
%title('d:5mm')
view(45,45);
%xlim([ (-1.01*(ri+wT*Nxy))/1e-3, (1.01*(ri+wT*Nxy))/1e-3] );
%ylim([ (-1.01*(ra+wT*Nxy))/1e-3, (1.01*(ra+wT*Nxy))/1e-3] );
%ylim([ (-1.01*(ri+wT*Nxy))/1e-3, (1.01*(ri+wT*Nxy))/1e-3] );
%}
S30 = [sx30,sy30,sz30]';
%view(150,40);
view(90,90);
%S40 = [sx30,sy30,sz30]';
%%
% bfields and self indutance 
disp('calc bfields');
nn=1;

tic;
%NN = 20:220;
%for ns= 20:220
 
%NN = 980:1005;
%for ns= 980:1005

NN = 1005:1005;
for ns= 1005:1005
    % resolution
    Nx = ns;
    Ny = Nx;
    Nz = 2;   
    Nxy2 = Nxy+1;
    % bounds
    xminb = -1.01*(ri+wT*Nxy2); 
    xmaxb =  1.01*(ri+wT*Nxy2);
    yminb = -1.01*(ra+wT*Nxy2); 
    ymaxb =  1.01*(ra+wT*Nxy2);   
    %zminb = (zEnd/2)*(0.99);
    %zmaxb = (zEnd/2)*(1.01);  
    zminb = (zEnd)*(0.25);
    zmaxb = (zEnd)*(0.75);  
    Ns = [Nx,Ny,Nz];
    bBox  = [xminb,yminb,zminb; xmaxb,ymaxb,zmaxb];
    %[X,Y,Z,BX,BY,BZ] = CalcBSLOW(I,S,bBox,Ns);
    [X,Y,Z,BX,BY,BZ] = CalcFAST(I,S30,bBox,Ns);   
    
    % self indutance 
    %BZ = squeeze(BZ(:,:,1));
    X2 = squeeze(X(:,:,1));
    Y2 = squeeze(Y(:,:,1));   
end
%%
% old self ind
%{
    N1 = 0;
    L11_rec_ri10_ra15_30AWG_Nxy2_N1(nn) = selfInductance_BFields(wT,ri,ra,I,X2,Y2,BZ,N1,N,G);
    %L11_squ_s10mm_30AWG_Nxy2_N3(nn) = selfInductance_BFields(wT,ri,ra,I,X2,Y2,BZ,N1,N,G);
    %L11_circ_r5mm_30AWG_Nxy1_N3(nn) = selfInductance_BFields(wT,ri,ra,I,X2,Y2,BZ,N1,N,G);
    %L11_circ_r5mm_40AWG(nn) = selfInductance_BFields(wT40,ri,ra,I,X2,Y2,BZ,N1,N,G);
    
    N1 = 1;
    L11_wT2_rec_ri10_ra15_30AWG_Nxy2_N1(nn) = selfInductance_BFields(wT,ri,ra,I,X2,Y2,BZ,N1,N,G);
    %L11_wT2_squ_s10mm_30AWG_Nxy2_N3(nn) = selfInductance_BFields(wT,ri,ra,I,X2,Y2,BZ,N1,N,G);
    %L11_wT2_circ_r5mm_30AWG_Nxy1_N3(nn) = selfInductance_BFields(wT,ri,ra,I,X2,Y2,BZ,N1,N,G);
    %L11_wT2_circ_r5mm_40AWG(nn) = selfInductance_BFields(wT40,ri,ra,I,X2,Y2,BZ,N1,N,G);
    
    N1 = 2;
    L11_wT4_rec_ri10_ra15_30AWG_Nxy2_N1(nn) = selfInductance_BFields(wT,ri,ra,I,X2,Y2,BZ,N1,N,G);
    %L11_wT4_squ_r5mm_30AWG_Nxy1_N1(nn) = selfInductance_BFields(wT,ri,ra,I,X2,Y2,BZ,N1,N,G);
    %L11_wT4_circ_r5mm_30AWG_Nxy1_N3(nn) = selfInductance_BFields(wT,ri,ra,I,X2,Y2,BZ,N1,N,G);
    %L11_wT4_circ_r5mm_40AWG(nn) = selfInductance_BFields(wT40,ri,ra,I,X2,Y2,BZ,N1,N,G);
    
    N1 = 3;
    L11_wT100_rec_ri10_ra15_30AWG_Nxy2_N1(nn) = selfInductance_BFields(wT,ri,ra,I,X2,Y2,BZ,N1,N,G);  
    %L11_wT100_squ_s10mm_30AWG_Nxy2_N3(nn) = selfInductance_BFields(wT,ri,ra,I,X2,Y2,BZ,N1,N,G);  
    %L11_wT100_circ_r5mm_30AWG_Nxy1_N3(nn) = selfInductance_BFields(wT,ri,ra,I,X2,Y2,BZ,N1,N,G);   
    %L11_wT100_circ_r5mm_40AWG(nn) = selfInductance_BFields(wT40,ri,ra,I,X2,Y2,BZ,N1,N,G);   
    
    N1 = 4;
    L11_wT50_rec_ri10_ra15_30AWG_Nxy2_N1(nn) = selfInductance_BFields(wT,ri,ra,I,X2,Y2,BZ,N1,N,G); 
    %L11_wT50_squ_s10mm_30AWG_Nxy2_N3(nn) = selfInductance_BFields(wT,ri,ra,I,X2,Y2,BZ,N1,N,G); 
    %L11_wT50_circ_r5mm_30AWG_Nxy1_N3(nn) = selfInductance_BFields(wT,ri,ra,I,X2,Y2,BZ,N1,N,G);    
    %L11_wT50_circ_r5mm_40AWG(nn) = selfInductance_BFields(wT40,ri,ra,I,X2,Y2,BZ,N1,N,G);    
    
    N1 = 5;
    L11_wT75_rec_ri10_ra15_30AWG_Nxy2_N1(nn) = selfInductance_BFields(wT,ri,ra,I,X2,Y2,BZ,N1,N,G); 
    %L11_wT75_squ_s10mm_30AWG_Nxy2_N3(nn) = selfInductance_BFields(wT,ri,ra,I,X2,Y2,BZ,N1,N,G); 
    %L11_wT75_circ_r5mm_30AWG_Nxy1_N3(nn) = selfInductance_BFields(wT,ri,ra,I,X2,Y2,BZ,N1,N,G); 
    %L11_wT75_circ_r5mm_40AWG(nn) = selfInductance_BFields(wT40,ri,ra,I,X2,Y2,BZ,N1,N,G); 

    N1 = 0;
    ri1 = ri+wT*1;
    ra1 = ra+wT*1;
    L11_1wT_rec_ri10_ra15_30AWG_Nxy2_N1(nn) = selfInductance_BFields(wT,ri1,ra1,I,X2,Y2,BZ,N1,N,G);
    %L11_circ_r5mm_30AWG_Nxy1_N3(nn) = selfInductance_BFields(wT,ri,ra,I,X2,Y2,BZ,N1,N,G);
    %L11_circ_r5mm_40AWG(nn) = selfInductance_BFields(wT40,ri,ra,I,X2,Y2,BZ,N1,N,G);    

    N1 = 0;
    ri2 = ri+wT*2;
    ra2 = ra+wT*2;
    L11_2wT_rec_ri10_ra15_30AWG_Nxy2_N1(nn) = selfInductance_BFields(wT,ri2,ra2,I,X2,Y2,BZ,N1,N,G);
    %L11_circ_r5mm_30AWG_Nxy1_N3(nn) = selfInductance_BFields(wT,ri,ra,I,X2,Y2,BZ,N1,N,G);
    %L11_circ_r5mm_40AWG(nn) = selfInductance_BFields(wT40,ri,ra,I,X2,Y2,BZ,N1,N,G);      

    N1 = 0;
    ri2 = ri+wT*3;
    ra2 = ra+wT*3;
    L11_3wT_rec_ri10_ra15_30AWG_Nxy2_N1(nn) = selfInductance_BFields(wT,ri2,ra2,I,X2,Y2,BZ,N1,N,G);
    %L11_circ_r5mm_30AWG_Nxy1_N3(nn) = selfInductance_BFields(wT,ri,ra,I,X2,Y2,BZ,N1,N,G);
    %L11_circ_r5mm_40AWG(nn) = selfInductance_BFields(wT40,ri,ra,I,X2,Y2,BZ,N1,N,G);   


    disp(num2str(nn));
    nn=nn+1;
end
disp('done!');
toc;
%}

%%
% new self ind
N1 = 0;
L11_rec_ri10_ra15_30AWG_Nxy2_N1(nn) = selfInductance_BFields_2(wT,ri,ra,I,X2,Y2,BZ,N1,N,G);
%L11_squ_s10mm_30AWG_Nxy2_N3(nn) = selfInductance_BFields(wT,ri,ra,I,X2,Y2,BZ,N1,N,G);
%L11_circ_r5mm_30AWG_Nxy1_N3(nn) = selfInductance_BFields(wT,ri,ra,I,X2,Y2,BZ,N1,N,G);
%L11_circ_r5mm_40AWG(nn) = selfInductance_BFields(wT40,ri,ra,I,X2,Y2,BZ,N1,N,G);
    