% Alexander Moreno
% DATE: 08-20-2020
% DESCRIPTION: 
% (0) This is the main Matlab script to edit and run the overall code
%
% (1) Creates a points from the user in cartesian coordinates to be used 
% for a  multi-coiled (elliptical or rectangular) wire antenna. These 
% points are saved as three 1D arrays. 
%
% (2) User inputs desirable spatial (upper and lower) bounds and resolution
% in cartesian coordinates. The B-Fields (magnetic fields) will be
% computed at those spatiral locations from the source (the multi-coiled
% wire antenna from (1).
% (3) Output CSV files. 
% (3a)Spatiral locations (in cartesian coordinates) of the  multi-coiled 
% (elliptical or rectangular) wire antenna. 
% (3b) Spatiral locations (in cartesian coordinates) of the B-Fields 
% (magnetic fields) and vectors of the B-Fields (magnetic fields).
% (3b_a) Total of 4 output files. 
%   - All spatiral locations and assoicated B-Fields
%   - XY-plane and assoicated B-Fields
%   - XZ-plane and assoicated B-Fields
%   - YZ-plane and assoicated B-Fields
%
% (4) Creates and saves three figures that is exported. The figures contain
% the following cutplanes: XY-plane, XZ-plane, and YZ-plane. The figure
% will contain the (colormap) magintude of the B-Fields (magnetic fields)
% and (quiver plot) vector of the B-Fields (magnetic fields).
%
% REQUIRED MATLAB FILES:
%
%
%
%
%
%
%

%%                         INPUT PARAMETERS                              %% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% USER can change these values towards their desirable values for thier 
% wire antenna
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% [INPUT PARAMETERS]
%
% I0
% Description: Current along the wire
% UNITS:[A] ARRAY: 1x1
%
% wT 
% Description: Wire's guage
% UNITS:[m] ARRAY: 1x1
%
% h 
% Description: Estimated height of the multi-coil wire antenna
% UNITS:[m] ARRAY: 1x1
%
% N
% Description: Number of turns along the z-direction 
% UNITS: N/A % should be integer 
% ARRAY: 1x1
%
% zEnd
% Description: Estimated last value along the z-direction for the wire 
% coiled
% UNITS:N/A or [m] ARRAY:1x1
%
% ra
% Description: Elliptical's "width" of the inner most coil
% UNITS:[m] ARRAY:1x1
%
% ri
% Description: Elliptical's "length" of the inner most coil
% UNITS:[m] ARRAY:1x1
%
% W0
% Description: Width of the inner most coil
% UNITS:[m] ARRAY:1x1
%
% L0
% Description: Length of the inner most coil
% UNITS:[m] ARRAY:1x1
%
% numSeg
% Description: Total number of points along the current path for a 
% single coil (i.e. the coiled wire antenna). For example: a N=2 Nxy=2 
% numSeg=200 coil will result in 200 points when Nxy=1 (inner coil) and
% another 200 points when Nxy=2 (outer coil) resutling in a total of 400
% points for the structure. This does not include the points for the feed
% lines. Units: N/A MUST BE integer
% UNITS:N/A or [m] ARRAY:1x1
%
% O
% Description: Stating orientation for the most innner coiled 
% 1 is CW (Clockwise) otherwise CCW (Counter Clockwise). For example: a N=2
% Nxy=2 O=1 will result with the inner coil (Nxy=1) to start CW and outer
% coil (Nxy=2) to be CCW
% UNITS:N/A or [m] ARRAY:1x1 VALUE: 0 or 1
%
% Nxy
% Description: Number of coils (number of turns) along the xy-plane
% UNITS: integer ARRAY:1x1 
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all; close all; clc;
% Construct and defined current 
% units: [A]
global I0; I0 = struct('I',1); 

wT     = 0.2546e-3; % 30AWG 
h      = wT*0.35;  
N      = 2;
zEnd   = h*N*2*pi;
ra     = 2e-3;
ri     = 3e-3;
W0     = ra;       
L0     = ri;        
numSeg = 200;
phi    = numSeg;
O      = 1;
Nxy    = 3;
%%                     MULTI-COILED WIRE ANTENNA                         %%  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Create the 1D arrays (Sx,Sy,Sz) that will contain the spatiral locations
% for the (elliptical or rectangular) coiled wire antenna in cartesian 
% coordinates.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Single rectangular loop, Assumes Nxy=0 and N=0 
% [Sx,Sy,Sz] = singleLoop(ra,ri,phi,O,wT);
%Multi-Coiled Elliptical Wire 
%[Sx,Sy,Sz] = constrCircWire(zEnd,ra,ri,phi,N,O,wT,Nxy);
%Multi-Coiled Rectangular Wire 
[Sx,Sy,Sz] = constrRectWire(h,W0,L0,phi,N,O,wT,Nxy); 
%%
figure
%H=plot3(Sx,Sy,Sz,'.');
H=plot3(Sx,Sy,Sz,'O');
fontSize = 14;
xlabel('x[m]','FontWeight','bold','FontSize', fontSize); 
ylabel('y[m]','FontWeight','bold','FontSize', fontSize); 
zlabel('z[m]','FontWeight','bold','FontSize', fontSize); 
title('Wire Antenna','FontWeight','bold','FontSize', fontSize); 
grid on
%xlim([-7e-3 7e-3]); ylim([-7e-3 7e-3]);
%view(45,45);
view(0,90)
%%                     INPUT PARAMETERS FOR BFIELDS                      %%  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% USER can change these values towards their desirable spatial locations to
% compute B-Fields
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% [INPUT PARAMETERS]
%
% Nx
% Description: The number of points along the x-direction (spatial
% location)
% UNITS: N/A ARRAY: 1x1  VALUE: integer
%
% Ny
% Description: The number of points along the y-direction (spatial
% location)
% UNITS: N/A ARRAY: 1x1  VALUE: integer
%
% Nz
% Description: The number of points along the z-direction (spatial
% location)
% UNITS: N/A ARRAY: 1x1  VALUE: integer
%
% xminb
% Description: The minimal(lower) bound in the x-direction (spatial
% location
% UNITS: [m] ARRAY: 1x1
%
% yminb
% Description: The minimal(lower) bound in the y-direction (spatial
% location
% UNITS: [m] ARRAY: 1x1
%
% zminb
% Description: The minimal(lower) bound in the z-direction (spatial 
% location
% UNITS: [m] ARRAY: 1x1
%
% xmaxb
% Description: The max(upper) bound in the x-direction (spatial location)
% UNITS: [m] ARRAY: 1x1
%
% ymaxb
% Description: The max(upper) bound in the x-direction (spatial location)
% UNITS: [m] ARRAY: 1x1
%
% zmaxb
% Description: The max(upper) bound in the x-direction (spatial location)
% UNITS: [m] ARRAY: 1x1
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Nx    = 100; 
Ny    = 100; 
Nz    = 10; 
Ns    = [Nx,Ny,Nz];
if (ri>=ra)
    xyz = 2*ri;
elseif (ra>=ri)
    xyz = 2*ra;
end
xminb = -xyz; yminb = -xyz; zminb = -zEnd/4;   % [m]
xmaxb =  xyz; ymaxb =  xyz; zmaxb = zEnd*1.2;  % [m]
bBox  = [xminb,yminb,zminb; xmaxb,ymaxb,zmaxb];
%%                         COMPUTE BFIELDS                               %%  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Computes the B-Fields given the user inputs and wire antenna
% 1) CalcB_FAST 
%   PRO: Reduces the time to compute the B-Fields 
%   CON: Requires a lot amount of RAM, more likely to reach PC limits
%
% 2) CalcB_SLOW
%   PRO: Requires a little amount of RAM, less likely to reach PC limits
%   CON: Increases the time to compute the B-Fields 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% [OUTPUT PARAMETERS]
%
% bX
% Description: Spatial x-points for the B-Fields
% UNITS: [m] ARRAY: Ny by Nx by Nz
%
% bY
% Description: Spatial y-points for the B-Fields
% UNITS: [m] ARRAY: Ny by Nx by Nz
%
% bZ
% Description: Spatial z-points for the B-Fields
% UNITS: [m] ARRAY: Ny by Nx by Nz
%
% BX
% Description: x-component of the vector B-Fields
% UNITS: [T] ARRAY: Ny by Nx by Nz
%
% BY
% Description: y-component of the vector B-Fields
% UNITS: [T] ARRAY: Ny by Nx by Nz
%
% BZ
% Description: z-component of the vector B-Fields
% UNITS: [T] ARRAY: Ny by Nx by Nz
%
% normB
% Description: magnitude of the B-Fields 
% UNITS: N/A ARRAY: Ny by Nx by Nz
%
% R
% Description: Resistance of multi-coil wire antenna
% UNITS: [Ohms] ARRAY: 1x1
% *** R value is currently not completed ***
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[bX,bY,bZ, BX,BY,BZ, normB,R] = ...
    CalcB_FAST(I0.I,Sx,Sy,Sz,bBox,Ns);

normB = sqrt(BX.^2+BY.^2+BZ.^2);
nBX   = BX./normB;
nBY   = BY./normB;
nBZ   = BZ./normB;
B0 = struct('BX',BX,'BY',BY,'BZ',BZ,'X',bX,'Y',bY,'Z',bZ);
%[bX,bY,bZ, BX,BY,BZ, normB,R] = ...
%    CalcB_SLOW(I0.I,Sx,Sy,Sz,bBox,Ns);  

%%                             PLOTS                                     %%  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ------------------- WRITE: BFIELDS (XY-PLANE) ------------------------- %
% checks if Nz is greater than one, chooses the middle value 
% in the case of odd number of points, round down
if(Nz>1)
    nz = floor(Nz/2)+1;
else
    nz = 1;
end
% -------------------- PLOT: BFIELDS (XZ-PLANE) ------------------------- %
% -------------------- PLOT: BFIELDS (YZ-PLANE) ------------------------- %
nx = 25;
ny = 25;
nz = 25;

plot_BF_Ant(Sx,Sy,Sz,B0.X,B0.Y,B0.Z,B0.BX,B0.BY,B0.BZ,nx,ny,nz)

%%                         EXPORT CSV FILES                              %%  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% A
% Description: Matrix that contains the 1D arrays of x,y, and z points of
% the (multi)coiled wire antenna
% SIZE: size(Sx) by 3 UNITS: each index is [m]
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
ALL = 1;
%export_BF_Ant(Sx,Sy,Sz,B0.X,B0.Y,B0.Z,B0.BX,B0.BY,B0.BZ,nx,ny,nz, ALL);

%%                         SELF-INDUCTANCE                               %%  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION: Computes the self-inductance of an ellipse or rectangle 
% plane using b-fields normal to that plane 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% def:
% 
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
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% [OUT PARAMETERS]
%
% L11
% Description: Self-indutance from the BFields provided from the user. 
% UNITS: [H]  ARRAY: 1x1 TYPE: double 
%
%G     = 'e' % ellipse/circle
G     = 'r'; % rectanlge/square
nz    = 1;
X     = squeeze(B0.X(:,:,nz));
Y     = squeeze(B0.Y(:,:,nz));
Z     = squeeze(B0.Z(:,:,nz));
BX    = squeeze(B0.BX(:,:,nz));
BY    = squeeze(B0.BY(:,:,nz));
BZ    = squeeze(B0.BZ(:,:,nz));
[L11] = selfInductance_BFields(ri,ra,I0.I,X,Y,BZ,G);