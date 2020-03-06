% Alexander Moreno
% 05-01-2019
%
% Description:
% Testing the functions 
% 1) CalcBFields_Wire_Antenna 
% 2) constrWireAnt
%
clear all; close all; clc;
tic;
%% Construct Wire Antenna
% h=10; 
% ra=0.3; ri=0.3; phi=2; N=4; O=1; wT=0.2546e-3; h=(1.1)*(2*wT*N);
%ra=0.3; ri=0.3; phi=2; N=2; O=1; wT=0.1; h=(1.1)*(2*wT*N); Nxy=1;
global I0
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% input parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
I0  = struct('I',1);
h   = 3.15e-3;      % [m] 3.15mm
ra  = 68.38e-3;     % [m] 68mm      % x
ri  = 48.88e-3;     % [m] 48mm      % y
phi = 10;           % 10[deg]
wT  = 0.2546e-3;    % [m] 30AWG
O   = 1; 
N   = 14; 
Nxy = 14;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%[xS,yS,zS] = constrWireAnt(h,ra,ri,phi,N,O,wT,Nxy);
[Sx,Sy,Sz] = constrCircWire(h,ra,ri,...
        phi,N,O,wT,Nxy);
%% plot antenna wire 
figure(1)
plot3(Sx,Sy,Sz);
xlabel('x'); ylabel('y'); zlabel('z');
view(45,30);
%% Calc B-Fields
% I0.I = 1; 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% input parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Nx = 50; Ny = 50; Nz = 50; Ns = [Nx,Ny,Nz];
%xminb=-(h+ra); yminb=-(h+ra); zminb=-(h+ra);
%xmaxb=h+ra;    ymaxb=h+ra;    zmaxb= h+ra;
xminb=-70e-3; yminb=-50e-3; zminb=-2e-3;    % [m]
xmaxb= 70e-3; ymaxb= 50e-3; zmaxb= 5e-3;    % [m]
bBox = [xminb,yminb,zminb; xmaxb,ymaxb,zmaxb];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% compute B-Fields
% [X,Y,Z,BX,BY,BZ,normB]   = CalcBFields_Wire_Antenna_v2(I,xS,yS,zS,bBox,Ns);
%[X,Y,Z,BX,BY,BZ] = CalcB_WireAnt(I,xS,yS,zS,bBox,Ns);
    [bX,bY,bZ, BX,BY,BZ, normB,R] = ...
        CalcB_FAST(I0.I,Sx,Sy,Sz,bBox,Ns);
normB = sqrt(BX.^2+BY.^2+BZ.^2);
nBX   = BX./normB;
nBY   = BY./normB;
nBZ   = BZ./normB;
B0 = struct('BX',BX,'BY',BY,'BZ',BZ,'X',bX,'Y',bY,'Z',bZ);
%% Tag
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% input parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
f=125e3;        % [Hz] 125 KHz
tag.N=250;      %
tag.r=0.5e-3;   % [m] 0.5mm
tag.L=7e-3;     % [m] 7mm
tag.ur=2102;    %
tag.AZ=45;      % [deg] 
tag.EL=45;      % [deg]
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Mutual Inductance
%  Description:
    [M] = Calc_Mutual_Ind(B0,I0,tag);
%% Read-Range
%  Description:
    f = 125e3;
    [tagV,tagRes,tag_selfL] = induced_tagV(M,I0,f,tag);
    RR = struct('ReadRange',tagV,'X',bX,'Y',bY,'Z',bZ);
    % min tagV is 1.5 [V]
toc;
%% Plot
% antenna structure
hold all;
H=plot3(Sx(1:361),Sz(1:361),Sy(1:361),'-');
%xlabel('x [m]'); ylabel('y [m]'); zlabel('z [m]'); 
set(H,'linewidth',5); set(H,'color','r');
title('Antenna Structure');
grid on; axis equal; %axis tight;

%% B-Fields Quiver
nn=ceil(Nx)/2; nn=25;
BXn=B0.BX./normB; BYn=B0.BY./normB; BZn=B0.BZ./normB;
quiver3(B0.X(nn,:,:),B0.Z(nn,:,:),B0.Y(nn,:,:),BXn(nn,:,:),BZn(nn,:,:),BYn(nn,:,:),'w'); % matlab
view(0,90)
%% B-Fields mag
hold all;
%H=plot3(Sx(1:361),Sz(1:361),Sy(1:361),'-');
nn=ceil(Nx)/2; nn=30;
%
X2 = squeeze(B0.X(nn,:,:));
Y2 = squeeze(B0.Y(nn,:,:));
Z2 = squeeze(B0.Z(nn,:,:));
B2 = squeeze(normB(nn,:,:));
[M0,c]=contourf(X2,Z2,B2);
RRv = squeeze(abs(RR.ReadRange(nn,:,:)));
%[M0,c]=contourf(X2,Z2,RRv);
xlabel('x[m]','FontWeight','bold','FontSize', 24); 
ylabel('z[m]','FontWeight','bold','FontSize', 24);
% zlabel('z[m]','FontWeight','bold','FontSize', 24);
view(0,90); grid on; axis tight;
contourcbar;
%}
%{
X2 = squeeze(B0.X(:,nn,:));
Y2 = squeeze(B0.Y(:,nn,:));
Z2 = squeeze(B0.Z(:,nn,:));
B2 = squeeze(normB(:,nn,:)); 
[M0,c]=contourf(Y2,Z2,B2);
xlabel('y[m]','FontWeight','bold','FontSize', 24); 
ylabel('z[m]','FontWeight','bold','FontSize', 24);
% zlabel('z[m]','FontWeight','bold','FontSize', 24);
view(0,90); grid on; axis tight;
contourcbar;
%}
%{
X2 = squeeze(B0.X(:,:,nn));
Y2 = squeeze(B0.Y(:,:,nn));
Z2 = squeeze(B0.Z(:,:,nn));
B2 = squeeze(normB(:,:,nn)); 
[M0,c]=contourf(X2,Y2,B2);
xlabel('x[m]','FontWeight','bold','FontSize', 24); 
ylabel('y[m]','FontWeight','bold','FontSize', 24);
xlim([-0.8 0.8]);
ylim([-0.5 0.5]);
view(0,90); grid on; axis tight;
contourcbar;
% zlabel('z[m]','FontWeight','bold','FontSize', 24);
%}

%{
contourcbar;
view(0,90); grid on; axis tight;
xlabel('x[m]','FontWeight','bold','FontSize', 24); 
ylabel('z[m]','FontWeight','bold','FontSize', 24);
zlabel('z[m]','FontWeight','bold','FontSize', 24);
title('Coiled Wire Antenna:B-Fields (Model)','FontSize', 16);
view(0,90);
%ylim([-0.5 0.9]); xlim([-0.9 0.9]);
%}
%% read-range plot

