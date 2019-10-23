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

function [xS0,yS0,zS0,xS1,yS1,zS1] = constrWireAnt(h,ra,ri,phi,Nz,O,wT,N)
    %% Construct Circular Wire Antenna Structure
    helixSTEP = phi*(pi/180);
    start=0; fin = Nz*(2*pi) + helixSTEP/2;
    cst_xxx = start:helixSTEP:fin;
    
    if(O==1) % clock wise
        xS0 = (ra+ wT*N).*sin(cst_xxx);
        yS0 = (ri+ wT*N).*cos(cst_xxx);
        zS0 = (h*cst_xxx)./(2*pi*Nz);

        xS1 = -(ra+ wT*N+1).*sin(cst_xxx);
        yS1 = (ri+ wT*N+1).*cos(cst_xxx);
        zS1 = (h*cst_xxx)./(2*pi*Nz);
    else % counter clock wise
        xS0 = -(ra+ wT*N).*sin(cst_xxx);
        yS0 = (ri+ wT*N).*cos(cst_xxx);
        zS0 = (h*cst_xxx)./(2*pi*Nz);

        xS1 = (ra + wT*N+1).*sin(cst_xxx);
        yS1 = (ri + wT*N+1).*cos(cst_xxx);
        zS1 = (h*cst_xxx)./(2*pi*Nz);
    end
    xS0=xS0'; yS0=yS0'; zS0=zS0';
    xS1=xS1'; yS1=yS1'; zS1=zS1';
    
    % Adding "thickens" to wire structure (along current path)
    S0 = [xS0,      yS0,      zS0+wT/2;
          xS0,      yS0,      zS0-wT/2;
          xS0+wT/2, yS0+wT/2, zS0;
          xS0-wT/2, yS0-wT/2, zS0;
          % new addtions
          xS0-wT/2, yS0-wT/2, zS0+wT/4;
          xS0-wT/2, yS0-wT/2, zS0-wT/4;
          xS0+wT/2, yS0+wT/2, zS0+wT/4;
          xS0+wT/2, yS0+wT/2, zS0-wT/4;
          % new(er) additions
          xS0-wT/4, yS0-wT/4, zS0+wT/2;
          xS0-wT/4, yS0-wT/4, zS0-wT/2;
          xS0+wT/4, yS0+wT/4, zS0+wT/2;
          xS0+wT/4, yS0+wT/4, zS0-wT/2;
          ];

    S1 = [xS1,      yS1,      zS1+wT/2;
          xS1,      yS1,      zS1-wT/2;
          xS1+wT/2, yS1+wT/2, zS1;
          xS1-wT/2, yS1-wT/2, zS1;
          % new addtions
          xS1-wT/2, yS1-wT/2, zS1+wT/4;
          xS1-wT/2, yS1-wT/2, zS1-wT/4;
          xS1+wT/2, yS1+wT/2, zS1+wT/4;
          xS1+wT/2, yS1+wT/2, zS1-wT/4;
          % new(er) additions
          xS1-wT/4, yS1-wT/4, zS1+wT/2;
          xS1-wT/4, yS1-wT/4, zS1-wT/2;
          xS1+wT/4, yS1+wT/4, zS1+wT/2;
          xS1+wT/4, yS1+wT/4, zS1-wT/2;
          ];

    %xS = S0(:,1); yS = S0(:,2); zS = S0(:,3);
    
end % end of constrWireAnt_10_25_2018