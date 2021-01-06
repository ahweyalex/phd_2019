
function [M12] = mutual_Inductance_BFields(MULT_IND,ANT1,TAG,I1,SEL,rotM)
%% ---------------------[INITIALIZE VARIABLES]----------------------------%
%---------------------------INPUTS LOOP1----------------------------------%
uc    = 1.256629*10^-6;         % permeability of copper 
mu0   = 4*pi*1e-7;              % free space permeability <scalar> [H/m]
u     = mu0*uc;
zn    = 1;                      % select which xy-plane on z location
BX    = squeeze(MULT_IND.BX(:,:,zn)); % x-directed b-fields from loop 1
BY    = squeeze(MULT_IND.BY(:,:,zn)); % y-directed b-fields from loop 1
BZ    = squeeze(MULT_IND.BZ(:,:,zn)); % z-directed b-fields from loop 1
X0    = squeeze(MULT_IND.X(:,:,zn));  % b-fields' spatial location (x-dir)
Y0    = squeeze(MULT_IND.Y(:,:,zn));  % b-fields' spatial location (y-dir)
Z0    = squeeze(MULT_IND.Z(:,:,zn));  % b-fields' spatial location (z-dir)   
NXY   = ANT1.NXY;               % Loop 1's number of coils
N     = ANT1.N;                 % Loop 1's number of turns (z-direction)
%---------------------------INPUTS TAG/LOOP2------------------------------%
xp    = TAG.xpos;   % (loop 2)tag's center postion in x
yp    = TAG.ypos;   % (loop 2)tag's center postion in y
zp    = TAG.zpos;   % (loop 2)tag's center postion in z
ra    = TAG.ra;     % (loop 2)tag's radius in x-direction
ri    = TAG.ri;     % (loop 2)tag's radius in y-direction
N2    = TAG.N;      % (loop 2)tag's number turns
NXY2  = TAG.NXY;    % (loop 2)tag's number turns
ur    = TAG.ur;     % (loop 2)tag/'s ferrite dielectric
a     = rotM.a;      % yaw
b     = rotM.b;      % pitch
g     = rotM.g;      % roll
tx = 0;
ty = 0;
tz = 1;
[tx1,ty1,tz1] = rotate_loop2(tx,ty,tz,a,b,g);
normV = [tx1,ty1,tz1];
t ='t';
%-------------------------------DELTA AREA--------------------------------%
if(abs(normV)==[0,0,1])
    % no change, Bnorm is in z-direction
    xdel  = abs(X0(1,1) - X0(1,2)); % del x from loop 1
    ydel  = abs(Y0(1,1) - Y0(2,1)); % del y from loop 1
    dA    = xdel*ydel;              % Area (ds) from loop 1 
    PN    = 'XY';                   % Z0-values are all 0
    P1    = X0;                     % Plane 1
    P2    = Y0;                     % Plane 2
    p1    = xp;                     % shift tag placement by x-direction
    p2    = yp;                     % shift tag placement by y-direction
    nV    = [0,0,1];                % normal vector
elseif(abs(normV)==[0, 1, 0])
    % Bnorm is in y-direction
    xdel  = abs(X0(1,1) - X0(1,2)); % del x from loop 1
    zdel  = abs(Z0(1,1) - Z0(2,1)); % del y from loop 1
    dA    = xdel*zdel;              % Area (ds) from loop 1      
    PN    = 'XZ';                   % Y0-values are all 0
    P1    = X0;                     % Plane 1
    P2    = Z0;                     % Plane 2
    p1    = xp;                     % shift tag placement by x-direction
    p2    = zp;                     % shift tag placement by z-direction
    nV    = [1,0,0];                % normal vector
elseif(abs(normV)==[1, 0, 0])
    ydel  = abs(Y0(1,1) - Y0(1,2)); % del x from loop 1
    zdel  = abs(Z0(1,1) - Z0(2,1)); % del y from loop 1
    dA    = ydel*zdel;              % Area (ds) from loop 1 
    PN    = 'YZ';                   % X0-values are all 0
    P1    = Y0;                     % Plane 1
    P2    = Z0;                     % Plane 2
    p1    = yp;                     % shift tag placement by y-direction
    p2    = zp;                     % shift tag placement by z-direction
    nV    = [0,1,0];                % normal vector
else
    % Bnorm is in mix (x,y,z)-direction
    xdel  = abs(X0(1,1) - X0(1,2)); % del x from loop 1
    ydel  = abs(Y0(1,1) - Y0(2,1)); % del y from loop 1
    dA    = xdel*ydel;              % Area (ds) from loop 1   
    PN    = 'XYZ';        
    P1    = X0;                     % Plane 1
    P2    = Y0;                     % Plane 2
end
 
%% ---------------[SETUP LOOP2/TAG SPATIAL LOCATION]----------------------%
%-------------------LOCATE BFIELDS WITHIN TAG'S LOCATION------------------%
% TAG_LOC is matrix compose of 0s and 1s. The 1s indicate the tag's 
% location and 0s indicated tag's is not located. 
if(SEL=='c' || SEL=='C' || SEL=='e' || SEL=='E') % ellipse
    % how things are set up. whenever my ellipse is created, I have ri and
    % ra flipped (aka rx and ry).
    %rx        = TAG.ra;     %
    %ry        = TAG.ri;     %
    
    rx        = TAG.ri;     %
    ry        = TAG.ra;     %
    degrees   = pi/180;
    phi       = 0*degrees; % will be replace with [a,b,g]
    [THETA,R] = cart2pol(P1,P2);
    [X,Y]     = pol2cart(THETA +phi,R);
    TAG_LOC   = ( ((X+p1)./rx).^2 + ((Y+p2)./ry).^2 ) <=1;

 %=====================================================================%
    Nx=1000; Ny=1000; Nz=2;
    ri1     = 15e-3;
    wT      = 0.2546e-3;    % 30AWG wire gauge <scalar> [m]
    h       = wT*0.35;      % height of structure
    zEnd    = N2*2*pi*h; 
    zpos    = 4*zEnd + ri1/2;
    b2 = 2*zpos;
    xminb12 = -1.01*b2;   % lower x-bound
    yminb12 = -1.01*b2;   % lower y-bound
    zminb12 = zpos;      % lower z-bound (mutual-inductance)
    % upper bounds 
    xmaxb12 = 1.01*b2;    % maximum x-bound
    ymaxb12 = 1.01*b2;    % maximum y-bound
    zmaxb12 = zpos;    % maximum y-bound
    x_M = linspace(xminb12, xmaxb12, Nx);
    y_M = linspace(yminb12, ymaxb12, Ny);
    z_M = linspace(zminb12, zmaxb12, Nz);
    % create multi-dim arrays with the 1D arrays
    [X12,Y12,Z12]=meshgrid(x_M,y_M,z_M);
    imagesc(x_M,y_M,TAG_LOC);
 %=====================================================================%
elseif(SEL=='r' || SEL=='R' || SEL=='s' || SEL=='S') % rectangle 
    degrees   = pi/180;
    phi       = 0*degrees; % will be replace with [a,b,g]
    %[THETA,R] = cart2pol(X,Y);
    [THETA,R] = cart2pol(P1,P2);
    [X,Y]     = pol2cart(THETA +phi,R);
    rx        = TAG.ri;     %
    ry        = TAG.ra;     %
    x1        = -rx/2;
    x2        =  rx/2;
    y1        = -ry/2;
    y2        =  ry/2;  
    TAG_LOC   = ( X>=x1+p1 & X<=x2+p1 & Y>=y1+p2 & Y<=y2+p2);
end
%% -------------------[COMPUTE MUTUAL INDUCTANCE]-------------------------%
% normal bfields 
BnormX  = BX(:,:,zn);
BnormY  = BY(:,:,zn);
BnormZ  = BZ(:,:,zn);
% find indices assoicated with normal bfields at tag/loop's location upon
% the plane
[idx] = find(TAG_LOC)'; % indices 
% loop 1's bfields at indices associated with loop 2(tag)'s location
BFx = BnormX(idx);     
BFy = BnormY(idx);     
BFz = BnormZ(idx);     
% multiply loop 1 bfields by loop2's delta surface area
BFAx = BFx.*dA;
BFAy = BFy.*dA;
BFAz = BFz.*dA;
% sum all product(BF,dA) together 
sumBx   = sum(sum(sum(BFAx,1),2),3); 
sumBy   = sum(sum(sum(BFAy,1),2),3); 
sumBz   = sum(sum(sum(BFAz,1),2),3); 
phi_12  = [sumBx,sumBy,sumBz];
[M12(1)]  = abs(dot(phi_12,normV)*N2*NXY2*(1/I1)); % mutual inductance 
[M12(2)]  = abs(dot([0,0,sumBz],normV)*N2*NXY2*(1/I1)); % mutual inductance 
[M12(3)]  = abs(dot(phi_12,[1,0,0])*N2*NXY2*(1/I1)); % mutual inductance
[M12(4)]  = abs(dot(phi_12,nV)*N2*NXY2*(1/I1)); % mutual inductance
%[M12]  = (phi_12/I1)*N2*NXY2; % mutual inductance 