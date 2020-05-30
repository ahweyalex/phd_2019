% Alexander Moreno
% 05-01-2019
% ------------------------------------------------------------------------
% Description:
% A)
% 1) Computes B-Fields for a given current path. 
% 2) Calucates B-Fields from antenna structure
% 3) Saves the Bx,By,Bz corresponding to each cartesian points (x,y,z)

function [X,Y,Z,BX,BY,BZ,normB,R0] = CalcB_FAST(I,xS,yS,zS,bBox,Ns)
% initialize variables
mu0  = 4*pi*1e-7; % free space permeability <scalar> [H/m]
lenS = numel(xS);
% bBox = [xminb,yminb,zminb; xmaxb,ymaxb,zmaxb];
xminb=bBox(1,1);  yminb=bBox(1,2);  zminb=bBox(1,3);   
xmaxb=bBox(2,1);  ymaxb=bBox(2,2);  zmaxb=bBox(2,3);
% initial        % final           % res      % distance  
xi=ceil(min(xS)); xf=ceil(max(xS)); Nx=Ns(1); xdis=abs(xmaxb-xminb); 
yi=ceil(min(yS)); yf=ceil(max(yS)); Ny=Ns(2); ydis=abs(ymaxb-yminb); 
zi=ceil(min(zS)); zf=ceil(max(zS)); Nz=Ns(3); zdis=abs(zmaxb-zminb); 
% construct 3-D grid coordinates defined by the vectors x, y, and z
%x_M = linspace(-xdis, xdis, Nx);
%y_M = linspace(-ydis, ydis, Ny);
%z_M = linspace(-zdis, zdis, Nz);

x_M = linspace(xminb, xmaxb, Nx);
y_M = linspace(yminb, ymaxb, Ny);
z_M = linspace(zminb, zmaxb, Nz);
[X,Y,Z]=meshgrid(x_M,y_M,z_M);
% initialize null/zero matrcies 
dBx = zeros(Ny,Nx,Nz,lenS); BX = zeros(Ny,Nx,Nz);
dBy = zeros(Ny,Nx,Nz,lenS); BY = zeros(Ny,Nx,Nz);
dBz = zeros(Ny,Nx,Nz,lenS); BZ = zeros(Ny,Nx,Nz);
R   = zeros(Ny,Nx,Nz,lenS); % magnitude vector (source to point of interest)

%dBx = zeros(Nx,Ny,Nz,lenS); BX = zeros(Nx,Ny,Nz);
%dBy = zeros(Nx,Ny,Nz,lenS); BY = zeros(Nx,Ny,Nz);
%dBz = zeros(Nx,Ny,Nz,lenS); BZ = zeros(Nx,Ny,Nz);
%R   = zeros(Nx,Ny,Nz,lenS); % magnitude vector (source to point of interest)
%% Compute B-Fields
for n=1:lenS
    R(:,:,:,n) = sqrt((X-xS(n)).^2 + (Y-yS(n)).^2 + (Z-zS(n)).^2).^3;
end
for n=1:(lenS-1)
    dBx(:,:,:,n) = ((yS(n+1)-yS(n)).*(Z-zS(n)) - (zS(n+1)-zS(n)).*(Y-yS(n)))./R(:,:,:,n); 
    dBy(:,:,:,n) = ((zS(n+1)-zS(n)).*(X-xS(n)) - (xS(n+1)-xS(n)).*(Z-zS(n)))./R(:,:,:,n);
    dBz(:,:,:,n) = ((xS(n+1)-xS(n)).*(Y-yS(n)) - (yS(n+1)-yS(n)).*(X-xS(n)))./R(:,:,:,n);
end
coef =  mu0*I/4/pi;
BX(:,:,:) = coef*sum(dBx,4);
BY(:,:,:) = coef*sum(dBy,4);
BZ(:,:,:) = coef*sum(dBz,4);

normB=sqrt(BX.^2+BY.^2+BZ.^2);
nBX = BX./normB;
nBY = BY./normB;
nBZ = BZ./normB;
R0=999; % need to change this 
end