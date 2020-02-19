% Alexander Moreno
% 11-01-2018
%
% Description:
% Testing the functions 
% 1) CalcBFields_Wire_Antenna 
% 2) constrWireAnt
%
clear all; close all; clc;
tic;
% testing constrWireAnt_10_25_2018
% h=10; 
% ra=0.3; ri=0.3; phi=2; N=4; O=1; wT=0.2546e-3; h=(1.1)*(2*wT*N);
ra=0.3; ri=0.3; phi=2; N=4; O=1; wT=0.1; h=(1.1)*(2*wT*N);
[xS,yS,zS] = constrWireAnt(h,ra,ri,phi,N,O,wT);
%% testing CalcBFields_Wire_Antenna
I = 1; Nx = 50; Ny = 50; Nz = 50; Ns = [Nx,Ny,Nz];
xminb=-(h+ra); yminb=-(h+ra); zminb=-(h+ra);
xmaxb=h+ra;    ymaxb=h+ra;    zmaxb= h+ra;
bBox = [xminb,yminb,zminb; xmaxb,ymaxb,zmaxb];
% [X,Y,Z,BX,BY,BZ,normB]   = CalcBFields_Wire_Antenna_v2(I,xS,yS,zS,bBox,Ns);
[X,Y,Z,BX,BY,BZ] = CalcB_WireAnt(I,xS,yS,zS,bBox,Ns);
normB=sqrt(BX.^2+BY.^2+BZ.^2);
nBX = BX./normB;
nBY = BY./normB;
nBZ = BZ./normB;
%% Plot
% antenna structure
hold all;
% bb=145; B=12; 
figure(1)
%H=plot3(xS,yS,zS,'-');
H=plot3(xS(1:721),zS(1:721),yS(1:721),'-');
%H=plot3(xS(1:145),zS(1:145),yS(1:145),'-'); % on the side
xlabel('x [m]'); ylabel('y [m]'); zlabel('z [m]'); 
set(H,'linewidth',5); set(H,'color','r');
title('Antenna Structure');
grid on; axis equal; %axis tight;
% plotBFields(X,Y,Z,BX,BY,BZ);
%% B-Fields Quiver
nn=ceil(Nx)/2; nn=25;
BXn=BX./normB; BYn=BY./normB; BZn=BZ./normB;
%hh=
quiver3(X(nn,:,:),Z(nn,:,:),Y(nn,:,:),BXn(nn,:,:),BZn(nn,:,:),BYn(nn,:,:),'b'); % matlab
% quiver3(X(:,:,nn),Z(:,:,nn),Y(:,:,nn),BXn(:,:,nn),BZn(:,:,nn),BYn(:,:,nn),'b'); % python

%hh= quiver3(X,Z,Y,BXn,BZn,BYn,'b');
%hh= quiver3(X,Y,Z,BXn,BYn,BZn,'b');
% xlabel('x[m]','FontSize', 24); ylabel('y[m]','FontSize', 24); zlabel('z[m]','FontSize', 24);
% xlabel('x[m]','FontSize', 30); ylabel('z[m]','FontSize', 30); zlabel('z[m]','FontSize', 30);
view(0,90)
%%hh= quiver3(X(nn,1:2:end,1:2:end),Z(nn,1:2:end,1:2:end),Y(nn,1:2:end,1:2:end),BXn(nn,1:2:end,1:2:end),BZn(nn,1:2:end,1:2:end),BYn(nn,1:2:end,1:2:end),'b');
% hh= quiver(squeeze(X(nn,:,:)),squeeze(Z(nn,:,:)),squeeze(BXn(nn,:,:)),squeeze(BZn(nn,:,:)),'w');
% hh= quiver(squeeze(X(nn,:,:)),squeeze(Z(nn,:,:)),squeeze(BXn(nn,:,:)),squeeze(BZn(nn,:,:)),'b');
%% B-Fields
%{
matlab
X2 = squeeze(X(nn,:,:));
Y2 = squeeze(Y(nn,:,:));
Z2 = squeeze(Z(nn,:,:));
B2 = squeeze(normB(nn,:,:)); 
%}
% python
X2 = squeeze(X(:,:,nn));
Y2 = squeeze(Y(:,:,nn));
Z2 = squeeze(Z(:,:,nn));
B2 = squeeze(normB(:,:,nn)); 

[M,c]=contourf(X2,Z2,B2);
contourcbar;
view(0,90); grid on; axis tight;
xlabel('x[m]','FontWeight','bold','FontSize', 24); 
ylabel('z[m]','FontWeight','bold','FontSize', 24);
zlabel('z[m]','FontWeight','bold','FontSize', 24);
title('Coiled Wire Antenna:B-Fields (Model)','FontSize', 16);
view(0,90)
ylim([-0.4 1.2]); xlim([-0.9 0.9]);

toc;
%% Mutual inductance 

% toc;
