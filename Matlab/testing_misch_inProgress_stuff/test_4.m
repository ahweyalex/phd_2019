clear all; close all; clc;
%%
wT = 0.2546e-3;  % 30AWG 
%wT = 0.07874e-3;  % 40AWG
O  = 1;
I  = 1;
u0 = 4*pi*10^-7; % free space permeability <scalar> [H/m]
%W = 10e-3;
W  = 5e-3;
%W  = 2.5e-3;
ra = W;
ri = W;
L  = W/2;
r  = W/2;
numSeg = 200;
% make wire antenna
%[sx,sy,sz] = singleEllipticalLoop(ra,ri,numSeg,wT,O);
%[sx,sy,sz] = singleRectLoop(ra,ri,numSeg,wT,O);
[Sx,Sy,Sz] = singleRectLoop_roundEdge(W0,L0,numSeg,wT,O,c);
figure
H = plot3(sx/1e-3,sy/1e-3,sz/1e-3,'.');
grid on; 
xlabel('x [mm]'); ylabel('y [mm]'); zlabel('z');
%title('d:10mm')
title('d:5mm')
view(0,90);
% calc b fields
l = [sx,sy,sz]';
S = [sx,sy,sz]';
line = l;
[curve, dl] = define_curve(line);
%ns = 1e3;
disp('calc bfields');
nn=1;
%%
%G = 'c';
G = 'r';
%NN = 19:220;
%for ns= 19:220
NN = 19:1005;
for ns= 19:1005
    Nx = ns;
    Ny = Nx;
    Nz = 2;
    %ALEX
%     xminb = -2*ri; 
%     xmaxb =  2*ri;
%     yminb = -2*ri; 
%     ymaxb =  2*ri;    
    xminb = -1.01*ri; 
    xmaxb =  1.01*ri;
    yminb = -1.01*ri; 
    ymaxb =  1.01*ri;    
    zminb = 0;
    zmaxb = 0;  
    Ns = [Nx,Ny,Nz];
    bBox  = [xminb,yminb,zminb; xmaxb,ymaxb,zmaxb];
    %[X,Y,Z,BX,BY,BZ] = CalcBSLOW(I,S,bBox,Ns);
    [X,Y,Z,BX,BY,BZ] = CalcFAST(I,S,bBox,Ns);   
    
    % self indutance 
    BZ = squeeze(BZ(:,:,1));
    X2 = squeeze(X(:,:,1));
    Y2 = squeeze(Y(:,:,1));   
    
%     N1 = 0;
%     L11_circ_r5mm(nn) = selfInductance_BFields(wT,ri,ra,I,X2,Y2,BZ,N1,G);
%     N1 = 1;
%     L11_wT2_circ_r5mm(nn) = selfInductance_BFields(wT,ri,ra,I,X2,Y2,BZ,N1,G);
%     N1 = 2;
%     L11_wT4_circ_r5mm(nn) = selfInductance_BFields(wT,ri,ra,I,X2,Y2,BZ,N1,G);
%     %
%     N1 = 3;
%     L11_wT100_circ_r5mm(nn) = selfInductance_BFields(wT,ri,ra,I,X2,Y2,BZ,N1,G);    
%     N1 = 4;
%     L11_wT50_circ_r5mm(nn) = selfInductance_BFields(wT,ri,ra,I,X2,Y2,BZ,N1,G);    
%     N1 = 5;
%     L11_wT75_circ_r5mm(nn) = selfInductance_BFields(wT,ri,ra,I,X2,Y2,BZ,N1,G); 
    N1 = 0;
    L11_sq_L5mm(nn) = selfInductance_BFields(wT,ri,ra,I,X2,Y2,BZ,N1,G);
    N1 = 1;
    L11_wT2_sq_L5mm(nn) = selfInductance_BFields(wT,ri,ra,I,X2,Y2,BZ,N1,G);
    N1 = 2;
    L11_wT4_sq_L5mm(nn) = selfInductance_BFields(wT,ri,ra,I,X2,Y2,BZ,N1,G);
    %
    N1 = 3;
    L11_wT100_sq_L5mm(nn) = selfInductance_BFields(wT,ri,ra,I,X2,Y2,BZ,N1,G);    
    N1 = 4;
    L11_wT50_sq_L5mm(nn) = selfInductance_BFields(wT,ri,ra,I,X2,Y2,BZ,N1,G);    
    N1 = 5;
    L11_wT75_sq_L5mm(nn) = selfInductance_BFields(wT,ri,ra,I,X2,Y2,BZ,N1,G);  
    %
    if(mod(ns,100)==0)
       disp(num2str(ns));
    end
    nn=nn+1;
end
disp('done!');