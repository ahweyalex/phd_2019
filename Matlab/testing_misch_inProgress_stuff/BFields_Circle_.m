% Alexander Moreno
% 10-02-2020
%
% Source: 
% https://www.grant-trebbin.com/2012/04/off-axis-magnetic-field-of-circular.html
%
%---------------------------DESCRIPTION-----------------------------------%
% Computes the B-Fields for a circle loop at any point in space in
% cylindrical coordinates
% 
clear all; close all; clc;

ri = 5e-3;
a  = ri;
W  = ri;
mu = 4*pi*1e-7;     % free space permeability <scalar> [H/m]
I  = 1;
%-------------------------------------------------------------------------%
%{
Nx = 1001;
Ny = 1001;
Nz = 29;
xminb = -W; 
xmaxb =  W;
yminb = -W; 
ymaxb =  W;
zminb = -W;
zmaxb = W;
% create 1D arrays for each axis
x_M = linspace(xminb, xmaxb, Nx);
y_M = linspace(yminb, ymaxb, Ny);
%z_M = linspace(zminb, zmaxb, Nz);
z_M = -3:0.1:3-0.1;       % z values
% create multi-dim arrays with the 1D arrays 
[x,y,z]=meshgrid(x_M,y_M,z_M);
[T0,R0,Z0] = cart2pol(x,y,z);
R = R0(:,1,:);
Z = Z0(:,1,:);
%}
%-------------------------------------------------------------------------%
%
%a  = ri;
a = 1.55;    % from example
%-------------------Spatial Locations to SolveBFields---------------------%
Nr = 1001;   % samples in radius
Nz = 1001;   % samples in z-direction
Nt = 100;   % samples along theta/phi direction
N  = 361;   % number of samples

% from the example python code
% r = 0.1:0.1:03;    % radius values
% z = -3:0.1:3;      % z values
% python goes from starting to point less than final value
r = 0.1:0.1:2.9;        % radius values
z = -3:0.1:3-0.1;       % z values

%r = linspace(0,2*ri,Nr);
%z = linspace(-ri,ri,Nz);
t = 0:pi/180:2*pi-pi/180;
[R,Z] = meshgrid(r,z);
%}
%--------------------------set upcoefficients-----------------------------%
K = sqrt( (4.*R.*a) ./ (Z.^2 + (a+R).^2) );
gamma_val   = sqrt(Z.^2 + (a+R).^2);
epsilon_val = Z.^2 + (R-a).^2;
[E1,E2] = ellipke(K.^2);
%-------------------------------------------------------------------------%
%{
% Ua = np.divide((mu * current) / (2 * np.pi), gamma)
Ua = ((mu.*I)./(2.*pi))./gamma_val;
% Va = np.multiply(np.divide(np.divide((mu * current) / (2 * np.pi), gamma), R), Z)
Va = ((((mu*I)./(2*pi)./gamma_val))./R).*Z;
%
% Bz
U = (((a.^2 - Z.^2 - R.^2)./epsilon_val).*E2 + E1).*Ua;
%Br
%}
%
%Bz 
U = ((mu.*I)./(2.*pi.*gamma_val))... 
     .*(((a.^2 - Z.^2 - R.^2)./epsilon_val).*...
     E2 + E1);
Bz = U;
%Br
V = ((mu.*I.*Z)./(2.*pi.*R.*gamma_val))...
     .*(((Z.^2 + R.^2 + a.^2)./epsilon_val).*...
     E2 - E1);
Br = V; 

disp('done');
 %}
%
%-------------------------------------------------------------------------%
%
%
mag = sqrt(V.^2 + U.^2);
Us  = U./mag;
Vs  = V./mag;
%
figure(1)
H = quiver(squeeze(R),squeeze(Z),squeeze(Vs),squeeze(Us));
%xlim([0,3]); ylim([-3, 3]);
title('Matlab Quiver');
xlabel('Range[m]');
ylabel('Z[m]');
%
figure(2)
H = plot(Z(:,10),U(:,10), Z(:,20),U(:,20));
xlim([-3 3]); ylim([-0.0000003,0.0000003]);
title('Matlab')
%}

%=========================================================================%
%=========================================================================%
%=========================================================================%
%=========================================================================%
%%
[r,c]   = size(R);
theta   = zeros(r,c);
[x,y,z] = pol2cart(theta,R,Z);

%=========================================================================%
%=========================================================================%
%=========================================================================%
%=========================================================================%
%%
[X,Y,Z]    = pol2cart(T0,R0,Z0);
[BX,BY,BZ] = pol2cart(T0,br,bz);
cz = 501;
X2  = squeeze(X(cp,:,:));
Y2  = squeeze(Y(cp,:,:));   
Z2  = squeeze(Z(cp,:,:));
BX2 = squeeze(BX(cp,:,:));
BY2 = squeeze(BY(cp,:,:));
BZ2 = squeeze(BZ(cp,:,:));
%
figure(3)
%H = quiver3(X,Y,Z,BX,BY,BZ);
H = quiver(X(cp,:,:),Y(cp,:,:),BX(cp,:,:),BY(cp,:,:));
title('Quiver on XY-Plane [cutplane Z=0 @ Z(501]  (radius:5mm)');
xlabel('x[m]');
ylabel('y[m]');
%
ra = ri;
N1 = 1;
G  = 'c';
[L11] = selfInductance_BFields(ri,ra,I,X2,Y2,BZ2,N1,G)