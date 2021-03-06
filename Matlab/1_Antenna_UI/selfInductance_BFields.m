% Alexander Moreno
% DATE: 08-18-2020
% DESCRIPTION: Computes the self-inductance of an ellipse or rectangle 
% plane using b-fields normal to that plane 
%
%%                         INPUT PARAMETERS                              %% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% def:
% 
% Nx: the resolution size of the "X-Plane" (Plane 1) value: integer 
% Ny: the resolution size of the "Y-Plane" (Plane 2) value: integer 
% bfields: magnetic fields units:[T] 
%
% [INPUT PARAMETERS]
%
% ri
% Description: the inner most coil's radius along the x-direction,
% rectangle's width (along x-direction)
% UNITS:N/A ARRAY: 1x1 VALUE: INT
%
%
% ra
% Description: the inner most coil's radius along the y-direction,
% rectangle's length (along y-direction)
% UNITS:N/A ARRAY: 1x1 VALUE: INT
%
%
% I
% Description: Current
% UNITS: [A]  ARRAY: 1 by 1
%
%
% X
% Description: "X-Plane" (Plane 1) is matrix that is a result of Matlab's 
% meshgrid function between x and y, where x (Nx by 1) and y (Ny by 1) 
% 1D arrays 
% UNITS: [m]  ARRAY: Ny by Nx
%
%
% Y
% Description: "Y-Plane" (Plane 2) is matrix that is a result of Matlab's 
% meshgrid function  between x and y, where x (Nx by 1) and y (Ny by 1) 
% 1D arrays 
% UNITS: [m]  ARRAY: Ny by Nx
%
%
% BFnorm
% Description: the b-fields vector(s) normal to the "X-Plane" (Plane 1) and 
% "Y-Plane"(Plane 2) planes of interests 
% UNITS: [T]  ARRAY: Ny by Nx
%
%
% G
% Description: Choosing which structure of the inner most coil. The options
% are Ellipse, Circle, Rectangle, Square 
% UNITS: [T]  ARRAY: 1x1 TYPE: String 
% VALUES: ellipse/circle: 'e','E','c','C' or
%         rectangle/square:'R','r','s','S'
%
%%                          OUT PARAMETERS                              %% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% [OUT PARAMETERS]
%
% L11
% Description: Self-indutance from the BFields provided from the user. 
% UNITS: [H]  ARRAY: 1x1 TYPE: double 
%
%function [L11] = selfInductance_BFields(ri,ra,I,X,Y,BFnorm,G)
function [L11] = selfInductance_BFields(wT,ri,ra,I,X,Y,BFnorm,N1,N,Nxy,G)
    L11 = 0;
    u0 = 4*pi*10^-7;        % Permeability of free space
    uc = 1.256629*10^-6;    % Permeability of copper 
    u  = u0*uc;
    xdel  = abs(X(1,1) - X(1,2));  % del x
    ydel  = abs(Y(1,1) - Y(2,1));  % del y
    A     = xdel*ydel;        % Area (ds)
%-------------------------------rectangle---------------------------------%
%    switch G
%        case('r' || 'R' || 's' || 'S')
    if(G=='r' || G=='R' || G=='s' || G=='S')
        if(N1==0)
            x1 = -ri/2;
            x2 =  ri/2;
            y1 = -ra/2;
            y2 =  ra/2;
            R = (X>=x1 & X<=x2 & Y>=y1 & Y<=y2);
%             
%             figure(1)
%             imagesc(xa,ya,R.')
%             axis equal tight;
%             colorbar;
%           
        elseif(N1==1)
            x1 = -ri/2+wT/2;
            x2 =  ri/2-wT/2;
            y1 = -ra/2+wT/2;
            y2 =  ra/2-wT/2;
            R = (X>=x1 & X<=x2 & Y>=y1 & Y<=y2);            
        elseif(N1==2)
            x1 = -ri/2+wT/4;
            x2 =  ri/2-wT/4;
            y1 = -ra/2+wT/4;
            y2 =  ra/2-wT/4;
            R = (X>=x1 & X<=x2 & Y>=y1 & Y<=y2);     
        elseif(N1==3)
            x1 = -ri/2+wT/100;
            x2 =  ri/2-wT/100;
            y1 = -ra/2+wT/100;
            y2 =  ra/2-wT/100;
            R = (X>=x1 & X<=x2 & Y>=y1 & Y<=y2);  
        elseif(N1==4)
            x1 = -ri/2+wT/50;
            x2 =  ri/2-wT/50;
            y1 = -ra/2+wT/50;
            y2 =  ra/2-wT/50;
            R = (X>=x1 & X<=x2 & Y>=y1 & Y<=y2);  
        elseif(N1==5)
            x1 = -ri/2+wT/75;
            x2 =  ri/2-wT/75;
            y1 = -ra/2+wT/75;
            y2 =  ra/2-wT/75;
            R = (X>=x1 & X<=x2 & Y>=y1 & Y<=y2);  
        end
        [r,c] = find(R);
        for n=1:numel(r)
            BF(n) = BFnorm(r(n),c(n))';
        end
        bz    = BF.*A; 
        sumB  = sum(sum(bz,1),2);   % sum of Bz
        phi_11 = abs(sumB);          % phi_11
        L11   = (phi_11/I)*N*Nxy;      % self ind
%--------------------------ellipse----------------------------------------%       
    elseif(G=='c' || G=='C' || G=='e' || G=='E')
        %ra = 15e-3;   % y-axis
        %ri = 10e-3;   % x-axis
            if(N1==0)
                rx = ri;
                ry = ra; 
                %E  = (X./rx).^2 + (Y./ry).^2 <= 1;
                E  = (X./rx).^2 + (Y./ry).^2 <= 1;
%                 figure
%                 imagesc(rx,ry,E.');
%                 title('at ri');
            elseif(N1==1)
                rx = ri-wT/2;
                ry = ra-wT/2;
                E  = (X./rx).^2 + (Y./ry).^2 <= 1;
%                 figure
%                 imagesc(rx,ry,E.');
%                 title('wT/2')
            elseif(N1==2)
                rx = ri-wT/4;
                ry = ra-wT/4;
                E  = (X./rx).^2 + (Y./ry).^2 <= 1;
%                 figure
%                 imagesc(rx,ry,E.');
%                 title('wT/2')
            elseif(N1==3)
                rx = ri-wT/100;
                ry = ra-wT/100;
                E  = (X./rx).^2 + (Y./ry).^2 <= 1;     
            elseif(N1==4)
                rx = ri-wT/50;
                ry = ra-wT/50;
                E  = (X./rx).^2 + (Y./ry).^2 <= 1;         
            elseif(N1==5)
                rx = ri-wT/75;
                ry = ra-wT/75;
                E  = (X./rx).^2 + (Y./ry).^2 <= 1;  
            end
            %E  = (X./rx).^2 + (Y./ry).^2 <= 1;
            [r,c] = find(E);
            [idx] = find(E);
            BF = BFnorm(idx)';           
            %for n=1:numel(r)
            %    BF(n) = BFnorm(r(n),c(n))';
            %end
            
            bz    = BF.*A;
            sumB  = sum(sum(sum(bz,1),2),3);   % sum of Bz
            phi_11 = abs(sumB);             % phi_11
            L11   = (phi_11/I)*N*Nxy;   % self ind         
            t = 't';
    end
