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
function [X,Y,Z,BX,BY,BZ] = CalcBSLOW(I,S,bBox,Ns,rotM,d)
%----------------------[Initialize variables]-----------------------------%
    mu0 = 4*pi*1e-7;        % free space permeability <scalar> [H/m]
    uc  = 1.256629*10^-6;   % Permeability of copper 
    u   = mu0*uc;
    %S   = [xS,yS,zS];       % matrix containing source (spartial points of 
                            % wire antenna)
    %xP=[];yP=[];zP=[];     % empty arrays to be filled with
    [dl] = compute_dl(S);   % compute delta l 
    coef = (mu0*I)/(4*pi);  %
    a = rotM.a;
    b = rotM.b;
    g = rotM.g;  
    xshift = rotM.xshift;
    yshift = rotM.yshift;
    zshift = rotM.zshift;
%--------------[B-Fields spatial lower and upper bounds]------------------%
    % lower bounds
    xminb = bBox(1,1);
    yminb = bBox(1,2);
    zminb = bBox(1,3);
    % upper bounds
    xmaxb = bBox(2,1);
    ymaxb = bBox(2,2); 
    zmaxb = bBox(2,3);
    % resolution 
    Nx = Ns(1);
    Ny = Ns(2);
    Nz = Ns(3);
    % create zero arrays for Bx,By,and Bz (reduce time)
    BX = zeros(Ny,Nx,Nz);
    BY = zeros(Ny,Nx,Nz);
    BZ = zeros(Ny,Nx,Nz);
%-------------------------self inductance---------------------------------%
    if (d=='SELF_IND')
        % create 1D arrays for each axis
        x_M = linspace(xminb, xmaxb, Nx);
        y_M = linspace(yminb, ymaxb, Ny);
        z_M = linspace(zminb, zmaxb, Nz);
        % create multi-dim arrays with the 1D arrays 
        [X,Y,Z]=meshgrid(x_M,y_M,z_M);
        t = 't';
%-------------------------mutual inductance-------------------------------%
    elseif(d=='MULT_IND')
        % create 1D arrays for each axis
        x_M = linspace(xminb, xmaxb, Nx);
        y_M = linspace(yminb, ymaxb, Ny);
        z_M = linspace(zminb, zmaxb, Nz);
        % get a single plane
        zn = 1;
        [X0,Y0,Z0]=meshgrid(x_M,y_M,z_M);
        X2 = squeeze(X0(:,:,zn));
        Y2 = squeeze(Y0(:,:,zn));
        Z2 = squeeze(Z0(:,:,zn));
        [Xr,Yr,Zr] = rotate_loop2(X2,Y2,Z2,a,b,g);
        %xshift=0; yshift=0; zshift=0;
        X = Xr + xshift;
        Y = Yr + yshift;
        Z = Zr + zshift;
    end
    t = 't';
%--------------------------[Compute B-Fields]-----------------------------%
    for yn=1:Ny             % iterate y-points (points of interest)
        for xn=1:Nx         % iterate x-points (points of interest)
            for zn=1:Nz     % iterate z-points (points of interest)                
                %for n=1:length(xP)-1   % iterate through Source (points)
                % Compute the R(s)
                r     = [x_M(xn);y_M(yn);z_M(zn)];  
               %r_SLOW(yn,xn,zn) =  [x_M(xn);y_M(yn);z_M(zn)]; 
                Rdiff = r - S;  % Calc R (distance betweewn source and 
                % point of interest)
               %Rdiff_SLOW(yn,xn,zn,:) = Rdiff;
                R     = (realsqrt(sum(Rdiff.^2,1))).^3; % |R|^3
               %R_SLOW(yn,xn,zn,:) = R;
                dB    = ThreeDim_cross(dl,Rdiff); % Compute cross product
               %dB_SLOW(yn,xn,zn,:) = dB;
                B     = coef*sum(dB./R,2);    % Compute B-Fields
                BX(yn,xn,zn) = B(1);
                BY(yn,xn,zn) = B(2);
                BZ(yn,xn,zn) = B(3);
                %end % END: S(ource) points
            end % END:Z
        end % END:X
        if(mod(yn,100)==0)
           disp(num2str(yn));
        end
    end % END:Y
end % END: CalcBSLOW
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                          [[Description]]                                % 
% Takes the cross product between two (3D) matrices. Assumes both matrices
% size are equal.
%=========================================================================%
%                       [[Input Parameters]]                              %
% A
% DESCRIPTION: (3D) matrix
% UNITS: N/A
% DIM: [numSeg by 3]
% note: when applying to biot-savart A should be dl
%
% B
% DESCRIPTION: (3D) matrix
% UNITS: N/A
% DIM: [numSeg by 3]
% note: when applying to biot-savart B should be R
%=========================================================================%
%                       [[Ouput Parameters]]                              % 
% C
% DESCRIPTION: (3D) matrix
% UNITS: N/A
% DIM: [numSeg by 3]
% note: when applying to biot-savart B should be dB of x,y,and z
%=========================================================================%
function [C] = ThreeDim_cross(A,B)
    % Initialize zero array (decrease time)
    C = zeros(3,length(A));
    % apply cross product between A and B
    C(3, :) = A(1,:).*B(2,:) - A(2,:).*B(1,:);
    C(1, :) = A(2,:).*B(3,:) - A(3,:).*B(2,:);
    C(2, :) = A(3,:).*B(1,:) - A(1,:).*B(3,:);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%