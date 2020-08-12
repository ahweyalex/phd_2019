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
ra     = 10e-3;
ri     = 10e-3;
W0     = ra;       
L0     = ri;        
numSeg = 200;
phi    = numSeg;
O      = 1;
Nxy    = 2;
%%                     MULTI-COILED WIRE ANTENNA                         %%  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Create the 1D arrays (Sx,Sy,Sz) that will contain the spatiral locations
% for the (elliptical or rectangular) coiled wire antenna in cartesian 
% coordinates.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Single rectangular loop, Assumes Nxy=0 and N=0 
% [Sx,Sy,Sz] = singleLoop(ra,ri,phi,O,wT);
%Multi-Coiled Elliptical Wire 
[Sx,Sy,Sz] = constrCircWire(zEnd,ra,ri,phi,N,O,wT,Nxy);
%Multi-Coiled Rectangular Wire 
%[Sx,Sy,Sz] = constrRectWire(h,W0,L0,phi,N,O,wT,Nxy); 
figure
%H=plot3(Sx,Sy,Sz,'.');
H=plot3(Sx,Sy,Sz,'-');
fontSize = 14;
xlabel('x[m]','FontWeight','bold','FontSize', fontSize); 
ylabel('y[m]','FontWeight','bold','FontSize', fontSize); 
zlabel('z[m]','FontWeight','bold','FontSize', fontSize); 
title('Wire Antenna','FontWeight','bold','FontSize', fontSize); 
grid on
%xlim([-7e-3 7e-3]); ylim([-7e-3 7e-3]);
%view(45,45);
view(45,45);
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
Nz    = 20; 
Ns    = [Nx,Ny,Nz];
xyz   = 2*ri;
xminb = -xyz; yminb = -xyz; zminb = -ri/2;    % [m]
xmaxb =  xyz; ymaxb =  xyz; zmaxb =  ri/2;  % [m]
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
%% PLOT: XY PLANE
clc;
fontSize = 14;
% checks if Nz is greater than one, chooses the middle value 
% in the case of odd number of points, round down
if(Nz>1)
    nz = floor(Nz/2);
else
    nz = 1;
end
nz = 20; % testing
% recall that B0.? is formatted as the following, where "?" is X,Y, or Z
% B0.?(ny,nx,nz), where n? represents the index to respecting "?"
% Therefore if you want to plot something in the xy-plane the following
% format is recommend to be used B0.?(:,:,nz)
XY_X     = squeeze(B0.X(:,:,nz));
XY_Y     = squeeze(B0.Y(:,:,nz));
XY_Z     = squeeze(B0.Z(:,:,nz));
Z        = zeros(Ny,Nx);
XY_BX    = squeeze(B0.BX(:,:,nz));
XY_BY    = squeeze(B0.BY(:,:,nz));
XY_BZ    = squeeze(B0.BZ(:,:,nz));
XY_normB = squeeze(normB(:,:,nz));

hold on;
figure(1)
% antenna
H=plot3(Sx,Sy,Sz,'-');
lw = 5;
set(H,'color','r'); set(H,'linewidth',lw);
% magnitude 
[M0_XY,c_XY]=contourf(XY_X,XY_Y,XY_normB);
c_XY.ContourZLevel =  XY_Z(1,1);
% quiver
Q=quiver3(XY_X,XY_Y,XY_Z, XY_BX,XY_BY,XY_BZ);
set(Q,'color','k');
xlabel('x[m]','FontWeight','bold','FontSize', fontSize); 
ylabel('y[m]','FontWeight','bold','FontSize', fontSize);
title(['XY-Plane (nz/Nz):',num2str((nz)),'/',num2str(Nz)],'FontWeight',...
    'bold','FontSize', fontSize);
hold on; grid on; axis tight;
xl = (ri)*(3/4); yl = (ra)*(3/4);
xlim([-xl xl]); ylim([-yl yl]);
view(0,90);
%contourcbar;
% saves the figure as a PNG 
saveas(gcf,'MagBFields_XYPlane.png')
%% PLOT: XZ PLANE
if(Ny>1)
    ny = floor(Ny/2);
else
    ny = 1;
end
%ny = 250; % testing
% recall that B0.? is formatted as the following, where "?" is X,Y, or Z
% B0.?(ny,nx,nz), where n? represents the index to respecting "?"
% Therefore if you want to plot something in the xy-plane the following
% format is recommend to be used B0.?(:,:,nz)
XZ_X     = squeeze(B0.X(ny,:,:));
XZ_Y     = squeeze(B0.Y(ny,:,:));
XZ_Z     = squeeze(B0.Z(ny,:,:));
Z        = zeros(Nx,Nz);
XZ_BX    = squeeze(B0.BX(ny,:,:));
XZ_BY    = squeeze(B0.BY(ny,:,:));
XZ_BZ    = squeeze(B0.BZ(ny,:,:));
XZ_normB = squeeze(normB(ny,:,:));  

hold on;
figure(2)
% antenna
H=plot3(Sx,Sy,Sz,'-');
direction = [0 0 1];
rotate(H,direction,90)
direction = [1 0 0];
rotate(H,direction,90)
lw = 5;
set(H,'color','r'); set(H,'linewidth',lw);
% mag
[M0_XZ,c_XZ]=contourf(XZ_X,XZ_Z,XZ_normB);
c_XZ.ContourZLevel =  XZ_Y(1,1);
% quiver
Q=quiver3(XZ_X,XZ_Y,Z, XZ_BX,XZ_BY,XZ_BZ);
set(Q,'color','w');
xlabel('x[m]','FontWeight','bold','FontSize', fontSize); 
ylabel('z[m]','FontWeight','bold','FontSize', fontSize);
title(['XZ-Plane (ny/Ny):',num2str((ny)),'/',num2str(Ny)],'FontWeight',...
    'bold','FontSize', fontSize);
grid on; axis tight;
xl = (ri)*(3/4); yl = (ra)*(3/4);
xlim([-xl xl]); ylim([-yl yl]);
view(0,90);
%contourcbar;
saveas(gcf,'MagBFields_XZPlane.png')
hold off;
%% PLOT: YZ PLANE
% working on
if(Nx>1)
    nx = floor(Nx/2);
else
    nx = 1;
end
%nx = 300; % testing
% recall that B0.? is formatted as the following, where "?" is X,Y, or Z
% B0.?(ny,nx,nz), where n? represents the index to respecting "?"
% Therefore if you want to plot something in the xy-plane the following
% format is recommend to be used B0.?(:,:,nz)
YZ_X     = squeeze(B0.X(:,nx,:));
YZ_Y     = squeeze(B0.Y(:,nx,:));
YZ_Z     = squeeze(B0.Z(:,nx,:));
Z        = zeros(Ny,Nz);
YZ_BX    = squeeze(B0.BX(:,nx,:));
YZ_BY    = squeeze(B0.BY(:,nx,:));
YZ_BZ    = squeeze(B0.BZ(:,nx,:));
YZ_normB = squeeze(normB(:,nx,:));  
hold all;
%figure(3)
% antenna
H=plot3(Sx-ri/2,Sy,Sz,'-');
direction = [0 0 1];
rotate(H,direction,180)
direction = [1 0 0];
rotate(H,direction,90)
lw = 5;
set(H,'color','r'); set(H,'linewidth',lw);
% mag
[M0_YZ,c_YZ]=contourf(YZ_Y,YZ_Z,YZ_normB);
c_YZ.ContourZLevel = YZ_X(1,1);
% quiver
Q=quiver3(YZ_X,YZ_Y,YZ_Z, YZ_BX,YZ_BY,YZ_BZ);
xlabel('y[m]','FontWeight','bold','FontSize', fontSize); 
ylabel('z[m]','FontWeight','bold','FontSize', fontSize);
title(['YZ-Plane (nx/Nx):',num2str((nx)),'/',num2str(Nx)],'FontWeight',...
    'bold','FontSize', fontSize);
view(0,90); grid on; axis tight;
contourcbar;
saveas(gcf,'MagBFields_YZPlane.png')
hold off;
%%                         EXPORT CSV FILES                              %%  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% A
% Description: Matrix that contains the 1D arrays of x,y, and z points of
% the (multi)coiled wire antenna
% SIZE: size(Sx) by 3 UNITS: each index is [m]
%
% antenna
aSize = numel(Sx); 
aXYZ = {'x[m]','y[m]','z[m]'};
for n=1:aSize
    aXYZ{n+1,1} = Sx(n);
    aXYZ{n+1,2} = Sy(n);
    aXYZ{n+1,3} = Sz(n);
end
writecell(aXYZ,'antenna.csv');
%  B-Fields
bSize = Nx*Ny*Nz;
Xcsv = reshape(B0.X,bSize,1);
Ycsv = reshape(B0.Y,bSize,1);
Zcsv = reshape(B0.Z,bSize,1);
BXcsv = reshape(B0.BX,bSize,1);
BYcsv = reshape(B0.BY,bSize,1);
BZcsv = reshape(B0.BZ,bSize,1);
BFC   = {'x[m]','y[m]','z[m]','BX','BY','BZ'};
BFA   = num2cell([Xcsv,Ycsv,Zcsv,BXcsv,BYcsv,BZcsv]);
BF    = [BFC;BFA];
writecell(aXYZ,'BFields_AllPoints.csv');
%
% XY
XYN       = Nx*Ny;
XY_Xr     = reshape(XY_X,XYN,1);
XY_Yr     = reshape(XY_Y,XYN,1);
XY_Zr     = reshape(XY_Z,XYN,1);
XY_normBr = reshape(XY_normB,XYN,1); 
XYC       = {'x[m]','y[m]','|B|'};
XYBF      = num2cell([XY_Xr,XY_Zr,XY_normBr]);
BF        = [XYC;XYBF];
writecell(BF,'Magnitude_BFields_XY.csv');
% XZ
XZN       = Nx*Nz;
XZ_Xr     = reshape(XZ_X,XZN,1);
XZ_Yr     = reshape(XZ_Y,XZN,1);
XZ_Zr     = reshape(XZ_Z,XZN,1);
XZ_normBr = reshape(XZ_normB,XZN,1); 
XZC       = {'x[m]','z[m]','|B|'};
XZBF      = num2cell([XZ_Xr,XZ_Zr,XZ_normBr]);
BF        = [XZC;XZBF];
writecell(BF,'Magnitude_BFields_XZ.csv');
% YZ
YZN       = Nx*Nz;
YZ_Xr     = reshape(YZ_X,YZN,1);
YZ_Yr     = reshape(YZ_Y,YZN,1);
YZ_Zr     = reshape(YZ_Z,YZN,1);
YZ_normBr = reshape(YZ_normB,YZN,1); 
YZC       = {'y[m]','z[m]','|B|'};
YZBF      = num2cell([YZ_Xr,YZ_Zr,YZ_normBr]);
BF        = [YZC;YZBF];
writecell(BF,'Magnitude_BFields_YZ.csv');