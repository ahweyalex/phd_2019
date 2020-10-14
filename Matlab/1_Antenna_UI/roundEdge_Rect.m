% Alexander Moreno
% DATE: 10-10-2020
%
% DESCRIPTION: creates rectangle with rounded edes
%
% <In-Progress>

function [xc,yc] = roundEdge_Rect(xv,yv,r,Nth)
    
    d_theta  = pi/Nth;
    theta    = 0:d_theta:pi/2;
    
    % compute delta (x and y)
    dx = abs(xv(1,2) - xv(1,1));
    dy = abs(yv(1,2) - yv(1,1));
    % reduce X/Y by radius (bent)
    %x_r = [xv(1,1)+(r.*dx),xv(1,2)+(r.*dx)];
    %y_r = [yv(1,1)+(r.*dx),yv(1,2)+(r.*dx)];
    
    x_r = [xv(1,1),xv(1,2)];
    y_r = [yv(1,1),yv(1,2)];

    % initialize complete series
    %x_r = []; y_r = [];
    xc = zeros(numel(theta),4); %xu = zeros(Nth,1);
    yc = zeros(numel(theta),4); %yu = zeros(Nth,1);
    x_rect = []; y_rect = [];
    % cycle through each corner
    for vn=1:4
        if(vn==1)
            x = max(x_r);
            y = max(y_r);
        elseif(vn==2)
            x = min(x_r);
            y = max(y_r);
        elseif(vn==3)
            x = min(x_r);
            y = min(y_r);
        elseif(vn==4)
            x = max(x_r);
            y = min(y_r);
        end
        % plot circ arc
        t = 't';
        xu = (r.*dx).* cos(theta) + x;
        yu = (r.*dx).* sin(theta) + y;
        % add to the series
        xc(:,vn) = xu';
        yc(:,vn) = yu';
        theta = theta + pi/2;
    end
end