% ra (W0) (x-direction)
%
% ri (L0) (y-direction)
%
function [Sx,Sy,Sz] = singleRectLoop_roundEdge(W0,L0,numSeg,wT,O,c)
    
    N    = numSeg;
    gap  = 0;
    nA   = floor(N/4); % number of segments along each full arms
    nH   = floor(N/8); % number of segments along each halr arms 
    Nth  = floor((N/10));
    xv   = [-L0/2, L0/2];
    yv   = [-W0/2, W0/2];
    r    = 0.1;
    %---------round edges-------%       
    [xc,yc] = roundEdge_Rect(xv,yv,r,Nth);
    % right top corner
    xrtc = xc(:,1);
    yrtc = yc(:,1);
    % left top corner
    xltc = xc(:,2);
    yltc = yc(:,2);
    % right bottom corner
    xrbc = xc(:,4);
    yrbc = yc(:,4);
    % left bottom corner
    xlbc = xc(:,3);
    ylbc = yc(:,3);
    
    xDis = L0/2;
    yDis = W0/2;
    
    nxDis = abs(xltc(end)-xrtc(1));
    nyDis = abs(yrbc(end)-yrtc(1));
    xDis = nxDis;
    yDis = nyDis;
    
    if(O==1)
        % --------feed lines--------%
        % feed left
        xFeedL = linspace(L0,xDis,nH)';
        yFeedL = linspace(-gap,-gap,nH)';
        % feed right        
        xFeedR = linspace(xDis,L0,nH)';
        yFeedR = linspace(gap,gap,nH)';
        % -------- front lines --------%
        % front left arm
        xFL = linspace(xDis,xDis,nH)';
        yFL = linspace(-gap,-yDis,nH)';
        % front right arm
        xFR = linspace(xDis,xDis,nH)';
        yFR = linspace(yDis,gap,nH)';
        % front
        %xF = linspace(xDis,xDis,nA)';
        %yF = linspace(-yDis,yDis,nA)';
        xF = linspace(xrbc(end),xrbc(end),nH)';
        yF = linspace(-yrtc(1),yrtc(1),nH)';
        % -------- other arms ----------%
        % right arm
        %xR = linspace(xDis,-xDis,nA)';
        %yR = linspace(-yDis,-yDis,nA)';
        xR = linspace(xrtc(end),-xrtc(end),nA)';
        yR = linspace(-yrtc(end),-yrtc(end),nA)';
        % back arm
        %xB = linspace(-xDis,-xDis,nA)';
        %yB = linspace(-yDis,yDis,nA)';
        xB = linspace(-xrbc(end),-xrbc(end),nH)';
        yB = linspace(-yrtc(1),yrtc(1),nH)';
        % left arm
        %xL = linspace(-xDis,xDis,nA)';
        %yL = linspace(yDis,yDis,nA)';
        xL = linspace(-xrtc(end),xrtc(end),nA)';
        yL = linspace(yrtc(end),yrtc(end),nA)';
        
        % --------- combine ---------- %
        % combine all arms in the correct order
        %Sx = [xFeedL;xFL;xR;xB;xL;xFR;xFeedR];
        %Sy = [yFeedL;yFL;yR;yB;yL;yFR;yFeedR];
        %Sx = [xF;xR;xB;xL];
        %Sy = [yF;yR;yB;yL];
        Sx = [xF;xrbc;xR;xlbc;xB;xltc;xL;xrtc;];
        Sy = [yF;yrbc;yR;ylbc;yB;yltc;yL;yrtc;];
        Sz = zeros(numel(Sy),1);
        
%         figure(1)
%         H = plot3(Sx,Sy,Sz,'o'); grid on; view(0,90);
%         %hold;
%         %H=plot(xrtc,yrtc, xrbc,yrbc, xltc,yltc, xlbc,ylbc);
%         set(H,'Marker','o');
%         xlabel('x');
%         ylabel('y');
%         
        t = 't';
        
    elseif(O==1)
    end
end