%%
clear all; close all; clc;

global I0
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% input parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
u0 = 4*pi*10^-7;        % Permeability of free space
uc = 1.256629*10^-6;    % Permeability of copper 
I0  = struct('I',1);
% width of wire
wT  = 0.2546e-3;    % units:[m] (this example at 30AWG)
% total height of wire coil
h   = wT*0.35;
% number of turns along the z-direction
N   = 2;        % scalar(no units), preferably integer 
% the last point along the z-direction
zEnd = h*N*2*pi;
ra = 10e-3;%2;  % elliptical's "width", units:[m]
ri = 10e-3;%1;  % elliptical's "length", units:[m]
W0 = ra;        % rectangle width, units:[m] 
L0 = ri;        % rectangle length, units:[m]
%phi = 10;      % 10[deg]
numSeg = 200;   % total number of points along the current path for a 
% single coil (i.e. the coiled wire antenna). For example: a N=2 Nxy=2 
% numSeg=200 coil will result in 200 points when Nxy=1 (inner coil) and
% another 200 points when Nxy=2 (outer coil) resutling in a total of 400
% points for the structure. This does not include the points for the feed
% lines. Units: N/A MUST BE integer
phi    = numSeg;
O      = 1;     % Stating orientation for the most innner coiled 
% 1 is CW (Clockwise) otherwise CCW (Counter Clockwise). For example: a N=2
% Nxy=2 O=1 will result with the inner coil (Nxy=1) to start CW and outer
% coil (Nxy=2) to be CCW

% Number of turns along the xy-plane.
Nxy    = 0;     % scalar(no units), preferably integer      

% use for HFSS
ZN = N*4 + 2;
zRect = linspace(0,zEnd,ZN)';
numel(zRect)
%% wire
[Sx,Sy,Sz] = singleLoop(ra,ri,phi,O,wT);

% [Sx,Sy,Sz] = constrCircWire(zEnd,ra,ri,phi,N,O,wT,Nxy);
% [Sx,Sy,Sz] = constrRectWire(h,W0,L0,phi,N,O,wT,Nxy);   
%
figure(1e3)
H=plot3(Sx,Sy,Sz,'.');
xlabel('x'); ylabel('y'); zlabel('z');
grid on; %axis equal;
xlim([-7e-3 7e-3]);
ylim([-7e-3 7e-3]);
view(45,45);
%% Calc B-Fields

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% input parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Nx = 1000; Ny = 1000; Nz = 2; Ns = [Nx,Ny,Nz];
Nx = 400; Ny = 400; Nz = 400; Ns = [Nx,Ny,Nz];
%Nx = 400; Ny = 400; Nz = 2; Ns = [Nx,Ny,Nz];
%xminb=-(h+ra); yminb=-(h+ra); zminb=-(h+ra);
%xmaxb=h+ra;    ymaxb=h+ra;    zmaxb= h+ra;
%{
xminb=-70e-3; yminb=-50e-3; zminb=-2e-3;    % [m]
xmaxb= 70e-3; ymaxb= 50e-3; zmaxb= 5e-3;    % [m]
%}
%{
% XY
%xminb=-ri*1.25; yminb=-ri*1.25; zminb= -zEnd*1.1;    % [m]
%xmaxb= ri*1.25; ymaxb= ri*1.25; zmaxb=  zEnd*1.1;    % [m]

%xminb=-ri*1.25; yminb=-ri*1.25; zminb= -(6*wT);    % [m]
%xmaxb= ri*1.25; ymaxb= ri*1.25; zmaxb=  zEnd+12*wT;    % [m]

% rect
%xminb=-ri*2; yminb=-ri*2; zminb= -ri*2;    % [m]
%xmaxb= ri*2; ymaxb= ri*2; zmaxb= ri*2;    % [m]
%}

%xyz  =ri*1.25;
xyz  =ri/2;
xminb=-xyz*2; yminb=-xyz*2; zminb= 0;    % [m]
xmaxb= xyz*2; ymaxb= xyz*2; zmaxb= xyz;    % [m]
bBox = [xminb,yminb,zminb; xmaxb,ymaxb,zmaxb];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% compute B-Fields
tic;
%[bX,bY,bZ, BX,BY,BZ, normB,R] = ...
%    CalcB_FAST(I0.I,Sx,Sy,Sz,bBox,Ns);

[bX,bY,bZ, BX,BY,BZ, normB,R] = ...
    CalcB_SLOW(I0.I,Sx,Sy,Sz,bBox,Ns);    
%%
normB = sqrt(BX.^2+BY.^2+BZ.^2);
nBX   = BX./normB;
nBY   = BY./normB;
nBZ   = BZ./normB;
B0 = struct('BX',BX,'BY',BY,'BZ',BZ,'X',bX,'Y',bY,'Z',bZ);
toc;
%% mag
nn=floor(Nx/2);
%
% XZ
%H=plot3(Sx(1:361),Sz(1:361),Sy(1:361),'-');
%BO.Var(Ny:Nx:Nz)
%
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
view(0,90); 
grid on; 
%axis tight;
contourcbar;
%}
%
% XY
nz = 1;
X2   = squeeze(B0.X(:,:,nz));
Y2   = squeeze(B0.Y(:,:,nz));
Z2   = squeeze(B0.Z(:,:,nz));
B2   = squeeze(normB(:,:,nz)); 
BXY  = squeeze(B0.BY(:,:,nz));
nBXY = squeeze(nBZ(:,:,nz));

figure(nn)
%[M0,c]=contourf(X2,Y2,B2);
[M0,c]=contourf(X2,Y2,nBXY);
%surface(X2,Y2,B2);
xlabel('x[m]','FontWeight','bold','FontSize', 24); 
ylabel('y[m]','FontWeight','bold','FontSize', 24);
%xlim([-0.5 0.5]);
%ylim([-0.5 0.5]);
view(0,90); %grid on; axis tight;
contourcbar;
%}
%
% YZ 
%                 (Ny:Nx:Nz)
figure(nn+2)
X2 = squeeze(B0.X(:,nn,:));
Y2 = squeeze(B0.Y(:,nn,:));
Z2 = squeeze(B0.Z(:,nn,:));
B2 = squeeze(normB(:,nn,:)); 
[M0,c]=contourf(Y2,Z2,B2);
xlabel('y[m]','FontWeight','bold','FontSize', 24); 
ylabel('z[m]','FontWeight','bold','FontSize', 24);
% zlabel('z[m]','FontWeight','bold','FontSize', 24);
view(0,90); 
%grid on; axis tight;
contourcbar;
%}
%%
%
nn=150;
ss=10;
%L=quiver3(B0.X(nn,:,:),B0.Z(nn,:,:),B0.Y(nn,:,:),nBX(nn,:,:),nBZ(nn,:,:),nBY(nn,:,:),'b'); % matlab
%{
%XZ
figure
L=quiver3(B0.X(nn,1:ss:end,1:ss:end),B0.Z(nn,1:ss:end,1:ss:end),...
B0.Y(nn,1:ss:end,1:ss:end),nBX(nn,1:ss:end,1:ss:end),...
nBZ(nn,1:ss:end,1:ss:end),nBY(nn,1:ss:end,1:ss:end),'b'); % matlab
%}
%{
% YZ
L=quiver3(B0.X(1:ss:end,nn,1:ss:end),B0.Z(1:ss:end,nn,1:ss:end),...
B0.Y(1:ss:end,nn,1:ss:end),nBX(1:ss:end,nn,1:ss:end),...
nBZ(1:ss:end,nn,1:ss:end),nBY(1:ss:end,nn,1:ss:end),'b'); % matlab
view(90,0)
%}
%
% XY
figure
%hold all;
L=quiver3(B0.X(1:ss:end,1:ss:end,nn),B0.Z(1:ss:end,1:ss:end,nn),...
B0.Y(1:ss:end,1:ss:end,nn),nBX(1:ss:end,1:ss:end,nn),...
nBZ(1:ss:end,1:ss:end,nn),nBY(1:ss:end,1:ss:end,nn),'b'); % matlab
view(0,90)
%}
%{
%L=quiver3(B0.X(nn,1:mm:end,1:mm:end),B0.Z(nn,1:mm:end,1:mm:end),...
%    B0.Y(nn,1:mm:end,1:mm:end),nBX(nn,1:mm:end,1:mm:end),...
%    nBZ(nn,1:mm:end,1:mm:end),nBY(nn,1:mm:end,1:mm:end),'b'); % matlab

xlabel('x'); ylabel('y'); zlabel('z');
view(0,90)
%}

%{
    X2    = squeeze(B0.X(:,:,nn));
    Y2    = squeeze(B0.Y(:,:,nn));
    Z2    = squeeze(B0.Z(:,:,nn));
    BZ    = squeeze(B0.BZ(:,:,nn));
%}