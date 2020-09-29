% ra (W0) (x-direction)
%
% ri (L0) (y-direction)
%
function [Sx,Sy,Sz] = singleRectLoop(W0,L0,numSeg,wT,O)
    
%------------ counter clock wise ( start at 0 then pos x into neg x)
    if(O==1)
        N = numSeg;
        %gap  = wT;
        gap=0;
        nA   = floor(N/4); % number of segments along each full arms
        nH   = floor(N/8); % number of segments along each halr arms 
        xDis = L0/2;
        yDis = W0/2;
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
        xF = linspace(xDis,xDis,nA)';
        yF = linspace(-yDis,yDis,nA)';
        % -------- other arms ----------%
        % right arm
        xR = linspace(xDis,-xDis,nA)';
        yR = linspace(-yDis,-yDis,nA)';
        % back arm
        xB = linspace(-xDis,-xDis,nA)';
        yB = linspace(-yDis,yDis,nA)';
        % left arm
        xL = linspace(-xDis,xDis,nA)';
        yL = linspace(yDis,yDis,nA)';
        % --------- combine ---------- %
        % combine all arms in the correct order
        %Sx = [xFeedL;xFL;xR;xB;xL;xFR;xFeedR];
        %Sy = [yFeedL;yFL;yR;yB;yL;yFR;yFeedR];
        Sx = [xF;xR;xB;xL];
        Sy = [yF;yR;yB;yL];
        Sz = zeros(numel(Sy),1);
        
%------------ clock wise ( start at 0 then neg x into pos x) 
    elseif(O==0) 
        N = numSeg;
        gap  = wT;
        nA   = floor(N/4); % number of segments along each full arms
        nH   = floor(N/8); % number of segments along each halr arms 
        xDis = L0/2;
        yDis = W0/2;
        % --------feed lines--------%
        % feed left
        xFeedL = linspace(L0,xDis,nH)';
        yFeedL = linspace(gap,gap,nH)';
        % feed right        
        xFeedR = linspace(xDis,L0,nH)';
        yFeedR = linspace(-gap,-gap,nH)';
        % -------- front lines --------%
        % front left arm
        xFL = linspace(xDis,xDis,nH)';
        yFL = linspace(gap,yDis,nH)';
        % front right arm
        xFR = linspace(xDis,xDis,nH)';
        yFR = linspace(-yDis,-gap,nH)';
        % -------- other arms ----------%
        % right arm
        xR = linspace(-xDis,xDis,nA)';
        yR = linspace(-yDis,-yDis,nA)';
        % back arm
        xB = linspace(-xDis,-xDis,nA)';
        yB = linspace(yDis,-yDis,nA)';
        % left arm
        xL = linspace(xDis,-xDis,nA)';
        yL = linspace(yDis,yDis,nA)';
        % --------- combine ---------- %
        % combine all arms in the correct order
        Sx = [xFeedL;xFL;xL;xB;xR;xFR;xFeedR];
        Sy = [yFeedL;yFL;yL;yB;yR;yFR;yFeedR];
        Sz = zeros(numel(Sy),1);         
    end
    


end