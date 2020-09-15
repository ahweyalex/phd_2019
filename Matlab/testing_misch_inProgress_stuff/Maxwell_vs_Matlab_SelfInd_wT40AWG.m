% Alexander Moreno
% 09-03-2020
clear all; close all; clc;
%-------------------------------------------------------------------------%
wT = 0.2546e-3;  % 30AWG 

%{
% Nxy = 201; 
% Maxwell -- L11: 26nH 
% A  = importdata('Rect_ri10_ra10_100.fld');
%-------------------------------------------------------------------------%
%wT     = 0.07874e-3; % 40AWG
%-------------------------------------------------------------------------%
%%% rect loop L11 = 36.1155 nH -- website:  L=32.28nH
Nnn = 100; N = 1;
A  = importdata('Rect_ri10_ra10_wT40AWG.fld'); 
%-------------------------------------------------------------------------%
%%% rect N3 L11 = 1.933uH
%Nxy = 101; N = 3; 
%A  = importdata('Rect_N3_ri10_ra10_wT40AWG.fld');
%-------------------------------------------------------------------------%
%wT = 0.07874e-3;
ri = 10e-3;
ra = 10e-3;
I  = 1;
G  = 'r';
x  = reshape(A.data(:,1),Nnn,Nnn);
y  = reshape(A.data(:,2),Nnn,Nnn);
z  = reshape(A.data(:,3),Nnn,Nnn);
bx = reshape(A.data(:,4),Nnn,Nnn);
by = reshape(A.data(:,5),Nnn,Nnn);
bz = reshape(A.data(:,6),Nnn,Nnn);
[Maxwell_L11] = selfInductance_BFields(ri,ra,I,x,y,bz,N,G);
%}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
N = 1;
global I0; I0 = struct('I',1);
h       = wT*0.35;  
zEnd    = h*N*2*pi;
ra      = 10e-3;
ri      = 10e-3;
W0      = ra;       
L0      = ri;                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        numSeg  = 200;
phi     = numSeg;
%O      = 1;
O       = 0;
Nxy     = 1;
%-------------------------------------------------------------------------%
%Single rectangular loop, Assumes Nxy=0 and N=0 
%[Sx,Sy,Sz] = singleLoop(ra,ri,phi,O,wT);
%plot3(Sx,Sy,Sz,'o')
grid on;
xlabel('x');
ylabel('y');
zlabel('z');
%Multi-Coiled Elliptical Wire 
%[Sx,Sy,Sz] = constrCircWire(zEnd,ra,ri,phi,N,O,wT,Nxy);
[Sx,Sy,Sz] = singleRectLoop(W0,L0,numSeg,wT,O);
H=plot3(Sx,Sy,Sz,'-o');
xlabel('x'); ylabel('y'); zlabel('z'); grid on;
view(90,90)
%Multi-Coiled Rectangular Wire 
%[Sx,Sy,Sz] = constrRectWire(h,ra,ri,phi,N,O,wT,Nxy); 
%-------------------------------------------------------------------------%
%{
figure
%H=plot3(Sx,Sy,Sz,'.');
H=plot3(Sx,Sy,Sz,'O');
fontSize = 14;
xlabel('x[m]','FontWeight','bold','FontSize', fontSize); 
ylabel('y[m]','FontWeight','bold','FontSize', fontSize); 
zlabel('z[m]','FontWeight','bold','FontSize', fontSize); 
title('Wire Antenna','FontWeight','bold','FontSize', fontSize); 
grid on; axis tight on;
view(45,45);
%}
%%
%{
%-------------------------------------------------------------------------%
%Nz = 1; 
Nz = 1;
%--------------------------%
%Nx = 49; Ny = Nx; 
%Nx = 50; Ny = Nx; 
%Nx = 51; Ny = Nx; 
%--------------------------%
%Nx = 74; Ny = Nx; 
%Nx = 75; Ny = Nx; 
%Nx = 76; Ny = Nx; 
%--------------------------%
%Nx = 99; Ny = Nx;
%Nx = 100; Ny = Nx;
%Nx = 101; Ny = Nx;
%--------------------------%
%Nx = 199; Ny = Nx;
%Nx = 200; Ny = Nx;
Nx = 464; Ny = Nx;
%--------------------------%
%}
ni = 1;
%NN=20:240
%for ns=20:240
NN=219:224;
for ns=219:224
    Nx = ns; Ny = ns;
    Nz = 1;
    Ns = [Nx,Ny,Nz];
    if (ri>=ra)
        %xyz = 2*ri;
        xyz = ri;
    elseif (ra>=ri)
        %xyz = 2*ra;
        xyz = ra;
    end
    xminb = -xyz; 
    xmaxb =  xyz;
    yminb = -xyz; 
    ymaxb =  xyz;
    zminb = 0;
    zmaxb = 0;  

    bBox  = [xminb,yminb,zminb; xmaxb,ymaxb,zmaxb];
    tic;
    %[bX,bY,bZ, BX,BY,BZ, normB,R] = ...
    %    CalcB_FAST(I0.I,Sx,Sy,Sz,bBox,Ns);  
     [bX,bY,bZ,BX,BY,BZ,normB,R,dBx,dBy,dBz] = ...
        CalcB_FAST(I0.I,Sx,Sy,Sz,bBox,Ns);
    bX_c{ni}  = bX; 
    bY_c{ni}  = bY;
    bZ_c{ni}  = bZ;
    BX_c{ni}  = BX;
    BY_c{ni}  = BY;
    BZ_c{ni}  = BZ;
    R_c{ni}   = R;
    dBx_c{ni} = dBx;
    dBy_c{ni} = dBy;
    dBz_c{ni} = dBz;  
    %[bX,bY,bZ, BX,BY,BZ, normB,R] = ...
    %    CalcB_SLOW(I0.I,Sx,Sy,Sz,bBox,Ns);      
    toc;
    normB = sqrt(BX.^2+BY.^2+BZ.^2);
    nBX   = BX./normB;
    nBY   = BY./normB;
    nBZ   = BZ./normB;
    B0 = struct('BX',BX,'BY',BY,'BZ',BZ,'X',bX,'Y',bY,'Z',bZ);

    G     = 'r'; % rect/square
    nz = 1;
    %for nz=1:Nz 
    X     = squeeze(B0.X(:,:,nz));
    Y     = squeeze(B0.Y(:,:,nz));
    Z     = squeeze(B0.Z(:,:,nz));
    BX    = squeeze(B0.BX(:,:,nz));
    BY    = squeeze(B0.BY(:,:,nz));
    BZ    = squeeze(B0.BZ(:,:,nz));
    %  
    Matlab_L11(ni) = selfInductance_BFields(ri,ra,I0.I,B0.X,B0.Y,B0.BZ,N,G);
    ni = ni+1;
end    

disp('done')
%end
 %%
 %nx = 200; ny=200; nz=2;
 %plot_BF_Ant(Sx,Sy,Sz,B0.X,B0.Y,B0.Z,B0.BX,B0.BY,B0.BZ,nx,ny,nz)