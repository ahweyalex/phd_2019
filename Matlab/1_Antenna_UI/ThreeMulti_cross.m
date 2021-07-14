% Alexander Moreno
% DATE: 07-11-2021
% 
% DESCRIPTION: cross product between A (Ax,Ay,Az) and H (Hx,Hy,Hz)
%
% UNITS: N/A
% DIM: Ny by Nx by Nz matrix
%
function [AXH,AYH,AZH] = ThreeMulti_cross(AX,AY,AZ,BX,BY,BZ)
    mu0 = 4*pi*1e-7; % free space permeability <scalar> [H/m]
    [Ny Nx Nz] = size(AX);
    HX = BX./mu0; 
    HY = BY./mu0;
    HZ = BZ./mu0;
    
    % (AxH)
    % or 
    % <Ax Ay Az> cross <Hx Hy Hz>
    for xn=1:Nx
        for yn=1:Ny
            for zn=1:Nz
                AXH(yn,xn,zn) = AY(yn,xn,zn).*HZ(yn,xn,zn)-...
                                AZ(yn,xn,zn).*HY(yn,xn,zn);
                
                AYH(yn,xn,zn) = AZ(yn,xn,zn).*HX(yn,xn,zn)-... 
                                AX(yn,xn,zn).*HZ(yn,xn,zn);
                
                AZH(yn,xn,zn) = AX(yn,xn,zn).*HY(yn,xn,zn)-...
                                AY(yn,xn,zn).*HX(yn,xn,zn);
            end
        end
    end
    
end