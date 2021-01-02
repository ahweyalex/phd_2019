
function [M12] = mutual_Inductance_BFields(MULT_IND,ANT1,TAG,I1,SEL)
%% ---------------------[INITIALIZE VARIABLES]----------------------------%
%---------------------------INPUTS LOOP1----------------------------------%
uc    = 1.256629*10^-6;         % permeability of copper 
mu0   = 4*pi*1e-7;              % free space permeability <scalar> [H/m]
u     = mu0*uc;
zn    = 1;                      % select which xy-plane on z location
BX    = squeeze(MULT_IND.BX(:,:,zn)); % x-directed b-fields from loop 1
BY    = squeeze(MULT_IND.BY(:,:,zn)); % y-directed b-fields from loop 1
BZ    = squeeze(MULT_IND.BZ(:,:,zn)); % z-directed b-fields from loop 1
X     = squeeze(MULT_IND.X(:,:,zn));  % b-fields' spatial location (x-dir)
Y     = squeeze(MULT_IND.Y(:,:,zn));  % b-fields' spatial location (y-dir)
Z     = MULT_IND.Z;                   % b-fields' spatial location (z-dir)   
NXY   = ANT1.NXY;               % Loop 1's number of coils
N     = ANT1.N;                 % Loop 1's number of turns (z-direction)
xdel  = abs(X(1,1) - X(1,2));   % del x from loop 1
ydel  = abs(Y(1,1) - Y(2,1));   % del y from loop 1
dA    = xdel*ydel;              % Area (ds) from loop 1  
%---------------------------INPUTS TAG/LOOP2------------------------------%
xp    = TAG.xpos;   % (loop 2)tag's center postion in x
yp    = TAG.ypos;   % (loop 2)tag's center postion in y
zp    = TAG.zpos;   % (loop 2)tag's center postion in z
ra    = TAG.ra;     % (loop 2)tag's radius in x-direction
ri    = TAG.ri;     % (loop 2)tag's radius in y-direction
N2    = TAG.N;      % (loop 2)tag's number turns
NXY2  = TAG.NXY;    % (loop 2)tag's number turns
ur    = TAG.ur;     % (loop 2)tag/'s ferrite dielectric
a     = TAG.a;      % yaw
b     = TAG.b;      % pitch
g     = TAG.g;      % roll
%% ---------------[SETUP LOOP2/TAG SPATIAL LOCATION]----------------------%
%-------------------LOCATE BFIELDS WITHIN TAG'S LOCATION------------------%
% TAG_LOC is matrix compose of 0s and 1s. The 1s indicate the tag's 
% location and 0s indicated tag's is not located. 
if(SEL=='c' || SEL=='C' || SEL=='e' || SEL=='E') % ellipse
    % how things are set up. whenever my ellipse is created, I have ri and
    % ra flipped (aka rx and ry).
    rx        = TAG.ra;     %
    ry        = TAG.ri;     %
    degrees   = pi/180;
    phi       = 0*degrees; % will be replace with [a,b,g]
    [THETA,R] = cart2pol(X,Y);
    [X,Y]     = pol2cart(THETA +phi,R);
    TAG_LOC   = ( ((X+xp)./rx).^2 + ((Y+yp)./ry).^2 ) <=1;
elseif(SEL=='r' || SEL=='R' || SEL=='s' || SEL=='S') % rectangle 
    degrees = pi/180;
    phi     = 0*degrees; % will be replace with [a,b,g]
    [THETA,R] = cart2pol(X,Y);
    [X,Y]     = pol2cart(THETA +phi,R);
    rx        = TAG.ri;     %
    ry        = TAG.ra;     %
    x1        = -rx/2;
    x2        =  rx/2;
    y1        = -ry/2;
    y2        =  ry/2;
    TAG_LOC   = ( X>=x1+xpos & X<=x2+xpos & Y>=y1+ypos & Y<=y2+ypos);
end
%% -------------------[COMPUTE MUTUAL INDUCTANCE]-------------------------%
% normal bfields 
Bnorm  = BZ(:,:,zn);
% find indices assoicated with normal bfields at tag/loop's location upon
% the plane
[idx]  = find(TAG_LOC)';     % indices 
% loop 1's bfields at indices associated with loop 2(tag)'s location
BF     = Bnorm(idx);     
% multiply loop 1 bfields by loop2's delta surface area
BFA    = BF.*dA;              
% sum all product(BF,dA) together 
sumB   = sum(sum(sum(BFA,1),2),3); 
phi_12 = abs(sumB);
[M12]  = (phi_12/I1)*N2*NXY2; % mutual inductance 