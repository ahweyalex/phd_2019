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
ra=0.3; ri=0.3; phi=2; N=2; O=1; wT=0.1; h=(1.1)*(2*wT*N); Nxy=1;
%[xS,yS,zS] = constrWireAnt(h,ra,ri,phi,N,O,wT);
[xS,yS,zS] = constrWireAnt(h,ra,ri,phi,N,O,wT,Nxy);
%%
plot3(xS,yS,zS);
xlabel('x'); ylabel('y'); zlabel('z');
view(0,90);
%% Calc B-Fields
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
%% Tag
f=125e3;
tag.N=250; tag.r=0.5e-3; tag.h=7e-3; tag.ur=2102;
[M12] = Calc_Mutual_Ind(B0,I0,tag);
[tagV,tagRes,tag_selfL] = induced_tagV(M,I0,f,tag);
% min tagV is 1.5 [V]


%{
%% Inductance 
% tag stuff
% testing
Ntag=250; tagL=7e-3; tagR=0.5e-3; S=ra*ri*pi; o=5.8*10^7;%[S/m]
M   = Calc_Mutual_Ind(BX,BY,BZ,I,Ntag,tagR);
L11 = Calc_Self_Ind(BX,BY,BZ,ra,ri,N);
L22 = (u0*(Ntag^2)*S)/tagL;
R22 = tagL/(o*S);
%% induced voltage
freq = 125e3; % 125[KHz]
w = 2*pi*freq;
% u2 = (1j.*w.*M.*I1)./(1 +((1j.*w.*L22+R2)./RL));
u2 = (1j.*w.*M.*I1)./(1 +(1j.*w.*L22+R2));
%}
toc;
%% Plot
% antenna structure
hold all;
figure(1)
H=plot3(xS(1:361),zS(1:361),yS(1:361),'-');
xlabel('x [m]'); ylabel('y [m]'); zlabel('z [m]'); 
set(H,'linewidth',5); set(H,'color','r');
title('Antenna Structure');
grid on; axis equal; %axis tight;
%%
% B-Fields Quiver
nn=ceil(Nx)/2; nn=25;
BXn=BX./normB; BYn=BY./normB; BZn=BZ./normB;
quiver3(X(nn,:,:),Z(nn,:,:),Y(nn,:,:),BXn(nn,:,:),BZn(nn,:,:),BYn(nn,:,:),'w'); % matlab
view(0,90)
% B-Fields
X2 = squeeze(X(nn,:,:));
Y2 = squeeze(Y(nn,:,:));
Z2 = squeeze(Z(nn,:,:));
B2 = squeeze(normB(nn,:,:)); 
[M0,c]=contourf(X2,Z2,B2);
contourcbar;
view(0,90); grid on; axis tight;
xlabel('x[m]','FontWeight','bold','FontSize', 24); 
ylabel('z[m]','FontWeight','bold','FontSize', 24);
zlabel('z[m]','FontWeight','bold','FontSize', 24);
title('Coiled Wire Antenna:B-Fields (Model)','FontSize', 16);
view(0,90)
ylim([-0.5 0.9]); xlim([-0.9 0.9]);
%}