% Alexander Moreno
% DATE: 01-02-2020
% v2.0
% DESCRIPTION: Computes the self-inductance of an ellipse or rectangle 
% plane using b-fields normal to that plane 
%
%%                         INPUT PARAMETERS                              %% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DEFS:
% Nx: the resolution size of the "X-Plane" (Plane 1) value: integer 
% Ny: the resolution size of the "Y-Plane" (Plane 2) value: integer 
% bfields: magnetic fields units:[T] 
%
% [INPUT PARAMETERS]
%
% ri
% Description: the inner most coil's radius along the x-direction,
% rectangle's width (along x-direction)
% UNITS:N/A ARRAY: 1x1 VALUE: INT
%
%
% ra
% Description: the inner most coil's radius along the y-direction,
% rectangle's length (along y-direction)
% UNITS:N/A ARRAY: 1x1 VALUE: INT
%
%
% I
% Description: Current
% UNITS: [A]  ARRAY: 1 by 1
%
%
% X
% Description: "X-Plane" (Plane 1) is matrix that is a result of Matlab's 
% meshgrid function between x and y, where x (Nx by 1) and y (Ny by 1) 
% 1D arrays 
% UNITS: [m]  ARRAY: Ny by Nx
%
%
% Y
% Description: "Y-Plane" (Plane 2) is matrix that is a result of Matlab's 
% meshgrid function  between x and y, where x (Nx by 1) and y (Ny by 1) 
% 1D arrays 
% UNITS: [m]  ARRAY: Ny by Nx
%
%
% BFnorm
% Description: the b-fields vector(s) normal to the "X-Plane" (Plane 1) and 
% "Y-Plane"(Plane 2) planes of interests 
% UNITS: [T]  ARRAY: Ny by Nx
%
%
% G
% Description: Choosing which structure of the inner most coil. The options
% are Ellipse, Circle, Rectangle, Square 
% UNITS: [T]  ARRAY: 1x1 TYPE: String 
% VALUES: ellipse/circle: 'e','E','c','C' or
%         rectangle/square:'R','r','s','S'
%
%%                          OUT PARAMETERS                              %% 
% [OUT PARAMETERS]
%
% L11
% Description: Self-indutance from the BFields provided from the user. 
% UNITS: [H]  ARRAY: 1x1 TYPE: double 
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function [L11] = self_Inductance_BFields(wT,ri,ra,I,X,Y,BFnorm,N1,N,Nxy,G)
function [L11] = self_Inductance_BFields(SELF_IND,ANT1,I1,SEL)
%% ---------------------[INITIALIZE VARIABLES]----------------------------%
%---------------------------INPUTS LOOP1----------------------------------%
uc    = 1.256629*10^-6;         % permeability of copper 
mu0   = 4*pi*1e-7;              % free space permeability <scalar> [H/m]
u     = mu0*uc;
zn    = 1;                      % select which xy-plane on z location
BX    = squeeze(SELF_IND.BX(:,:,zn)); % x-directed b-fields from loop 1
BY    = squeeze(SELF_IND.BY(:,:,zn)); % y-directed b-fields from loop 1
BZ    = squeeze(SELF_IND.BZ(:,:,zn)); % z-directed b-fields from loop 1
X     = squeeze(SELF_IND.X(:,:,zn));  % b-fields' spatial location (x-dir)
Y     = squeeze(SELF_IND.Y(:,:,zn));  % b-fields' spatial location (y-dir)
Z     = SELF_IND.Z;                   % b-fields' spatial location (z-dir)   
NXY   = ANT1.NXY;               % Loop 1's number of coils
N     = ANT1.N;                 % Loop 1's number of turns (z-direction)
xdel  = abs(X(1,1) - X(1,2));   % del x from loop 1
ydel  = abs(Y(1,1) - Y(2,1));   % del y from loop 1
dA    = xdel*ydel;              % Area (ds) from loop 1  
%% -----------------[SETUP LOOP1 SPATIAL LOCATION]------------------------%
if(SEL=='c' || SEL=='C' || SEL=='e' || SEL=='E') % ellipse
    % how things are set up. whenever my ellipse is created, I have ri and
    % ra flipped (aka rx and ry).
    rx      = ANT1.ra;     %
    ry      = ANT1.ri;     %
    ANT_LOC = ( (X./rx).^2 + (Y./ry).^2 ) <=1;
elseif(SEL=='r' || SEL=='R' || SEL=='s' || SEL=='S') % rectangle
    rx      = ANT1.ri;     %
    ry      = ANT1.ra;     %
    x1      = -rx/2;
    x2      =  rx/2;
    y1      = -ry/2;
    y2      =  ry/2;
    ANT_LOC = ( X>=x1 & X<=x2 & Y>=y1 & Y<=y2);
end
%% -------------------------[SELF-INDUCTANCE]-----------------------------%
% normal bfields 
Bnorm  = BZ(:,:,zn);
% find indices assoicated with normal bfields at tag/loop's location upon
% the plane
[idx]  = find(ANT_LOC)';     % indices 
% loop's bfields at indices associated with loop 1's location
BF     = Bnorm(idx);     
% multiply loop's bfields by delta surface area
BFA    = BF.*dA;              
% sum all product(BF,dA) together 
sumB   = sum(sum(sum(BFA,1),2),3); 
phi_11 = abs(sumB);
[L11]  = (phi_11/I1)*N*NXY; % self inductance 
