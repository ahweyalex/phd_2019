
function [xS0,yS0,zS0] = singleEllipticalLoop(ra,ri,numSeg,wT,O)
    start = 0;
    fin   = 2*pi;
    cst_xxx = linspace(start,fin,numSeg);
    
%------------ counter clock wise ( start at 0 then pos x into neg x)    
    if(O==1)
        gap = wT;
        xS0 = ra.*sin(cst_xxx);
        yS0 = ri.*cos(cst_xxx);
        zS0 = zeros(1,numel(xS0));
        
    elseif(O==0)
        gap = wT;
        xS0 = ra.*cos(cst_xxx);
        yS0 = ri.*sin(cst_xxx);
        zS0 = zeros(1,numel(xS0));
    end
    xS0 = xS0';
    yS0 = yS0';
    zS0 = zS0';
end