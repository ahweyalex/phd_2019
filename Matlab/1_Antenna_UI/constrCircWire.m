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

function [xS0,yS0,zS0] = constrCircWire(h,ra,ri,numSeg,N,O,wT,Nxy)
    %helixSTEP = phi*(pi/180);
    start=0; 
    %fin = N*(2*pi) + helixSTEP/2;
    fin = N*(2*pi);
    
    %cst_xxx = start:helixSTEP:fin;
    % phi=numSeg;
    cst_xxx = linspace(start,fin,numSeg);
    xS0=[];yS0=[];zS0=[];
    z0 = linspace(0,N*2*pi*h,numSeg);
   %
   if(O==1) % clock wise
        for nx=1:Nxy
            % checking: 1st iteration 
            t    = wT/2;
            txy  = (3/2)*wT*(nx-1);
            txy1 = (3/2)*wT*(nx);
            if(mod(nx,2)~=0) 
                xS0 = [xS0,(ra+txy).*sin(cst_xxx)];
                yS0 = [yS0,(ri+txy).*cos(cst_xxx)];
                %zS0 = [zS0,((h).*cst_xxx)./(2*pi*N)];
                zS0 = [zS0,z0];
                
                %zSn = [zSn,zS0];
                % connect the coils 
%                 if(nx~=Nxy)
%                     LN  = 4;
%                     xC  = linspace(0,0,LN);
%                     yC  = linspace(ra+txy,ra+txy1,LN);
%                     zC  = linspace(zS0(end),zS0(end),LN);
%                     xS0 = [xS0,xC];
%                     yS0 = [yS0,yC];
%                     zS0 = [zS0,zC];
%                 end
                %a='1';
            else
                xS0 = [xS0,-(ra+txy).*sin(cst_xxx)];
                yS0 = [yS0, (ri+txy).*cos(cst_xxx)];
                %zS0 = [zS0, ((h).*cst_xxx)./(2*pi*N)];
                zS0 = [zS0,z0];
                %zSn = [zSn,zS0];
                % connect the coils 
%                 if(nx~=Nxy)
%                     LN  = 4;
%                     xC  = linspace(0,0,LN);
%                     yC  = linspace(ra+txy,ra+txy1,LN);
%                     zC  = linspace(0,0,LN);
%                     xS0 = [xS0,xC];
%                     yS0 = [yS0,yC];
%                     zS0 = [zS0,zC];
%                 end
                %a='1';
            end % END: IF
        end %END: FOR
        
       % counter clock wise 
        else 
            for nx=1:Nxy
                t   = wT/2;
                txy = (3/2)*wT*(nx-1);
                if(mod(nx,2)~=0)
                    xS0 = [xS0,-(ra+txy).*sin(cst_xxx)];
                    yS0 = [yS0,(ri+txy).*cos(cst_xxx)];
                    %zS0 = [zS0,((h)*cst_xxx)./(2*pi*N)];
                    zS0 = [zS0,z0];
%                     if(nx~=Nxy)
%                         LN  = 4;
%                         xC  = linspace(0,0,LN);
%                         yC  = linspace(ra+txy,ra+txy1,LN);
%                         zC  = linspace(zS0(end),zS0(end),LN);
%                         xS0 = [xS0,xC];
%                         yS0 = [yS0,yC];
%                         zS0 = [zS0,zC];
%                     end
                else
                    xS0 = [xS0,(ra+txy).*sin(cst_xxx)];
                    yS0 = [yS0,(ri+txy).*cos(cst_xxx)];
                    %zS0 = [zS0,((h)*cst_xxx)./(2*pi*N)]; 
                    zS0 = [zS0,z0];
%                     if(nx~=Nxy)
%                         LN  = 4;
%                         xC  = linspace(0,0,LN);
%                         yC  = linspace(ra+txy,ra+txy1,LN);
%                         zC  = linspace(0,0,LN);
%                         xS0 = [xS0,xC];
%                         yS0 = [yS0,yC];
%                         zS0 = [zS0,zC];
%                     end
                end % END: IF
            end % END: FOR        
    end % END: 
    
    %% add feed lines
    %zEnd = h*N*2*pi;
    %
    LN = 20;
    outX = linspace(0,0,LN);
    outY = linspace(ri,2*ri,LN); 
    outZ = linspace(zS0(end),zS0(end),LN);
    inX  = linspace(0,0,LN);
    inY  = linspace(ri,2*ri,LN);
    inZ  = linspace(0,0,LN);
    
    xS0 = [inX,xS0,outX];
    yS0 = [inY,yS0,outY];
    zS0 = [inZ,zS0,outZ];
    %}
    xS0 = xS0';
    yS0 = yS0';
    zS0 = zS0';
%end % end of constrWireAnt_10_25_2018
%}

%{
% adds more points to create "thickness"
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
        
        LN = 20;
        outX = linspace(0,0,LN);
        outY = linspace(ri,2*ri,LN); 
        outZ = linspace(zS0(end),zS0(end),LN);
        inX  = linspace(0,0,LN);
        inY  = linspace(ri,2*ri,LN);
        inZ  = linspace(0,0,LN);
        xS0 = [inX,xS0,outX];
        yS0 = [inY,yS0,outY];
        zS0 = [inZ,zS0,outZ];

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
%}