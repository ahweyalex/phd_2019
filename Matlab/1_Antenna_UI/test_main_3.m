%%
clear all; close all; clc;
global I0
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% input parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
I0  = struct('I',1);
%h   = 3.15e-3;      % [m] 3.15mm
%ra  = 68.38e-3;     % [m] 68mm      % x
%W0  = ra;
%ri  = 48.88e-3;     % [m] 48mm      % y
%L0  = ri;

wT  = 0.2546e-3;    % [m] 30AWG
h   = wT*0.35;
N   = 3; 
zEnd = h*N*2*pi;
ra = 30e-3;%2; % for ex fig
ri = 30e-3;%1; % for ex fig
%phi = 10;           % 10[deg]
numSeg = 1e3;
phi    = numSeg;
O      = 1; 
Nxy    = 1;
%% wire
[Sx,Sy,Sz] = constrCircWire(zEnd,ra,ri,phi,N,O,wT,Nxy);
%%
figure(1e3)
H=plot3(Sx,Sy,Sz,'.');
xlabel('x'); ylabel('y'); zlabel('z');
grid on; axis equal;
%% Calc B-Fields

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% input parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Nx = 200; Ny = 200; Nz = 200; Ns = [Nx,Ny,Nz];
Nx = 100; Ny = 100; Nz = 100; Ns = [Nx,Ny,Nz];

%xminb=-(h+ra); yminb=-(h+ra); zminb=-(h+ra);
%xmaxb=h+ra;    ymaxb=h+ra;    zmaxb= h+ra;
%{
xminb=-70e-3; yminb=-50e-3; zminb=-2e-3;    % [m]
xmaxb= 70e-3; ymaxb= 50e-3; zmaxb= 5e-3;    % [m]
%}

% XY
%xminb=-ri*1.25; yminb=-ri*1.25; zminb= -zEnd*1.1;    % [m]
%xmaxb= ri*1.25; ymaxb= ri*1.25; zmaxb=  zEnd*1.1;    % [m]
xminb=-ri*1.25; yminb=-ri*1.25; zminb= -(6*wT);    % [m]
xmaxb= ri*1.25; ymaxb= ri*1.25; zmaxb=  zEnd+12*wT;    % [m]

bBox = [xminb,yminb,zminb; xmaxb,ymaxb,zmaxb];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% compute B-Fields
tic;
% [X,Y,Z,BX,BY,BZ,normB]   = CalcBFields_Wire_Antenna_v2(I,xS,yS,zS,bBox,Ns);
%[X,Y,Z,BX,BY,BZ] = CalcB_WireAnt(I,xS,yS,zS,bBox,Ns);
    [bX,bY,bZ, BX,BY,BZ, normB,R] = ...
        CalcB_FAST(I0.I,Sx,Sy,Sz,bBox,Ns);
%
normB = sqrt(BX.^2+BY.^2+BZ.^2);
%normB = sqrt(BX.^2+BY.^2);
nBX   = BX./normB;
nBY   = BY./normB;
nBZ   = BZ./normB;
B0 = struct('BX',BX,'BY',BY,'BZ',BZ,'X',bX,'Y',bY,'Z',bZ);
toc;
%% mag
%nn=2;
%nn=75;
%nn=62;
nn=100;
%{
% XZ
%H=plot3(Sx(1:361),Sz(1:361),Sy(1:361),'-');
%{
X2 = squeeze(B0.X(nn,:,:));
Y2 = squeeze(B0.Y(nn,:,:));
Z2 = squeeze(B0.Z(nn,:,:));
B2 = squeeze(normB(nn,:,:));
figure(nn)
[M0,c]=contourf(X2,Z2,B2);
%RRv = squeeze(abs(RR.ReadRange(nn,:,:)));
%[M0,c]=contourf(X2,Z2,RRv);
xlabel('x[m]','FontWeight','bold','FontSize', 24); 
ylabel('z[m]','FontWeight','bold','FontSize', 24);
% zlabel('z[m]','FontWeight','bold','FontSize', 24);
view(0,90); grid on; axis tight;
contourcbar;
%}
%
% YZ 
X2 = squeeze(B0.X(:,nn,:));
Y2 = squeeze(B0.Y(:,nn,:));
Z2 = squeeze(B0.Z(:,nn,:));
B2 = squeeze(normB(:,nn,:)); 
figure(nn)
[M0,c]=contourf(Y2,Z2,B2);
xlabel('y[m]','FontWeight','bold','FontSize', 24); 
ylabel('z[m]','FontWeight','bold','FontSize', 24);
% zlabel('z[m]','FontWeight','bold','FontSize', 24);
view(0,90); 
%grid on; axis tight;
contourcbar;
%}
%
% XY
X2 = squeeze(B0.X(:,:,nn));
Y2 = squeeze(B0.Y(:,:,nn));
Z2 = squeeze(B0.Z(:,:,nn));
B2 = squeeze(normB(:,:,nn)); 
figure(nn)
[M0,c]=contourf(X2,Y2,B2);
%surface(X2,Y2,B2);
xlabel('x[m]','FontWeight','bold','FontSize', 24); 
ylabel('y[m]','FontWeight','bold','FontSize', 24);
%xlim([-0.5 0.5]);
%ylim([-0.5 0.5]);
view(0,90); %grid on; axis tight;
contourcbar;
%}

%%
%{
mm=4;
%L=quiver3(B0.X(nn,:,:),B0.Z(nn,:,:),B0.Y(nn,:,:),nBX(nn,:,:),nBZ(nn,:,:),nBY(nn,:,:),'b'); % matlab
L=quiver3(B0.X(nn,1:mm:end,1:mm:end),B0.Z(nn,1:mm:end,1:mm:end),...
    B0.Y(nn,1:mm:end,1:mm:end),nBX(nn,1:mm:end,1:mm:end),...
    nBZ(nn,1:mm:end,1:mm:end),nBY(nn,1:mm:end,1:mm:end),'b'); % matlab

xlabel('x'); ylabel('y'); zlabel('z');
view(0,90)
%}

%% inductance
nn=100;
u0 = 4*pi*10^-7;        % Permeability  of free space
uc = 1.256629*10^-6;    % Permeability of copper 
u  = u0*uc;
%BZ = squeeze(B0.BZ(:,:,nn));
%sumB = sum(sum(BZ,1),2);
BZ = B0.BZ;             % Bfiled z-direction
sumB = sum(sum(sum(BZ,1),2),3);     % sum of Bz
xdel = sqrt((xmaxb - xminb)^2)/100; % del x
ydel = sqrt((ymaxb - yminb)^2)/100; % del y
A = xdel*ydel;                      % area (ds)
phi11 = u*sumB*A;                   % phi_11
L11 = phi11/I0.I;                   % self ind