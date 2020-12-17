% Alexander Moreno
% 12-12-2020
%
%------------------------------[DESCRIPTION]------------------------------%
% Computes the mutual indtuance between solenoid with a  
% ferromagnetic core and B-Fields. 
%--------------------------[END: DESCRIPTION]-----------------------------%

%=========================================================================%
%=========================================================================%

%---------------------------[INPUT PARAMETERS]----------------------------%
%   I0
%   Description: Current through the wire 
%   Units: [A] <scalar>
%---------------------------------[B0]------------------------------------%
%   BX
%   Description: x-directed B-Fields 
%   Units: [T]
%   DIM: [Ny by Nx by Nz]
%   
%   BY
%   Description: y-directed B-Fields 
%   Units: [T]
%   DIM: [Ny by Nx by Nz]
%     
%   BZ
%   Description: z-directed B-Fields 
%   Units: [T]
%   DIM: [Ny by Nx by Nz]
%     
%   X
%   Description: spatial points of the B-Fields along the x-coordinates 
%   Units: [T]
%   DIM: [Ny by Nx by Nz]
%
%   Y
%   Description: spatial points of the B-Fields along the y-coordinates 
%   Units: [m]
%   DIM: [Ny by Nx by Nz]     
%
%   Z
%   Description: spatial points of the B-Fields along the z-coordinates 
%   Units: [m]
%   DIM: [Ny by Nx by Nz]
%   
%---------------------------------[tag]-----------------------------------%
%   N
%   Description: Number of turns for the solenoid 
%   UNITS: N/A <scalar>
%   
%   L 
%   Description: Length of the solenoid
%   UNITS: [m] <scalar>
% 
%   r
%   Description: radius of the solenoid
%   UNITS: [m] <scalar>
% 
%   ur
%   Description: dieletric constant of the ferromagnetic core
%   UNITS:  <scalar>
% 
%   az 
%   Description: solenoid positon in the azimuthal (phi-direction)
%   UNITS: [deg]  <scalar>
%
%   el 
%   Description: solenoid positon in the elevation (theta-direction)
%   UNITS: [deg] <scalar>
%
%   x
%   Description: solenoid positon in the x-direction
%   UNITS: [m] <scalar>
%
%   y
%   Description: solenoid positon in the y-direction
%   UNITS: [m] <scalar>
%
%   z
%   Description: solenoid positon in the z-direction
%   UNITS: [m] <scalar>
%
%-------------------------[END: INPUT PARAMETERS]-------------------------%

%=========================================================================%
%=========================================================================%


%---------------------------[OUTPUT PARAMETERS]---------------------------%
% M12
% DESCRIPTION: Mutual indutance between multi-coiled wire and solenoid with
% a ferromagnetic core. 
% UNITS: <N by N matrix>
%-------------------------[END: OUTPUT PARAMETERS]------------------------%

%=========================================================================%
%=========================================================================%

function [M12] = Calc_Mutual_Ind_new(B0,I0,tag)
    mu0 = 4*pi*1e-7; % free space permeability <scalar> [H/m]
    % bfields of multi-coil wire antenna
    BX  = B0.BX;
    BY  = B0.BY;
    BZ  = B0.BZ;
    X   = B0.X;
    Y   = B0.Y;
    Z   = B0.Z;
    
    SA = pi*(tag.r)^2; % surface area of solenoid
    
end



































