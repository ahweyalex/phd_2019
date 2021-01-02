
function [M12] = mutual_Inductance_BFields(B0,ANT1,TAG,I1,SEL)
%% ---------------------[INITIALIZE VARIABLES]----------------------------%
%---------------------------INPUTS LOOP1----------------------------------%
mu0   = 4*pi*1e-7;   % free space permeability <scalar> [H/m]
BX    = B0.BX;       % x-directed b-fields from loop 1
BY    = B0.BY;       % y-directed b-fields from loop 1
BZ    = B0.BZ;       % z-directed b-fields from loop 1
X     = B0.X;        % b-fields' spatial location (x-direction)(loop 1)
Y     = B0.Y;        % b-fields' spatial location (y-direction)(loop 1) 
Z     = B0.Z;        % b-fields' spatial location (z-direction)(loop 1)
NXY1  = ANT1.NXY;    % Loop 1's number of coils
N1    = ANT1.N;      % Loop 1's number of turns (z-direction)
xdel  = abs(X(1,1) - X(1,2));   % del x from loop 1
ydel  = abs(Y(1,1) - Y(2,1));   % del y from loop 1
aA     = xdel*ydel;             % Area (ds) from loop 1  
%---------------------------INPUTS TAG/LOOP2------------------------------%
xp    = TAG.xpos;   % tag's center postion in x
yp    = TAG.ypos;   % tag's center postion in y
zp    = TAG.zpos;   % tag's center postion in z
rx    = TAG.rx;     % tag's radius in x-direction
ry    = TAG.ry;     % tag's radius in y-direction
%-------------------LOCATE BFIELDS WITHIN TAG'S LOCATION------------------%
% TAG_LOC is matrix compose of 0s and 1s. The 1s indicate the tag's 
% location and 0s indicated tag's is not located. 
if(SEL=='c' || SEL=='C' || SEL=='e' || SEL=='E') % ellipse
    degrees = pi/180;
    phi     = 0*degrees; % will be replace with [a,b,g]
    [THETA,R] = cart2pol(X,Y);
    [X,Y]     = pol2cart(THETA +phi,R);
    TAG_LOC = ( ((X+xpos)./rx)^.2 + ((Y+ypos)./ry)^.2 ) <=1;
elseif(SEL=='r' || SEL=='R' || SEL=='s' || SEL=='S') % rectangle 
    degrees = pi/180;
    phi     = 0*degrees; % will be replace with [a,b,g]
    [THETA,R] = cart2pol(X,Y);
    [X,Y]     = pol2cart(THETA +phi,R);
    x1 = -ri/2;
    x2 =  ri/2;
    y1 = -ra/2;
    y2 =  ra/2;
    TAG_LOC = ( X>=x1+xpos & X<=x2+xpos & Y>=y1+ypos & Y<=y2+ypos);
end
%-----------------------COMPUTE MUTUAL INDUCTANCE-------------------------%
% find indices assoicated with normal bfields at tag/loop's location upon
% the plane
[idx]  = find(TAG_LOC)';     % indices 
% loop 1's bfields at indices associated with loop 2(tag)'s location
BF     = BZ(idx);     
% multiply loop 1 bfields by loop2's delta surface area
BFA    = BF.*dA;              
% sum all product(BF,dA) together 
sumB   = sum(sum(sum(BFA,1),2),3); 
phi_12 = abs(sumB);
[M12]  = (phi_12/I1)*N2*NXY2; % mutual inductance 
end