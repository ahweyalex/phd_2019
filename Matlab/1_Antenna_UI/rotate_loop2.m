% Alexander Moreno
% DATE: 12/28/2020
%
%------------------------------[DESCRIPTION]------------------------------%
% Rotates the spatial points of [Ny by Nx] matrices by a,b,g angles.
% Assumes Ny=Nx
% yaw is controlled by angle a
% pitch is controlled by angle b
% roll is controlled by angle g
%--------------------------[END: DESCRIPTION]-----------------------------%

%=========================================================================%
%=========================================================================%

%---------------------------[INPUT PARAMETERS]----------------------------%
%   X
%   Description: spatial points of the B-Fields along the x-coordinates 
%   Units: [T]
%   DIM: [Ny by Nx]
%
%   Y
%   Description: spatial points of the B-Fields along the y-coordinates 
%   Units: [m]
%   DIM: [Ny by Nx]     
%
%   Z
%   Description: spatial points of the B-Fields along the z-coordinates 
%   Units: [m]
%   DIM: [Ny by Nx]
%   
%   a 
%   Description: Rotates in the points along XY-plane by a degrees. The
%   user inputs the degrees.
%   Units: [deg] 
%   DIM: [1x1]
% 
%   b
%   Description: Rotates in the points along the X and Z-plane by a degrees 
%   The user inputs the degrees.
%   Units: [deg]
%   DIM: [1x1]
% 
%   g
%   Description: Rotates in the points along the Y and Z-plane by a degrees 
%   The user inputs the degrees.
%   Units: [deg] 
%   DIM: [1x1]
% 
%-------------------------[END:INPUT PARAMETERS]--------------------------%

%=========================================================================%
%=========================================================================%

%---------------------------[OUTPUT PARAMETERS]---------------------------%
%
%   RX
%   Description: spatial points of the B-Fields along the x-coordinates
%   that have  been rotated 
%   Units: [m]
%   DIM: [Ny by Nx]
%
%   RY
%   Description: spatial points of the B-Fields along the y-coordinates 
%   that have  been rotated 
%   Units: [m]
%   DIM: [Ny by Nx]     
%
%   RZ
%   Description: spatial points of the B-Fields along the z-coordinates 
%   that have  been rotated 
%   Units: [m]
%   DIM: [Ny by Nx]
%  
%-------------------------[END: OUTPUT PARAMETERS]------------------------%

function [RX,RY,RZ] = rotate_loop2(X,Y,Z,a,b,g)
%     a % yaw   (rotate in xy-plane)
%     b % pitch (z <==> x planes)
%     g % roll  (z <==> -y planes)
    % size of X/Y/Z
    [Nx,Ny] = size(X); 
% ----------------------set up 3D rotation matrix-------------------------%     
    r1 = [cosd(a)*cosd(b),...
          cosd(a)*sind(b)*sind(g)-sind(a)*cosd(g),...
          cosd(a)*sind(b)*cosd(g) + sind(a)*sind(g)];
    r2 = [sind(a)*cosd(b),...
          sind(a)*sind(b)*sind(g) + cosd(a)*cosd(g),...
          sind(a)*sind(b)*cosd(g) - cosd(a)*sind(g)];
    r3 = [sind(b),...
          cosd(b)*sind(g),...
          cosd(b)*cosd(g)];
      
    R  = [r1;r2;r3];
%---------------reshape spatial points into 1D arrays---------------------%
    X2 = reshape(X,Nx*Ny,1)';
    Y2 = reshape(Y,Nx*Ny,1)';
    Z2 = reshape(Z,Nx*Ny,1)';
    % create matrix 
    XYZ = [X2;Y2;Z2];
%---------------multiply rotation matrix with spatial points--------------%
    RXYZ = R*XYZ;
    % reshape matrices
    RX = reshape(RXYZ(1,:,:),Nx,Ny);
    RY = reshape(RXYZ(2,:,:),Nx,Ny);
    RZ = reshape(RXYZ(3,:,:),Nx,Ny);
    t = 't';
end