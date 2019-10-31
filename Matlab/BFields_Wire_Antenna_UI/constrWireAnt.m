% Alexander Moreno
% 07-19-2018
% ------------------------------------------------------------------------
% Description:
% A)
% 1a) Generates points in cartesian plane (x,y,& z) for a 3D linear helical
% spiral or rectangular loop. The 3D linear helical spiral has a variable 
% width (i.e. x and y), height (z), number of turns (N), and number of turns 
% wrapped (Nw).
% 1b) Applying set up from CST to contstruct 3D linear helical `spiral
% -------------------------------------------------------------------------
% -------------------------------------------------------------------------
% Input Parameters:
%   N
%   Description: Number of turns
%   Units: <scalar>
% ------------------------------------------------------------------------
%   Nw
%   Description: Number of wraps (in x & y direction)
%   Units: <scalar>
% ------------------------------------------------------------------------
%   wT
%   Description: wire thickness
%   Units: [m] <scalar>
% ------------------------------------------------------------------------
%   rx
%   Description: distance in x-direction 
%   Units: [m] <scalar>
% ------------------------------------------------------------------------
%   ry
%   Description: distance in y-direction 
%   Units: [m] <scalar>
% ------------------------------------------------------------------------
%   hz
%   Description: starting and ending points (height) 
%   Units: [m] <array>
%   Ex: hz = [start, end];
% ------------------------------------------------------------------------
% ------------------------------------------------------------------------
%   Ouput Parameters:
%
%   xS
%   Description: B-Fields in x-direction
%   Units:
% ------------------------------------------------------------------------
%   yS
%   Description: B-Fields in y-direction
%   Units:
% ------------------------------------------------------------------------
%   zS
%   Description: B-Fields in z-direction
%   Units:
% ------------------------------------------------------------------------
% ------------------------------------------------------------------------

function [xS0,yS0,zS0] = constrWireAnt(h,ra,ri,phi,Nz,O,wT,N)
    %% Construct Circular Wire Antenna Structure
    helixSTEP = phi*(pi/180);
    start=0; fin = Nz*(2*pi) + helixSTEP/2;
    cst_xxx = start:helixSTEP:fin;
    xS0=[];yS0=[];zS0=[];
    if(O==1) % clock wise
        for nx=1:N
            % checking: 1st iteration 
            if(mod(nx,2)~=0) 
                xS0 = [xS0,(ra+ wT*nx).*sin(cst_xxx)];
                yS0 = [yS0,(ri+ wT*nx).*cos(cst_xxx)];
                zS0 = [zS0,(h*cst_xxx)./(2*pi*Nz)];
            else
                xS0 = [xS0,-(ra+ wT*nx).*sin(cst_xxx)];
                yS0 = [yS0,(ri+ wT*nx).*cos(cst_xxx)];
                zS0 = [zS0,(h*cst_xxx)./(2*pi*Nz)];
            end % END: IF
        end %END: FOR
        
        else % counter clock wise
        for nx=1:N
            if(mod(nx,2)~=0)
                xS0 = [xS0,-(ra+ wT*nx).*sin(cst_xxx)];
                yS0 = [yS0,(ri+ wT*nx).*cos(cst_xxx)];
                zS0 = [zS0,(h*cst_xxx)./(2*pi*Nz)];
            else
                xS1 = [xS0,(ra + wT*nx).*sin(cst_xxx)];
                yS1 = [yS0,(ri + wT*nx).*cos(cst_xxx)];
                zS1 = [zS0,(h*cst_xxx)./(2*pi*Nz)];
            end % END: IF
        end % END: FOR
        
    end % END: O
    xS0=xS0'; yS0=yS0'; zS0=zS0';
    % Adding "thickens" to wire structure (along current path)
    S0 = [xS0,      yS0,      zS0+wT/2;     %+z
          xS0,      yS0,      zS0-wT/2;     %-z
          xS0+wT/2, yS0+wT/2, zS0;          %+xy
          xS0-wT/2, yS0-wT/2, zS0;          %-xy
          % new addtions
          xS0-wT/2, yS0-wT/2, zS0+wT/4;     %-(xy)/2,+z
          xS0-wT/2, yS0-wT/2, zS0-wT/4;     %-(xy)/2,-z
          xS0+wT/2, yS0+wT/2, zS0+wT/4;     %+(xy)/2,+z
          xS0+wT/2, yS0+wT/2, zS0-wT/4;     %+(xy)/2,-z
          % new-er addtions
          xS0-wT/4, yS0-wT/4, zS0+wT/2;     %-(xy)/4,+z
          xS0-wT/4, yS0-wT/4, zS0-wT/2;     %-(xy)/4,-z
          xS0+wT/4, yS0+wT/4, zS0+wT/2;     %+(xy)/4,+z
          xS0+wT/4, yS0+wT/4, zS0-wT/2;     %+(xy)/4,-z
          ];
    xS = S0(:,1); yS = S0(:,2); zS = S0(:,3);
    
end % end of constrWireAnt_10_25_2018