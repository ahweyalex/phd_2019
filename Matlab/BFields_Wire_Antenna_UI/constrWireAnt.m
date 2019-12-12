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

function [xS0,yS0,zS0] = constrWireAnt(h,ra,ri,phi,N,O,wT,Nxy)
    helixSTEP = phi*(pi/180);
    start=0; fin = N*(2*pi) + helixSTEP/2;
    cst_xxx = start:helixSTEP:fin;
    xS0=[];yS0=[];zS0=[];
    if(O==1) % clock wise
        for nx=1:Nxy
            % checking: 1st iteration 
            t   = wT/2;
            txy = (3/2)*wT*(nx-1);
            if(mod(nx,2)~=0) 
                %+z
                xS0 = [xS0,(ra+txy).*sin(cst_xxx)];
                yS0 = [yS0,(ri+txy).*cos(cst_xxx)];
                zS0 = [zS0,((h+t)*cst_xxx)./(2*pi*N)];
                %-z
                xS0 = [xS0,(ra+txy).*sin(cst_xxx)];
                yS0 = [yS0,(ri+txy).*cos(cst_xxx)];
                zS0 = [zS0,((h-t)*cst_xxx)./(2*pi*N)];
                %+xy
                xS0 = [xS0,(ra+t+txy).*sin(cst_xxx)];
                yS0 = [yS0,(ri+t+txy).*cos(cst_xxx)];
                zS0 = [zS0,((h)*cst_xxx)./(2*pi*N)];
                %-xy
                xS0 = [xS0,(ra-t+txy).*sin(cst_xxx)];
                yS0 = [yS0,(ri-t+txy).*cos(cst_xxx)];
                zS0 = [zS0,((h)*cst_xxx)./(2*pi*N)];
            else
                %+z
                xS0 = [xS0,-(ra+txy).*sin(cst_xxx)];
                yS0 = [yS0, (ri+txy).*cos(cst_xxx)];
                zS0 = [zS0, ((h+t)*cst_xxx)./(2*pi*N)];
                %-z
                xS0 = [xS0,-(ra+txy).*sin(cst_xxx)];
                yS0 = [yS0, (ri+txy).*cos(cst_xxx)];
                zS0 = [zS0, ((h-t)*cst_xxx)./(2*pi*N)];
                %+xy
                xS0 = [xS0,-(ra+t+txy).*sin(cst_xxx)];
                yS0 = [yS0, (ri+t+txy).*cos(cst_xxx)];
                zS0 = [zS0, ((h)*cst_xxx)./(2*pi*N)];
                %-xy
                xS0 = [xS0,-(ra-t+txy).*sin(cst_xxx)];
                yS0 = [yS0, (ri-t+txy).*cos(cst_xxx)];
                zS0 = [zS0, ((h)*cst_xxx)./(2*pi*N)];
                
            end % END: IF
        end %END: FOR
        
        else % counter clock wise
            for nx=1:Nxy
                t   = wT/2;
                txy = (3/2)*wT*(nx-1);
                
                if(mod(nx,2)~=0)
                    %+z
                    xS0 = [xS0,-(ra+txy).*sin(cst_xxx)];
                    yS0 = [yS0,(ri+txy).*cos(cst_xxx)];
                    zS0 = [zS0,((h+t)*cst_xxx)./(2*pi*N)];
                    %-z
                    xS0 = [xS0,-(ra+txy).*sin(cst_xxx)];
                    yS0 = [yS0, (ri+txy).*cos(cst_xxx)];
                    zS0 = [zS0, ((h-t)*cst_xxx)./(2*pi*N)];
                    %+xy
                    xS0 = [xS0,-(ra+t+txy).*sin(cst_xxx)];
                    yS0 = [yS0, (ri+t+txy).*cos(cst_xxx)];
                    zS0 = [zS0, ((h)*cst_xxx)./(2*pi*N)];
                    %-xy
                    xS0 = [xS0,-(ra-t+txy).*sin(cst_xxx)];
                    yS0 = [yS0, (ri-t+txy).*cos(cst_xxx)];
                    zS0 = [zS0, ((h)*cst_xxx)./(2*pi*N)];        
                    
                else
                    %+z
                    xS0 = [xS0,(ra+txy).*sin(cst_xxx)];
                    yS0 = [yS0,(ri+txy).*cos(cst_xxx)];
                    zS0 = [zS0,((h+t)*cst_xxx)./(2*pi*N)];
                    %-z
                    xS0 = [xS0,(ra+txy).*sin(cst_xxx)];
                    yS0 = [yS0,(ri+txy).*cos(cst_xxx)];
                    zS0 = [zS0,((h-t)*cst_xxx)./(2*pi*N)];
                    %+xy
                    xS0 = [xS0,(ra+t+txy).*sin(cst_xxx)];
                    yS0 = [yS0,(ri+t+txy).*cos(cst_xxx)];
                    zS0 = [zS0,((h)*cst_xxx)./(2*pi*N)]; 
                    %-xy
                    xS0 = [xS0,(ra-t+txy).*sin(cst_xxx)];
                    yS0 = [yS0,(ri-t+txy).*cos(cst_xxx)];
                    zS0 = [zS0,((h)*cst_xxx)./(2*pi*N)];                 
                end % END: IF
            end % END: FOR        
    end % END: 
    
end % end of constrWireAnt_10_25_2018