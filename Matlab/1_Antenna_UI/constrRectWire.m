
function [xS,yS,zS] = constrRectWire(h,W0,L0,wT,numSeg,N,Nxy,O,gap)
%-----------------------initialize variables -----------------------------%    
    xS=[]; yS=[]; zS=[]; 
    zEnd = h*N*2*pi;
%=========================================================================%
%======================= construct multi-coil ============================%   
%=========================================================================%

%------------ most inner coil begins counter clock-wise (ccw) ------------%
    if(O==1)
        for nxy=1:Nxy
            % z begins at 0 and goes up to zEnd
            if(mod(nxy,2)==1)
                W = W0 + (nxy-1)*(2*wT);
                L = L0 + (nxy-1)*(2*wT);
                [sx,sy] = ccwRectWire(W,L,numSeg,N,gap);
                sz = linspace(0,zEnd,numel(sx))';
                xS = [xS;sx];
                yS = [yS;sy];
                zS = [zS;sz];
                sx=[];sy=[];sz=[];           
            % z begins at zEnd and goes down to 0
            elseif(mod(nxy,2)==0)
                W = W0 + (nxy-1)*(2*wT);
                L = L0 + (nxy-1)*(2*wT);
                [sx,sy] = ccwRectWire(W,L,numSeg,N,gap);
                sz = linspace(zEnd,0,numel(sx))';
                xS = [xS;sx];
                yS = [yS;sy];
                zS = [zS;sz];
                sx=[];sy=[];sz=[];
            end
            
        end %END: FOR LOOP
        
%---------------most inner coil begins clock-wise (cw)--------------------%
    elseif(O==0)
      for nxy=1:Nxy
        % z begins at 0 and goes up to zEnd
        if(mod(nxy,2)==1)
            W = W0 + (nxy-1)*(2*wT);
            L = L0 + (nxy-1)*(2*wT);
            [sx,sy] = cwRectWire(W,L,numSeg,N,gap);
            sz = linspace(0,zEnd,numel(sx))';
            xS = [xS;sx];
            yS = [yS;sy];
            zS = [zS;sz];            
            sx=[];sy=[];sz=[];
        % z begins at zEnd and goes down to 0
        elseif(mod(nxy,2)==0)
            W = W0 + (nxy-1)*(2*wT);
            L = L0 + (nxy-1)*(2*wT);
            [sx,sy] = cwRectWire(W,L,numSeg,N,gap);
            sz = linspace(zEnd,0,numel(sx))';
            xS = [xS;sx];
            yS = [yS;sy];
            zS = [zS;sz];
            sx=[];sy=[];sz=[];
        end
        
      end %END: FOR LOOP
      
    end % END: Choosing starting orientation 
    
end % END FUNCTION constrRectWire_
%=========================================================================%
%===================END: construct multi-coil ============================%   
%=========================================================================%



%=========================================================================%
%=========================  cwRectWire  ==================================%   
%=========================================================================%

function [sx,sy] = cwRectWire(W,L,numSeg,N,gap)
%--------------------set up initial variables ----------------------------%  
    %zEnd = h*N*w*pi;
    sep_xy = 2.2; 
    sep_z  = 0.25;
    armSize = floor(numSeg/4); % number of points along each arm
    sx=[]; sy=[]; % initialize final x and y 1-D arrays
%-------------------------- front arm ------------------------------------%
    xf = linspace( W/2,  W/2, armSize)';
    yf = linspace( L/2, -L/2, armSize)';
    xf = xf(2:end);     % avoid double counting the edges
    yf = yf(2:end);     % avoid double counting the edges
%---------------------- front right arm ----------------------------------%
    xfr = linspace( W/2,  W/2,  floor(armSize/2))';
    yfr = linspace(-gap, -L/2 , floor(armSize/2))';
%-------------------------- right arm ------------------------------------%
    xr = linspace( W/2, -W/2, armSize)';    
    yr = linspace(-L/2, -L/2, armSize)';    
    xr = xr(2:end);     % avoid double counting the edges
    yr = yr(2:end);     % avoid double counting the edges
%-------------------------- back arm -------------------------------------%
    xb = linspace(-W/2, -W/2, armSize)';
    yb = linspace(-L/2,  L/2, armSize)';   
    xb = xb(2:end);     % avoid double counting the edges
    yb = yb(2:end);     % avoid double counting the edges
%-------------------------- left arm -------------------------------------%
    xl = linspace(-W/2, W/2, armSize)';
    yl = linspace( L/2, L/2, armSize)';
    xl = xl(2:end);     % avoid double counting the edges
    yl = yl(2:end);     % avoid double counting the edges
%-------------------- front left arm -------------------------------------%
    xfl = linspace( W/2,  W/2, floor(armSize/2))';
    yfl = linspace( L/2,  gap, floor(armSize/2))';    
    xfl = xfl(2:end);       % avoid double counting the edges
    yfl = yfl(2:end);       % avoid double counting the edges
%---------------construct multi-turn rectangle coil-----------------------%
    for n=1:N
        % first iteration and not last iteration
        if(n==1 && n~=N)
            sx = [sx;xfr;xr;xb];
            sy = [sy;yfr;yr;yb];
            t = 't';
        % first iteration and last iteration
        elseif(n==1 && n==N)
            sx = [sx;xfr;xr;xb;xl;xfl];
            sy = [sy;yfr;yr;yb;yl;yfl];
            t = 't';
        % last iteration
        elseif(n==N)
            sx = [sx;xr;xb;xl;xfl];
            sy = [sy;yr;yb;yl;yfl];
        % in between 
        else
            sx = [sx;xf;xr;xb;xl];
            sy = [sy;yf;yr;yb;yl;];
        end
    end
%-------------------------------------------------------------------------%    
end


%=========================================================================%
%=========================  ccwRectWire  =================================%   
%=========================================================================%
function [sx,sy] = ccwRectWire(W,L,numSeg,N,gap)
    %zEnd = h*N*w*pi;
    sep_xy = 2.2; 
    sep_z  = 0.25;
    %armSize = floor((numSeg/4)/N); % number of points along each arm
    armSize = floor(numSeg/4); % number of points along each arm
    sx=[]; sy=[]; % initialize final x and y 1-D arrays
%-------------------------- front arm ------------------------------------%
    xf = linspace( W/2,  W/2, armSize)';
    yf = linspace( -L/2, L/2, armSize)';
    xf = xf(2:end);     % avoid double counting the edges
    yf = yf(2:end);     % avoid double counting the edges
%---------------------- front left arm -----------------------------------%
    xfl = linspace(W/2, W/2, floor(armSize/2))';
    yfl = linspace(gap, L/2, floor(armSize/2))';
%-------------------------- left arm -------------------------------------%
    xl = linspace( W/2, -W/2, armSize)';
    yl = linspace( L/2,  L/2, armSize)';
    xl = xl(2:end);     % avoid double counting the edges
    yl = yl(2:end);     % avoid double counting the edges
%-------------------------- back arm -------------------------------------%
    xb = linspace(-W/2, -W/2, armSize)';
    yb = linspace( L/2, -L/2, armSize)';
    xb = xb(2:end);     % avoid double counting the edges
    yb = yb(2:end);     % avoid double counting the edges
%-------------------------- right arm ------------------------------------%
    xr = linspace(-W/2,  W/2, armSize)';
    yr = linspace(-L/2, -L/2, armSize)';
    xr = xr(2:end);     % avoid double counting the edges
    yr = yr(2:end);     % avoid double counting the edges
%-------------------- front right arm ------------------------------------%
    xfr = linspace( W/2, W/2, floor(armSize/2))';
    yfr = linspace(-L/2, gap, floor(armSize/2))';
    xfr = xfr(2:end);   % avoid double counting the edges
    yfr = yfr(2:end);   % avoid double counting the edges
%---------------construct multi-turn rectangle coil-----------------------%
    for n=1:N
        % first iteration and not last iteration
        if(n==1 && n~=N)
            sx = [sx;xfl;xl;xb;xr];
            sy = [sy;yfl;yl;yb;yr;];
        elseif(n==1 && n==N)
            sx = [sx;xfl;xl;xb;xr;xfr];
            sy = [sy;yfl;yl;yb;yr;yfr];            
        % last iteration
        elseif(n==N)
            sx = [sx;xf;xl;xb;xr;xfr];
            sy = [sy;yf;yl;yb;yr;yfr];
        % in between 
        else
            sx = [sx;xf;xl;xb;xr];
            sy = [sy;yf;yl;yb;yr;];
        end
    end
%-------------------------------------------------------------------------%    
end
    