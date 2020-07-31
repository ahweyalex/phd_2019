%% inductance
%BO.Var(Ny:Nx:Nz)
% (Ny:Nx:Nz)
clc;
nn=1;
u0 = 4*pi*10^-7;        % Permeability of free space
uc = 1.256629*10^-6;    % Permeability of copper 
u  = u0*uc;
%si=2; sf=99;    % 100 (less than)
%si=1; sf=100;   % 100 (less/= than)
si=2; sf=99;     % 100 (one less)

%si=2; sf=199;   % 200 (less than)
%si=1; sf=200;   % 200 (less/= than)
%si=2; sf=199;   % 200 (one less)

%si=3; sf=398;   % 400 (less than)
%si=2; sf=399;   % 400 (less/= than)
%si=2; sf=399;  % 400 (one less)

%si=4; sf=497;   % 500 (less than)
%si=3; sf=498;   % 500 (less/= than)
%si=2; sf=499;   % 500 (one less) 

%si=4; sf=597;   % 600 (less than)
%si=3; sf=598;   % 600 (less/= than)
%si=2; sf=599;   % 600 (one less)

%si=5; sf=696;   % 700 (less than)
%si=4; sf=697;   % 700 (less than)
%si=2; sf=699;   % 700 (one less)

%si=5; sf=796;   % 800 (less than)
%si=4; sf=797;   % 800 (less/= than)
%si=2; sf=799;   % 800 (one less)

%si=6; sf=995;   % 1000 (less than)
%si=5; sf=996;   % 1000 (less/= than)
%si=2; sf=999;   % 1000 (one less)

%si=9; sf=1493;  % 1500 (less than)
%si=8; sf=1494;  % 1500 (less/= than)
%si=2; sf=1499; % 1500 (one less)

%si=11; sf=1990; % 2000 (less than)
%si=10; sf=1991; % 2000 (less/= than)
%si=2; sf=1999; % 200 (one less)

%si=14; sf=2487; % 2500 (less than)
%si=13; sf=2488; % 2500 (less/= than)
%si=2; sf=2499; %2500 (one less)

%si=16; sf=2985; % 3000 (less than)
%si=15; sf=2984; % 3000 (less/= than)
%si=2; sf=2999; % 3000 (one less)

%si=21; sf=3980; % 4000 (less than)
%si=20; sf=3981; % 4000 (less/= than)
%si=2; sf=3999; % 4000 (one less)

L11 = 0;
NNN = 1;
%for nn=1:1:NNN
for n=NNN:NNN
    I0.I = 1;
    %si=34; sf=67;
    L11 = 0;
    X2    = squeeze(B0.X(:,:,nn));
    Y2    = squeeze(B0.Y(:,:,nn));
    Z2    = squeeze(B0.Z(:,:,nn));
    BZ    = squeeze(B0.BZ(:,:,nn));
    X3    = X2(si:sf,si:sf);    
    Y3    = Y2(si:sf,si:sf);
    Z3    = Z2(si:sf,si:sf);
    BZ2   = BZ(si:sf,si:sf);
    xdel  = X3(1,1) - X3(1,2);          % del x
    ydel  = Y3(1,1) - Y3(2,1);          % del y
    A     = xdel*ydel;           % area (ds)
    bz    = BZ2.*A; 
    sumB  = sum(sum(bz,1),2);    % sum of Bz
    phi11 = sumB;                % phi_11
    L11   = phi11/I0.I + L11;        % self ind
    L11
%{
    FX2    = squeeze(FASTB0.X(:,:,nn));
    FY2    = squeeze(FASTB0.Y(:,:,nn));
    FZ2    = squeeze(FASTB0.Z(:,:,nn));
    FBZ    = squeeze(FASTB0.BZ(:,:,nn));
    SX2    = squeeze(SLOWB0.X(:,:,nn));
    SY2    = squeeze(SLOWB0.Y(:,:,nn));
    SZ2    = squeeze(SLOWB0.Z(:,:,nn));
    SBZ    = squeeze(SLOWB0.BZ(:,:,nn));
    
    FX3    = FX2(si:sf,si:sf);
    FY3    = FY2(si:sf,si:sf);
    FZ3    = FZ2(si:sf,si:sf);
    FBZ2   = FBZ(si:sf,si:sf);

    SX3    = SX2(si:sf,si:sf);
    SY3    = SY2(si:sf,si:sf);
    SZ3    = SZ2(si:sf,si:sf);
    SBZ2   = SBZ(si:sf,si:sf);

    xdel  = SX3(1,1) - SX3(1,2);          % del x
    ydel  = SY3(1,1) - SY3(2,1);          % del y
    A     = xdel*ydel;           % area (ds)
    %bz    = BZ2.*A;
    sbz    = SBZ2.*A;
    fbz    = FBZ2.*A;
    
    fsumB  = sum(sum(fbz,1),2);    % sum of Bz
    fphi11 = fsumB;                % phi_11
    fL11   = fphi11/I0.I + L11;        % self ind
    fL11    
    ssumB  = sum(sum(sbz,1),2);    % sum of Bz
    sphi11 = ssumB;                % phi_11
    sL11   = sphi11/I0.I + L11;        % self ind
    sL11
%}
end