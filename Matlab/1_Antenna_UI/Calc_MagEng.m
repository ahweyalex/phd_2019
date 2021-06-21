% Alexander Moreno
% DATE: 07-13-2021
%
% DESCRIPTION: 
% Computes Magnetic Energy (Wm [J]) from the B-Fields
% EQU: Wm = (1/2)* vol_int[ B^2 / u] dv' [J]
%
% REFERENCE: pg289 EQU 6-172a-c Field and Wave Electromagentics 
% by David K. Cheng 
%
%%                       [[INPUT PARAMETERS]]                            %%
% zEnd
% Description: Upper limit value in the z-direction 
% UNITS:  [m] 
% VALUES: float 
% MATRIX SIZE: <1x1> 
%
%--------------------------------ANT1-------------------------------------%
% Description:
% 1x1 struct variable containing parameters to ANT 1
%
% ANT1.NXY
% Description: ANT 1's number of coils
% UNITS: unitless 
% VALUES: int 
% MATRIX SIZE: <1x1> 
%
% ANT1.N
% Description: ANT 1's number of turns 
% UNITS: unitless
% VALUES: int 
% MATRIX SIZE: <1x1>
%
% ANT1.ra
% Description: ANT 1's radius in the y-axis
% UNITS: [m]
% VALUES: float 
% MATRIX SIZE: <1x1>
%
% ANT1.ri
% Description: ANT 1's radius in the x-axis
% UNITS: [m]
% VALUES: float 
% MATRIX SIZE: <1x1>
%
% ANT1.wT
% Description: ANT 1's width of wire (gauge)
% UNITS: [m]
% VALUES: float 
% MATRIX SIZE: <1x1>
%
% ANT1.I
% Description: ANT 1's current 
% UNITS: [A]
% VALUES: float 
% MATRIX SIZE: <1x1>
%
%------------------------------SELF_IND-----------------------------------%
% Description:
% 1x1 struct variable containing B-Fields and cartesian spatial coordinate
% points.
%
% SELF_IND.X
% Description: x-values of spatial location of b-field
% UNITS: [m]
% VALUES: float
% MATRIX SIZE: <Nx by Ny by Nz>
%
% SELF_IND.Y
% Description: y-values of spatial location of b-field
% UNITS: [m]
% VALUES: float
% MATRIX SIZE: <Nx by Ny by Nz>
%
% SELF_IND.Z
% Description: z-values of spatial location of b-field
% UNITS: [m]
% VALUES: float
% MATRIX SIZE: <Nx by Ny by Nz>
%
% SELF_IND.BX
% Description: x-directed b-field values
% UNITS: [T]
% VALUES: float
% MATRIX SIZE: <Nx by Ny by Nz>
%
% SELF_IND.BY
% Description: y-directed b-field values
% UNITS: [T]
% VALUES: float
% MATRIX SIZE: <Nx by Ny by Nz>
%
% SELF_IND.BZ
% Description: z-directed b-field values
% UNITS: [T]
% VALUES: float
% MATRIX SIZE: <Nx by Ny by Nz>
%
%%%                                                                     %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%                        OUTPUT PARAMETERS                              %%
%
% Wm
% Description: magnetic energy
% UNITS: [J]
% VALUES: float
%
%%%                                                                     %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%                          MATLAB FUNCTION                              %%
%%%                                                                     %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%function [Wm] = Calc_MagEng(zEnd, ANT1, SELF_IND)
function [Wm, L11] = Calc_MagEng(SELF_IND,I)
% SET VARIABLES
    % permeability of free space
    %u0 = 4*pi*10^(-7); % [H/m]
    u0 = 4*pi*1e-7;
    %u0 = 1;
    ur = 1; 
    u  = u0*ur;
    % spatial points
    X = SELF_IND.X;
    Y = SELF_IND.Y;
    Z = SELF_IND.Z;
    % BField values
    BX = SELF_IND.BX;
    BY = SELF_IND.BY;
    BZ = SELF_IND.BZ;
    % del x, del y, del z
    % assumes uniform spacing 
    delx = abs( X(1,1,1) - X(1,2,1) );
    dely = abs( Y(1,1,1) - Y(2,1,1) );
    delz = abs( Z(1,1,1) - Z(1,1,2) );
    res  = delx*dely*delz;
    % squared   
    %magBX = sqrt(BX.^2);
    %magBY = sqrt(BY.^2);
    %magBZ = sqrt(BZ.^2);
    magBX = BX.^2;
    magBY = BY.^2;
    magBZ = BZ.^2;
    %  
    magBX_res = (1/u).*(magBX.*res);
    magBY_res = (1/u).*(magBY.*res);
    magBZ_res = (1/u).*(magBZ.*res);
    % summation 
    sumBX = sum(magBX_res,'all');
    sumBY = sum(magBY_res,'all');
    sumBZ = sum(magBZ_res,'all');
    % work (magnetic energy)  
    Wm  = (1/2)*(sumBX + sumBY + sumBZ);
    L11 = (2*Wm)/(I^2); 
    t='t';
end