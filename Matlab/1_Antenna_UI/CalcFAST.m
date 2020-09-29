% Alexander Moreno
% 09-24-2020
% 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION:
% A)
% 1) Computes B-Fields for a given current path. 
% 2) Calucates B-Fields from antenna structure
% 3) Saves the Bx,By,Bz corresponding to each cartesian points (x,y,z)
%=========================================================================%
%                       [[Input Parameters]]
%   I
%   Description: Current through the wire 
%   Units: [A] <scalar>
% ------------------------------------------------------------------------%
%   xS
%   Description: Points in the zx-plane where the structure
%   Units: [m] <1D array>
% ------------------------------------------------------------------------%
%   yS
%   Description: Points in the y-plane where the structure
%   Units: [m] <1D array>
% ------------------------------------------------------------------------%
%   zS
%   Description: Points in the z-plane where the structure
%   Units: [m] <1D array>
% ------------------------------------------------------------------------%
%   bBox
%   Description: Boundary box, the space in which the B-Fields will be
%   computed. The boundary box's values are the distance away from the 
%   furthest point of the arbitrary antenna wire structure.
%   Units: [m] <1x3 vector>
%   Example: 
%   bBox = [xdist, ydist, zdist]
% ------------------------------------------------------------------------%
%   Ns
%   Description: Number of segments in space in which the B-Fields will be
%   computed. [Nx,Ny,Nz]
%   Units: [none] <1by3>
%=========================================================================%
%                       [[Ouput Parameters]]
%   X
%   Description: spatial points of the B-Fields along the x-coordinates 
%   Units: [T]
%   DIM: [Ny by Nx by Nz]
% ------------------------------------------------------------------------%
%   Y
%   Description: spatial points of the B-Fields along the y-coordinates 
%   Units: [T]
%   DIM: [Ny by Nx by Nz]
% ------------------------------------------------------------------------%
%   Z
%   Description: spatial points of the B-Fields along the z-coordinates 
%   Units: [T]
%   DIM: [Ny by Nx by Nz]
% ------------------------------------------------------------------------%
%   Bx
%   Description: x-directed B-Fields 
%   Units: [T]
%   DIM: [Ny by Nx by Nz]
% ------------------------------------------------------------------------%
%   By
%   Description: y-directed B-Fields 
%   Units: [T]
%   DIM: [Ny by Nx by Nz]
% ------------------------------------------------------------------------%
%   Bz
%   Description: z-directed B-Fields 
%   Units: [T]
%   DIM: [Ny by Nx by Nz]
% ------------------------------------------------------------------------%
%
function [X,Y,Z,BX,BY,BZ] = CalcFAST(I,S,bBox,Ns)
%----------------------[Initialize variables]-----------------------------%
    mu0    = 4*pi*1e-7;         % free space permeability <scalar> [H/m]
    uc     = 1.256629*10^-6;    % Permeability of copper 
    [dl]   = compute_dl(S);     % compute delta l (delta: x, y, and z) 
    coef   = (mu0*I)/(4*pi);    
    sx =  S(1,:);   % x points for source
    sy =  S(2,:);   % y points for source
    sz =  S(3,:);   % z points for source
    dx = dl(1,:);   % delta x(s)
    dy = dl(2,:);   % delta y(s)
    dz = dl(3,:);   % delta z(s)
    NS = numel(sx); % resolution for source (wire antenna)
%--------------[B-Fields spatial lower and upper bounds]------------------%
    % lower bounds for spatial locations to compute b-fields
    xminb=bBox(1,1);
    yminb=bBox(1,2);
    zminb=bBox(1,3);
    % upper bounds for spatial locations to compute b-fields
    xmaxb=bBox(2,1);
    ymaxb=bBox(2,2);
    zmaxb=bBox(2,3);
    % resolution for spatial locations to compute b-fields
    Nx=Ns(1);
    Ny=Ns(2);
    Nz=Ns(3);
    NXYZ = Nx*Ny*Nz;
    %{
    % initialize matrices/arrays to reduce time
    % R
    Rdiff_x = zeros(Ny,Nx,Nz,NS);
    Rdiff_y = zeros(Ny,Nx,Nz,NS);
    Rdiff_z = zeros(Ny,Nx,Nz,NS);
    Rdiff   = zeros(Ny,Nx,Nz,NS);
    % |R|^3
    R       = zeros(Ny,Nx,Nz);
    % dB
    dbx = zeros(Ny,Nx,Nz,NS);
    dby = zeros(Ny,Nx,Nz,NS);
    dbz = zeros(Ny,Nx,Nz,NS);
    DBX  = zeros(Ny,Nx,Nz);
    DBY  = zeros(Ny,Nx,Nz);
    DBZ  = zeros(Ny,Nx,Nz);
    % B
    BX  = zeros(Ny,Nx,Nz);
    BY  = zeros(Ny,Nx,Nz);
    BZ  = zeros(Ny,Nx,Nz);
    %}
    % construct 3-D grid coordinates defined by the vectors x, y, and z
    x_M = linspace(xminb, xmaxb, Nx);
    y_M = linspace(yminb, ymaxb, Ny);
    z_M = linspace(zminb, zmaxb, Nz);
    [X,Y,Z]=meshgrid(x_M,y_M,z_M);        
%--------------------------[Compute B-Fields]-----------------------------%
    % Compute R(s): R and |R|^3
    % R
    Rdiffx=[];Rdiffy=[];Rdiffz=[];
    for ns=1:NS
        % Calc R (distance betweewn source and point of interest)
         Rdiff_x(:,:,:,ns) = X-sx(ns);
         Rdiff_y(:,:,:,ns) = Y-sy(ns);
         Rdiff_z(:,:,:,ns) = Z-sz(ns);  
    end
    t = 't';
    % |R|^3
% %     rdx   = sum(squeeze(Rdiff_x),4);
% %     rdy   = sum(squeeze(Rdiff_y),4);
% %     rdz   = sum(squeeze(Rdiff_z),4);
% %     Rdiff = [rdx,rdy,rdz]';
%     Rdiff = [squeeze(Rdiff_x),squeeze(Rdiff_y),squeeze(Rdiff_z)]';
%     R     = (realsqrt(sum(Rdiff.^2,1))).^3;
    
    Rdiff = Rdiff_x.^2 + Rdiff_y.^2 + Rdiff_z.^2; 
    R     = (realsqrt(Rdiff)).^3;
    R     = squeeze(R);
    % Cross Product: del x R
    for ns=1:NS
        % dBx
        dbx(:,:,:,ns) = (dy(ns).*squeeze(Rdiff_z(:,:,:,ns)))...
                        - (dz(ns).*squeeze(Rdiff_y(:,:,:,ns)));
        % dBy            
        dby(:,:,:,ns) = (dz(ns).*squeeze(Rdiff_x(:,:,:,ns)))...    
                        - (dx(ns).*squeeze(Rdiff_z(:,:,:,ns)));
        % dBz
        dbz(:,:,:,ns) = (dx(ns).*squeeze(Rdiff_y(:,:,:,ns)))... 
                        - (dy(ns).*squeeze(Rdiff_x(:,:,:,ns)));
    end
    t = 't';
    dbx=squeeze(dbx);
    dby=squeeze(dby);
    dbz=squeeze(dbz);
%     if(Nx==1 )
%         dbx=dbx';
%         dby=dby';
%         dbz=dbz';
%     end
    %DBX = sum(dbx,4);
    %DBY = sum(dby,4);
    %DBZ = sum(dbz,4);
    % Compute B-Fields
%     BX = coef*(sum(dbx./R,2));
%     BY = coef*(sum(dby./R,2));
%     BZ = coef*(sum(dbz./R,2));
    BX = coef*(sum(dbx./R,4));
    BY = coef*(sum(dby./R,4));
    BZ = coef*(sum(dbz./R,4));
    t='t';
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                          [[Description]]                                % 
%   Computes the delta l (delta_x,delta_y,delta_z) that will be used in the
%   cross product in Biot-Savart Law
%=========================================================================%
%                       [[Input Parameters]]                              %
%
% S
% DESCRIPTION: Contains the x, y, and z spatial coordiantes of the source
% (wire antenna) 
% UNITS: N/A or [m] for each element
% DIM: [numSeg by 3]
% EXAMPLE(S):
% S = [Sx,Sy,Sz], where the size of: 
% Sx is [numSeg by 1],Sy is [numSeg by 1],Sz is [numSeg by 1]
% Ex: S = [1, 2, 3;
%          2, 5, 7;
%          3, 4, 9;]
%=========================================================================%
%                       [[Ouput Parameters]]                              % 
% dl
% DESCRIPTION: delta l (contains delta_x, delta_y, and delta_z) by
% approximating the derivates of the adjecent elements within the source
% (the wire antenna)
% UNITS: N/A or [m] for each elment
% DIM: [numSeg by 3]
%=========================================================================%
function [dl] = compute_dl(varargin)
    dl = [];
    for n=1: nargin 
        rn = varargin{n};
        % approximates derivatives of adjecent elements
        dl_n = my_diff(rn);
        dl   = cat(2,dl,dl_n);
    end
end
function [output] = my_diff(v)
    output  = diff(v,1,2);
    output = cat(2,output,output(:,length(output))); 
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%