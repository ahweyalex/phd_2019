clear all; close all; clc;

% from example
%a = 1.55;    
%r = 0.1:0.1:2.9;        % radius values  % size:1x29
%z = -3:0.1:3-0.1;       % z values       % size:1x60

% mine (A)
%
ri = 7e-3;
Nr = 51;
Nz = 101;
a  = ri;
r  = linspace(1e-9,2*ri,Nr);        % radius values
z  = linspace(-2*ri,2*ri,Nz);       % z values
%}
% mine (B)
%{
ri = 5e-3;
Nx = 12;
Ny = 11;
Nz = 3;
a  = ri;
x = linspace(-2*ri,2*ri,Nx);
y = linspace(-2*ri,2*ri,Ny);
z = linspace(-2*ri,2*ri,Nz);
[X,Y,Z] = meshgrid(x,y,z);
[theta,r,z] = cart2pol(X,Y,Z);
%}
[Br,Bz,R,Z] = BFC(a,r,z);
%-------------------------------plots-------------------------------------%
mag = sqrt(Br.^2 + Bz.^2);
Bz_s  = Bz./mag;
Br_s  = Br./mag;
%
figure
H = quiver(squeeze(R),squeeze(Z),squeeze(Br_s),squeeze(Bz_s));
%xlim([0,3]); ylim([-3, 3]);
title('Matlab Quiver');
xlabel('Range[m]');
ylabel('Z[m]');
%
figure
H = plot(Z(:,10),Bz(:,10), Z(:,20),Bz(:,20));
xlim([-3 3]); ylim([-0.0000003,0.0000003]);
title('Matlab')
%}
%---------------------------set up for L11 -------------------------------%
%%
Nt    = 20;
theta = linspace(-pi/180,2*pi,Nt)';
[row,col] = size(Br);
for tn=1:Nt
    th(:,:,tn) = theta(tn)*ones(row,col);
end
bz = repmat(Bz,[1,1,Nt]);
br = repmat(Br,[1,1,Nt]);

[R0,Z0,T0] = meshgrid(r,z,theta); 
[Xc,Yc,Zc] = pol2cart(T0,R0,Z0);
%%
%zn = 55;
rn = 56;
XC=squeeze(Xc(rn,:,:));
YC=squeeze(Yc(rn,:,:));
BZC=squeeze(bz(rn,:,:));
%XC=squeeze(Xc(:,zn,:));
%YC=squeeze(Yc(:,zn,:));
%BZC=squeeze(bz(:,zn,:));
figure
H=surfc(XC,YC,BZC); 
view(180,0);
H=surfc(XC,YC,BZC);
xlabel('x[m]');
xlabel('y[m]');
zlabel('Bz');
title('Z@0(Nz:56/100)');
%%
ra = ri;
I  = 1;
X2 = XC;
Y2 = YC;
N1 = 1;
G = 'c';
L11 = selfInductance_BFields(ri,ra,I,X2,Y2,BZC,N1,G);