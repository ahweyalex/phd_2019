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
mu0  =  4*pi*10^-7; % free space permeability <scalar> [H/m]
%uc   = 1.256629*10^-6;    % Permeability of copper 
%u    = mu0*uc;
%lenS = numel(xS);

% bBox = [xminb,yminb,zminb; xmaxb,ymaxb,zmaxb];
xminb=bBox(1,1);  yminb=bBox(1,2);  zminb=bBox(1,3);   
xmaxb=bBox(2,1);  ymaxb=bBox(2,2);  zmaxb=bBox(2,3);

% initial        % final           % res      % distance  
xi=ceil(min(xS)); xf=ceil(max(xS)); Nx=Ns(1); xdis=abs(xmaxb-xminb); 
yi=ceil(min(yS)); yf=ceil(max(yS)); Ny=Ns(2); ydis=abs(ymaxb-yminb); 
zi=ceil(min(zS)); zf=ceil(max(zS)); Nz=Ns(3); zdis=abs(zmaxb-zminb);

% construct 3-D grid coordinates defined by the vectors x, y, and z
x_M = linspace(xminb, xmaxb, Nx);
y_M = linspace(yminb, ymaxb, Ny);
z_M = linspace(zminb, zmaxb, Nz);
%z_Ml = linspace(zminb, 0, Nz/2);
%z_Mr = linspace(0, zmaxb, Nz/2+1);
%z_M = [z_Ml,z_Mr(2:end)];
[X,Y,Z]=meshgrid(x_M,y_M,z_M);

%% Discretization of source
    dS = 1e9;        % filament max discretization step [m]
    xP=[]; yP=[]; zP=[];
    Ns = numel(xS)-1;
    % Source of current flow along the wire antenna
    S = [xS;yS;zS]; 
    for sn=1:Ns
        L_Si = norm(S(sn,:)-S(sn+1,:));
        NP  = ceil(L_Si/dS);
        
        xP = [xP, linspace(xS(sn),xS(sn+1), NP)];
        yP = [yP, linspace(yS(sn),yS(sn+1), NP)];
        zP = [zP, linspace(zS(sn),zS(sn+1), NP)];
    end
    
    % initialize null/zero matrcies 
    lenDB = length(xP)-1;
    dBx_FAST = zeros(Ny,Nx,Nz,lenDB); BX = zeros(Ny,Nx,Nz);
    dBy_FAST = zeros(Ny,Nx,Nz,lenDB); BY = zeros(Ny,Nx,Nz);
    dBz_FAST = zeros(Ny,Nx,Nz,lenDB); BZ = zeros(Ny,Nx,Nz);

    R_FAST   = zeros(Ny,Nx,Nz,lenDB); % magnitude vector (source to point of interest)
%% Compute B-Fields (FAST)
f='fast start'
% FAST
test=1;
for n=1:length(xP)-1
    R_FAST(:,:,:,n) = sqrt((X-xP(n)).^2 + (Y-yP(n)).^2 + (Z-zP(n)).^2).^3;
end
test=1;
for n=1:length(xP)-1
    % dBx (cross product x)
    dBx_FAST(:,:,:,n) = ((yP(n+1)-yP(n)).*(Z-zP(n))... 
        - (zP(n+1)-zP(n)).*(Y-yP(n)))...
        ./R_FAST(:,:,:,n); 
                    
    % dBy (cross product y)            
    dBy_FAST(:,:,:,n) = ((zP(n+1)-zP(n)).*(X-xP(n))... 
        - (xP(n+1)-xP(n)).*(Z-zP(n)))...
        ./R_FAST(:,:,:,n);
    
    % dBz (cross product z)     
    dBz_FAST(:,:,:,n) = ((xP(n+1)-xP(n)).*(Y-yP(n))... 
    - (yP(n+1)-yP(n)).*(X-xP(n)))...
    ./R_FAST(:,:,:,n); % cross product z
     
    %dBz_FAST(:,:,:,n) = ((xP(n+1)-xP(n)).*(Y-yP(n))... 
    %    - (yP(n+1)-yP(n)).*(X-xP(n)))...
    %    ./R_FAST(:,:,:,n);
end
coef =  mu0*I/4/pi;
BX(:,:,:) = coef*sum(dBx_FAST,4);
BY(:,:,:) = coef*sum(dBy_FAST,4);
BZ(:,:,:) = coef*sum(dBz_FAST,4);

normB=sqrt(BX.^2+BY.^2+BZ.^2);
nBX = BX./normB;
nBY = BY./normB;
nBZ = BZ./normB;
R0=999; % need to change this 
f='fast done'

%{
for n=1:lenS
    R(:,:,:,n) = sqrt((X-xS(n)).^2 + (Y-yS(n)).^2 + (Z-zS(n)).^2).^3;
end
for n=1:(lenS-1)
    dBx(:,:,:,n) = ((yS(n+1)-yS(n)).*(Z-zS(n)) - (zS(n+1)-zS(n)).*(Y-yS(n)))./R(:,:,:,n); 
    dBy(:,:,:,n) = ((zS(n+1)-zS(n)).*(X-xS(n)) - (xS(n+1)-xS(n)).*(Z-zS(n)))./R(:,:,:,n);
    dBz(:,:,:,n) = ((xS(n+1)-xS(n)).*(Y-yS(n)) - (yS(n+1)-yS(n)).*(X-xS(n)))./R(:,:,:,n);
end
coef =  u*I/4/pi;
BX(:,:,:) = coef*sum(dBx,4);
BY(:,:,:) = coef*sum(dBy,4);
BZ(:,:,:) = coef*sum(dBz,4);

normB=sqrt(BX.^2+BY.^2+BZ.^2);
nBX = BX./normB;
nBY = BY./normB;
nBZ = BZ./normB;
R0=999; % need to change this 
%}
end