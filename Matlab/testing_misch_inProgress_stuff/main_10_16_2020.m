% run through Nx and Ny
% MAIN AS OF
% 11-02-2020
%
clear all; close all; clc;
% inputs 
wT   = 0.2546e-3;  % 30AWG 
wT30 = 0.2546e-3;  % 30AWG 
wT40 = 0.07874e-3;  % 40AWG
O    = 1;
I    = 1;
u0   = 4*pi*10^-7; % free space permeability <scalar> [H/m]
%--------------------%
ra   = (15e-3)/2;
ri   = (10e-3)/2;
W    = ri;
L    = ra;
Nxy  = 1;
N    = 1;
%--------------------%
c    = 1;
h30  = wT30*0.35;
h40  = wT40*0.35;
numSeg = 97; % rect (true res is about 4*numSeg)
gap = 0;
%
% wire 
%[sx,sy,sz] = singleRectLoop(ra,ri,numSeg,wT,O); G = 'r';
%[sx,sy,sz] = singleRectLoop_roundEdge(W,L,numSeg,wT,O,c); 
%[sx,sy,sz] = singleEllipticalLoop(ra,ri,numSeg,wT,O); G = 'c';
%[sx30,sy30,sz30] = constrCircWire(h30,ra,ri,numSeg,N,O,wT,Nxy); G = 'c';
%[sx40,sy40,sz40] = constrCircWire(h40,ra,ri,numSeg,N,O,wT40,Nxy); G = 'c';
[sx30,sy30,sz30] = constrRectWire(h30,W,L,wT,numSeg,N,Nxy,O,gap); G = 'r';
%
figure
H = plot3(sx30/1e-3,sy30/1e-3,sz30/1e-3,'.');
grid on; 
xlabel('x [mm]'); ylabel('y [mm]'); zlabel('z[mm]');
title('d:10mm N:2 Nxy:2')
%title('d:5mm')
view(45,45);
xlim([-1.1*ri/1e-3,1.1*ri/1e-3]); ylim([-1.1*ri/1e-3,1.1*ri/1e-3]);
%}
S30 = [sx30,sy30,sz30]';
view(150,40);
%S40 = [sx30,sy30,sz30]';
%%
% bfields and self indutance 
disp('calc bfields');
nn=1;

tic;
%NN = 20:220;
%for ns= 20:220
 
NN = 980:1005;
for ns= 980:1005
   % resolution
    Nx = ns;
    Ny = Nx;
    Nz = 2;   
    % bounds
    xminb = -1.01*(ri+wT*Nxy); 
    xmaxb =  1.01*(ri+wT*Nxy);
    yminb = -1.01*(ri+wT*Nxy); 
    ymaxb =  1.01*(ri+wT*Nxy);   
    zminb = (h30*N*2*pi)/2;
    zmaxb = (h30*N*2*pi)/2;  
    Ns = [Nx,Ny,Nz];
    bBox  = [xminb,yminb,zminb; xmaxb,ymaxb,zmaxb];
    %[X,Y,Z,BX,BY,BZ] = CalcBSLOW(I,S,bBox,Ns);
    [X,Y,Z,BX,BY,BZ] = CalcFAST(I,S30,bBox,Ns);   
    
    % self indutance 
    BZ = squeeze(BZ(:,:,1));
    X2 = squeeze(X(:,:,1));
    Y2 = squeeze(Y(:,:,1));   
%------------------------------ CIRCLE    
    N1 = 0;
    L11_rec_ri10_ra15_30AWG_Nxy1_N1(nn) = selfInductance_BFields(wT,ri,ra,I,X2,Y2,BZ,N1,N,G);
    %L11_squ_r5mm_30AWG_Nxy1_N1(nn) = selfInductance_BFields(wT,ri,ra,I,X2,Y2,BZ,N1,N,G);
    %L11_circ_r5mm_30AWG_Nxy1_N3(nn) = selfInductance_BFields(wT,ri,ra,I,X2,Y2,BZ,N1,N,G);
    %L11_circ_r5mm_40AWG(nn) = selfInductance_BFields(wT40,ri,ra,I,X2,Y2,BZ,N1,N,G);
    
    N1 = 1;
    L11_wT2_rec_ri10_ra15_30AWG_Nxy1_N1(nn) = selfInductance_BFields(wT,ri,ra,I,X2,Y2,BZ,N1,N,G);
    %L11_wT2_squ_r5mm_30AWG_Nxy1_N1(nn) = selfInductance_BFields(wT,ri,ra,I,X2,Y2,BZ,N1,N,G);
    %L11_wT2_circ_r5mm_30AWG_Nxy1_N3(nn) = selfInductance_BFields(wT,ri,ra,I,X2,Y2,BZ,N1,N,G);
    %L11_wT2_circ_r5mm_40AWG(nn) = selfInductance_BFields(wT40,ri,ra,I,X2,Y2,BZ,N1,N,G);
    
    N1 = 2;
    L11_wT4_rec_ri10_ra15_30AWG_Nxy1_N1(nn) = selfInductance_BFields(wT,ri,ra,I,X2,Y2,BZ,N1,N,G);
    %L11_wT4_squ_r5mm_30AWG_Nxy1_N1(nn) = selfInductance_BFields(wT,ri,ra,I,X2,Y2,BZ,N1,N,G);
    %L11_wT4_circ_r5mm_30AWG_Nxy1_N3(nn) = selfInductance_BFields(wT,ri,ra,I,X2,Y2,BZ,N1,N,G);
    %L11_wT4_circ_r5mm_40AWG(nn) = selfInductance_BFields(wT40,ri,ra,I,X2,Y2,BZ,N1,N,G);
    
    N1 = 3;
    L11_wT100_rec_ri10_ra15_Nxy1_N1(nn) = selfInductance_BFields(wT,ri,ra,I,X2,Y2,BZ,N1,N,G);  
    %L11_wT100_squ_r5mm_30AWG_Nxy1_N1(nn) = selfInductance_BFields(wT,ri,ra,I,X2,Y2,BZ,N1,N,G);  
    %L11_wT100_circ_r5mm_30AWG_Nxy1_N3(nn) = selfInductance_BFields(wT,ri,ra,I,X2,Y2,BZ,N1,N,G);   
    %L11_wT100_circ_r5mm_40AWG(nn) = selfInductance_BFields(wT40,ri,ra,I,X2,Y2,BZ,N1,N,G);   
    
    N1 = 4;
    L11_wT50_rec_ri10_ra15_30AWG_Nxy1_N1(nn) = selfInductance_BFields(wT,ri,ra,I,X2,Y2,BZ,N1,N,G); 
    %L11_wT50_squ_r5mm_30AWG_Nxy1_N1(nn) = selfInductance_BFields(wT,ri,ra,I,X2,Y2,BZ,N1,N,G); 
    %L11_wT50_circ_r5mm_30AWG_Nxy1_N3(nn) = selfInductance_BFields(wT,ri,ra,I,X2,Y2,BZ,N1,N,G);    
    %L11_wT50_circ_r5mm_40AWG(nn) = selfInductance_BFields(wT40,ri,ra,I,X2,Y2,BZ,N1,N,G);    
    
    N1 = 5;
    L11_wT75_rec_ri10_ra15_30AWG_Nxy1_N1(nn) = selfInductance_BFields(wT,ri,ra,I,X2,Y2,BZ,N1,N,G); 
    %L11_wT75_squ_r5mm_30AWG_Nxy1_N1(nn) = selfInductance_BFields(wT,ri,ra,I,X2,Y2,BZ,N1,N,G); 
    %L11_wT75_circ_r5mm_30AWG_Nxy1_N3(nn) = selfInductance_BFields(wT,ri,ra,I,X2,Y2,BZ,N1,N,G); 
    %L11_wT75_circ_r5mm_40AWG(nn) = selfInductance_BFields(wT40,ri,ra,I,X2,Y2,BZ,N1,N,G); 

%{
% %   RECT
%     N1 = 0;
%     L11_sq_L5mm(nn) = selfInductance_BFields(wT,ri,ra,I,X2,Y2,BZ,N1,N,G);
%     N1 = 1;
%     L11_wT2_sq_L5mm(nn) = selfInductance_BFields(wT,ri,ra,I,X2,Y2,BZ,N1,N,G);
%     N1 = 2;
%     L11_wT4_sq_L5mm(nn) = selfInductance_BFields(wT,ri,ra,I,X2,Y2,BZ,N1,N,G);
%     %
%     N1 = 3;
%     L11_wT100_sq_L5mm(nn) = selfInductance_BFields(wT,ri,ra,I,X2,Y2,BZ,N1,N,G);    
%     N1 = 4;
%     L11_wT50_sq_L5mm(nn) = selfInductance_BFields(wT,ri,ra,I,X2,Y2,BZ,N1,N,G);    
%     N1 = 5;
%     L11_wT75_sq_L5mm(nn) = selfInductance_BFields(wT,ri,ra,I,X2,Y2,BZ,N1,N,G);  
%     %
%}

%     if(mod(ns,100)==0)
%        disp(num2str(ns));
%     end
    disp(num2str(nn));
    nn=nn+1;
end
disp('done!');
toc;