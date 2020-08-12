
function [Sx,Sy,Sz] = singleLoop(W0,L0,N,O,wT)
    
    gap = wT*1;
    nN = floor(N/4);
    n2 = floor(N/8);
    % back
    xBack = linspace(-L0/2,-L0/2,nN)';
    yBack = linspace(-W0/2, W0/2,nN)';
    % front
    xFront = linspace( L0/2, L0/2,nN)';
    yFront = linspace(-W0/2, W0/2,nN)';
    % startL
    xSL = linspace(L0/2,   L0/2, n2)';
    %ySL = linspace(-W0/2,0-gap,  n2)';
    ySL = linspace(0-gap, -W0/2,  n2)';
    % startR
    xSR = linspace(L0/2, L0/2, n2)';
    ySR = linspace(gap,  W0/2, n2)';
    % left arm
    xLarm = linspace(-L0/2,  L0/2, nN)';
    yLarm = linspace(-W0/2, -W0/2, nN)';
    % right arm
    xRarm = linspace(-L0/2,L0/2,nN)';
    yRarm = linspace( W0/2,W0/2,nN)';
    
    %
    % FeedIn
    nF  = 20;
    xFI = linspace(L0/2,L0,nF)';
    yFI = linspace(-gap,-gap,nF)';
    % FeedOut
    xFO = linspace(L0/2,L0,nF)';
    yFO = linspace(gap,gap,nF)';
    %
    % combine
    %Sx = [xFI;xSL;xLarm;xBack;xRarm;xSR;xFO];
    %Sy = [yFI;ySL;yLarm;yBack;yRarm;ySR;yFO];
    %Sz = linspace(0,0,numel(Sy))';
    
    Sx = [xFI;xSL;xLarm;xBack;xRarm;xSR;xFO];
    Sy = [yFI;ySL;yLarm;yBack;yRarm;ySR;yFO];
    Sz = linspace(0,0,numel(Sy))';
    
    %}
    
    %{
    % combine
    Sx = [xFront;xLarm;xBack;xRarm];
    Sy = [yFront;yLarm;yBack;yRarm];
    Sz = linspace(0,0,numel(Sy))';
   
    % thicken wire
    Sx = [(xFront+wT);xLarm;(xBack-wT);xRarm;...
          (xFront-wT);xLarm;(xBack+wT);xRarm;...
           xFront;xLarm;xBack;xRarm;...
           xFront;xLarm;xBack;xRarm];
       
    Sy = [yFront;(yLarm-wT);yBack;(yRarm+wT);...
          yFront;(yLarm+wT);yBack;(yRarm-wT);...
          yFront;yLarm;yBack;yRarm;...
          yFront;yLarm;yBack;yRarm];
      
    Sz = [Sz0;Sz0;Sz0;Sz0;...
          Sz0;Sz0;Sz0;Sz0;...
          (Sz0+wT);(Sz0+wT);(Sz0+wT);(Sz0+wT);...
          (Sz0-wT);(Sz0-wT);(Sz0-wT);(Sz0-wT)];
    %}
end