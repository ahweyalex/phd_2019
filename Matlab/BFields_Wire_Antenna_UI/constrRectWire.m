function [xS,yS,zS] = constrRectWire(h,W0,L0,phi,N,O,wT)
%% Construct Rect Wire Antenna Structure
    deltaS = 200;
    helixSTEP = phi*(pi/180);
    start=0; fin = N*(2*pi) + helixSTEP/2;
    cst_xxx = start:helixSTEP:fin;
    cstSize = floor((numel(cst_xxx)/4)/N);
    hSize   = floor(cstSize/2);

    x  = linspace(-W0/2,W0/2,cstSize)';  
    xi = linspace(0,W0/2,floor(cstSize/2))';
    xc = W0/2*ones(1,cstSize)';
    
    y   = linspace(-L0/2,L0/2,cstSize)';  
    yc  = L0/2*ones(1,cstSize)';
    yic = L0/2*ones(1,hSize)';
    
    if(O==1) %clock wise
        x0 = [xc; -x; -xc;   x];
        y0 = [ y; yc;  -y; -yc];
        xS0 = repmat(x0,N,1);   xS0(end-hSize:end)=[]; 
        yS0 = repmat(y0,N,1);   yS0(end-hSize:end)=[];
        xS0 = [xi;xS0];         
        yS0 = [-yic;yS0]; 
        zSize = numel(xS0);
        zp = linspace(start,fin, zSize)';
        zS0 = (h*zp)./(2*pi*N);s
    else %counter clock wise
        x0 = [-xc; x; xc; -x];
        y0 = [ y; yc; -y; -yc];
        xS0 = repmat(x0,N,1);   xS0(end-hSize:end)=[]; 
        yS0 = repmat(y0,N,1);   yS0(end-hSize:end)=[];
        xS0 = [-xi;xS0];        yS0 = [-yic;yS0];
        zSize = numel(xS0);
        zp = linspace(start,fin, zSize)';
        zS0 = (h*zp)./(2*pi*N);
    end 
    
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
    xS = S0(:,1); yS = S0(:,2); zS = S0(:,3);
    
end