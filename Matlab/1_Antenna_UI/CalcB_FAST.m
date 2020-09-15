% Alexander Moreno
% 05-01-2019
% ------------------------------------------------------------------------
% Description:
% A)
% 1) Computes B-Fields for a given current path. 
% 2) Calucates B-Fields from antenna structure
% 3) Saves the Bx,By,Bz corresponding to each cartesian points (x,y,z)

%function [X,Y,Z,BX,BY,BZ,normB,R0] = CalcB_FAST(I,xS,yS,zS,bBox,Ns)
function [X,Y,Z,BX,BY,BZ,normB,R_FAST,dBx_FAST,dBy_FAST,dBz_FAST] = CalcB_FAST(I,xS,yS,zS,bBox,Ns)
% initialize variables
mu0  =  4*pi*10^-7; % free space permeability <scalar> [H/m]
%uc   = 1.256629*10^-6;    % Permeability of copper 
%u    = mu0*uc;
%lenS = numel(xS);

% bBox = [xminb,yminb,zminb; xmaxb,ymaxb,zmaxb];
xminb=bBox(1,1);  yminb=bBox(1,2);  zminb=bBox(1,3);   
xmaxb=bBox(2,1);  ymaxb=bBox(2,2);  zmaxb=bBox(2,3);

% res 
Nx=Ns(1);
Ny=Ns(2);
Nz=Ns(3);
% construct 3-D grid coordinates defined by the vectors x, y, and z
x_M = linspace(xminb, xmaxb, Nx);
y_M = linspace(yminb, ymaxb, Ny);
z_M = linspace(zminb, zmaxb, Nz);
[X,Y,Z]=meshgrid(x_M,y_M,z_M);

%% Discretization of source
    dS = 1e9;        % filament max discretization step [m]

    xP=[]; yP=[]; zP=[];
    Ns = numel(xS)-1;
    % Source of current flow along the wire antenna
    %S = [xS;yS;zS]; % older (may be incorrect) [09-04-2020]
    S = [xS,yS,zS]; % new
    for sn=1:Ns
        L_Si(sn) = norm(S(sn,:)-S(sn+1,:));
        NP(sn)  = ceil(L_Si(sn)/dS);
        
        xP = [xP, linspace(xS(sn),xS(sn+1), NP(sn))];
        yP = [yP, linspace(yS(sn),yS(sn+1), NP(sn))];
        zP = [zP, linspace(zS(sn),zS(sn+1), NP(sn))];
        %numel(xP)
    end
%%    
    % initialize null/zero matrcies 
    lenDB = length(xP)-1;
    dBx_FAST = zeros(Ny,Nx,Nz,lenDB); BX = zeros(Ny,Nx,Nz);
    dBy_FAST = zeros(Ny,Nx,Nz,lenDB); BY = zeros(Ny,Nx,Nz);
    dBz_FAST = zeros(Ny,Nx,Nz,lenDB); BZ = zeros(Ny,Nx,Nz);

    R_FAST   = zeros(Ny,Nx,Nz,lenDB); % magnitude vector (source to point of interest)
%% Compute B-Fields (FAST)
f='fast start';
% FAST
test=1;
for n=1:length(xP)-1
    R_FAST(:,:,:,n) = sqrt((X-xP(n)).^2 + (Y-yP(n)).^2 + (Z-zP(n)).^2).^3;
end
%mean(R_FAST,'all')
test=1;
for n=1:length(xP)-1
    % dBx (cross product x)
    dBx_FAST(:,:,:,n) = ((yP(n+1)-yP(n)).*(Z-zP(n))... 
        - (zP(n+1)-zP(n)).*(Y-yP(n)))...
        ./R_FAST(:,:,:,n); 
    dBx_FAST(isnan(dBx_FAST))=0; % replace nan with 0   
    
    % dBy (cross product y)            
    dBy_FAST(:,:,:,n) = ((zP(n+1)-zP(n)).*(X-xP(n))... 
        - (xP(n+1)-xP(n)).*(Z-zP(n)))...
        ./R_FAST(:,:,:,n);
    dBy_FAST(isnan(dBy_FAST))=0; % replace nan with 0 
     
    % dBz (cross product z)     
    dBz_FAST(:,:,:,n) = ((xP(n+1)-xP(n)).*(Y-yP(n))... 
    - (yP(n+1)-yP(n)).*(X-xP(n)))...
    ./R_FAST(:,:,:,n); % cross product z
    dBz_FAST(isnan(dBz_FAST))=0; % replace nan with 0 
    
    %dBz_FAST(:,:,:,n) = ((xP(n+1)-xP(n)).*(Y-yP(n))... 
    %    - (yP(n+1)-yP(n)).*(X-xP(n)))...
    %    ./R_FAST(:,:,:,n);
end

%mean(dBx_FAST,'all')
%mean(dBy_FAST,'all')
%mean(dBz_FAST,'all')

coef =  mu0*I/4/pi;
BX(:,:,:) = coef*sum(dBx_FAST,4);
BY(:,:,:) = coef*sum(dBy_FAST,4);
BZ(:,:,:) = coef*sum(dBz_FAST,4);

normB=sqrt(BX.^2+BY.^2+BZ.^2);
nBX = BX./normB;
nBY = BY./normB;
nBZ = BZ./normB;
R0=999; % need to change this 
f='fast done';

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