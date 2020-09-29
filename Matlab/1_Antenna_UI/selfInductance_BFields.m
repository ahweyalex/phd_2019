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
% N
% Description: Number of turns along the z-direction
% UNITS: N/A  ARRAY: 1x1 TYPE: Int 
%
% Nx
% Description: Resolution (total number of points along x-direction)
% UNITS: N/A  ARRAY: 1x1 TYPE: Int 
%
% Ny
% Description: Resolution (total number of points along y-direction)
% UNITS: N/A  ARRAY: 1x1 TYPE: Int 
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
%function [L11] = selfInductance_BFields(ri,ra,I,X,Y,BFnorm,N,Nx,Ny,G)
%function [L11,r,c] = selfInductance_BFields(ri,ra,I,X,Y,BFnorm,N,G)
function [L11] = selfInductance_BFields(ri,ra,I,X,Y,BFnorm,N,G)

    L11 = 0;
    %u0 = 4*pi*10^-7;        % Permeability of free space
    %uc = 1.256629*10^-6;    % Permeability of copper 
    %u  = u0*uc;
    xdel  = abs(X(1,1) - X(1,2));  % del x
    ydel  = abs(Y(1,1) - Y(2,1));  % del y
    A     = xdel*ydel;        % Area (ds)

%    switch G
%        case('r' || 'R' || 's' || 'S')
    if(G=='r' || G=='R' || G=='s' || G=='S')
        x1 = -ri/2;
        x2 =  ri/2;
        y1 = -ra/2;
        y2 =  ra/2;
        R = (X>=x1 & X<=x2 & Y>=y1 & Y<=y2);
        %R = (X>x1 & X<x2 & Y>y1 & Y<y2);
        %
        figure
        [Nx,Ny]=size(X);
        x = reshape(X,1,Nx*Nx);
        y = reshape(Y,1,Ny*Ny);
        imagesc(x,y,R.')
        grid on;
        %}
        %R = (X>x1 & X<x2 & Y>y1 & Y<y2);
        [r,c] = find(R);
        %%r = r-1;c = c-1; % just seeing if L11 value at one less index
        %%from ri/ra
        %
        for n=1:numel(r)
            BF(n) = BFnorm(r(n),c(n))';
        end
        bz    = BF.*A; 
        sumB  = sum(sum(bz,1),2);   % sum of Bz
        phi11 = sumB;               % phi_11
        L11   = abs((phi11/I)*N);   % self ind
        
    elseif(G=='c' || G=='C' || G=='e' || G=='E')
            rx = ri;
            ry = ra; 
            E  = (X/rx).^2 + (Y/ry).^2 <= 1;
            %{
            figure
            x = reshape(X,1,Nx*Nx);
            y = reshape(Y,1,Ny*Ny);
            imagesc(x,y,E.')
            grid on;
            %}
            [r,c] = find(E);
            for n=1:numel(r)
                BF(n) = BFnorm(r(n),c(n))';
            end
            bz    = BF.*A;
            sumB  = sum(sum(bz,1),2);   % sum of Bz
            phi11 = sumB;               % phi_11
            L11   = abs((phi11/I)*N);            % self ind            
    end
end