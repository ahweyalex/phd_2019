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


function [xS0,yS0,zS0] = constrCircWire(h,ra,ri,phi,N,O,wT,Nxy)
    helixSTEP = phi*(pi/180);
    start=0; fin = N*(2*pi) + helixSTEP/2;
    cst_xxx = start:helixSTEP:fin;
    xS0=[];yS0=[];zS0=[];
    %{
    % EDIT
    zS0 = [zS0,((h).*cst_xxx)./(2*pi*N)];
    sn = sin(cst_xxx);
    cs = cos(cst_xxx);
    idx_p = find(sn>=0 & sn<=0.2);
    zS0(idx_p(1:7:end)) = (h*.0800)+(h.*cst_xxx(idx_p(1:7:end)))./(2*pi*N);
    zS0(idx_p(2:7:end)) = (h*.0825)+(h.*cst_xxx(idx_p(2:7:end)))./(2*pi*N);
    zS0(idx_p(3:7:end)) = (h*.0850)+(h.*cst_xxx(idx_p(3:7:end)))./(2*pi*N);
    zS0(idx_p(4:7:end)) = (h*.0900)+(h.*cst_xxx(idx_p(4:7:end)))./(2*pi*N);
    zS0(idx_p(5:7:end)) = (h*.0925)+(h.*cst_xxx(idx_p(5:7:end)))./(2*pi*N);
    zS0(idx_p(6:7:end)) = (h*.0950)+(h.*cst_xxx(idx_p(6:7:end)))./(2*pi*N);
    zS0(idx_p(7:7:end)) = (h*.0100)+(h.*cst_xxx(idx_p(7:7:end)))./(2*pi*N);
    
    idx_n = find(sn>=-0.2 & sn<=0); 
    zS0(idx_n(1:7:end)) = (h*.0100)+(h.*cst_xxx(idx_n(1:7:end)))./(2*pi*N);
    zS0(idx_n(2:7:end)) = (h*.0950)+(h.*cst_xxx(idx_n(2:7:end)))./(2*pi*N);
    zS0(idx_n(3:7:end)) = (h*.0925)+(h.*cst_xxx(idx_n(3:7:end)))./(2*pi*N);
    zS0(idx_n(4:7:end)) = (h*.0900)+(h.*cst_xxx(idx_n(4:7:end)))./(2*pi*N);
    zS0(idx_n(5:7:end)) = (h*.0850)+(h.*cst_xxx(idx_n(5:7:end)))./(2*pi*N);
    zS0(idx_n(6:7:end)) = (h*.0825)+(h.*cst_xxx(idx_n(6:7:end)))./(2*pi*N);
    zS0(idx_n(7:7:end)) = (h*.0800)+(h.*cst_xxx(idx_n(7:7:end)))./(2*pi*N); 
    zSn = [];
    % EDIT
    %}
   if(O==1) % clock wise
        for nx=1:Nxy
            % checking: 1st iteration 
            t   = wT/2;
            txy = (3/2)*wT*(nx-1);
            if(mod(nx,2)~=0) 
                xS0 = [xS0,(ra+txy).*sin(cst_xxx)];
                yS0 = [yS0,(ri+txy).*cos(cst_xxx)];
                zS0 = [zS0,((h).*cst_xxx)./(2*pi*N)];
                numel(xS0)
                %zSn = [zSn,zS0];
                %a='1'
            else
                xS0 = [xS0,-(ra+txy).*sin(cst_xxx)];
                yS0 = [yS0, (ri+txy).*cos(cst_xxx)];
                zS0 = [zS0, ((h).*cst_xxx)./(2*pi*N)];
                %zSn = [zSn,zS0];
                %a='1'
            end % END: IF
        end %END: FOR
        
        else % counter clock wise
            for nx=1:Nxy
                t   = wT/2;
                txy = (3/2)*wT*(nx-1);
                
                if(mod(nx,2)~=0)
                    xS0 = [xS0,-(ra+txy).*sin(cst_xxx)];
                    yS0 = [yS0,(ri+txy).*cos(cst_xxx)];
                    zS0 = [zS0,((h)*cst_xxx)./(2*pi*N)];                      
                else
                    xS0 = [xS0,(ra+txy).*sin(cst_xxx)];
                    yS0 = [yS0,(ri+txy).*cos(cst_xxx)];
                    zS0 = [zS0,((h)*cst_xxx)./(2*pi*N)];               
                end % END: IF
            end % END: FOR        
    end % END: 
    
end % end of constrWireAnt_10_25_2018

% adds more points to create "thickness"
%{
function [xS0,yS0,zS0] = constrCircWire(h,ra,ri,phi,N,O,wT,Nxy)
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
%}