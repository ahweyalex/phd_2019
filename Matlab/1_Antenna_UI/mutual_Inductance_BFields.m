
function M12 = mutual_Inductance_BFields(B0,ANT1,TAG,I2,SEL)
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
A     = xdel*ydel;              % Area (ds) from loop 1  
%---------------------------INPUTS TAG/LOOP2------------------------------%
xp    = TAG.xpos;
yp    = TAG.ypos;
zp    = TAG.zpos;
rx    = TAG.rx;
ry    = TAG.ry;
%-------------------locate bfields within location of tag-----------------%
if(SEL=='c')
    % E is matrix compose of 0s and 1s. The 1s indicate the tag's location
    % and 0s indicated tag's is not located. 
    E = ( ((X+xpos)./rx)^.2 + ((Y+ypos)./ry)^.2 ) <=1;
elseif(SEL=='r')
    degrees = pi/180;
    phi     = 0*degrees; % will be replace with [a,b,g]
    [THETA,R] = cart2pol(X,Y);
    [X,Y]     = pol2cart(THETA +phi,R);
    x1 = -ri/2;
    x2 =  ri/2;
    y1 = -ra/2;
    y2 =  ra/2;
    R = ( X>=x1+xpos & X<=x2+xpos & Y>=y1+ypos & Y<=y2+ypos);
end



end