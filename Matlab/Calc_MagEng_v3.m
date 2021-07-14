
%function [Wm, L11] = Calc_MagEng_v3(SELF_IND, ANT1, I, SEL)
function [Wm, L11] = Calc_MagEng_v3(SELF_IND, ANT1, A, I1, SEL)
    % permeability of free space
    u0 = 4*pi*10^(-7); % [H/m]
    zn = 1; 
    % all points 
    BX0 = SELF_IND.BX; % (all) x-directed b-fields 
    BY0 = SELF_IND.BY; % (all) y-directed b-fields 
    BZ0 = SELF_IND.BZ; % (all) z-directed b-fields 
    X0  = SELF_IND.X;  % (all) b-fields' x-dir spatial location
    Y0  = SELF_IND.Y;  % (all) b-fields' y-dir spatial location
    Z0  = SELF_IND.Z;  % (all) b-fields' y-dir spatial location
    % vector magnetic potential
    AXH = A.AXH;
    AYH = A.AYH;
    AZH = A.AZH;
    
    % a single (XY) plane 
    BX = squeeze(SELF_IND.BX(:,:,zn)); % x-directed b-fields 
    BY = squeeze(SELF_IND.BY(:,:,zn)); % y-directed b-fields 
    BZ = squeeze(SELF_IND.BZ(:,:,zn)); % z-directed b-fields 
    X  = squeeze(SELF_IND.X(:,:,zn));  % b-fields' x-dir spatial location
    Y  = squeeze(SELF_IND.Y(:,:,zn));  % b-fields' y-dir spatial location
    
    NXY  = ANT1.NXY;
    N    = ANT1.N;
    % deltas 
    [Ny, Nx, Nz] = size(X0);
    xdis = abs( X0(1,1,1) - X0(1,end,1) );
    ydis = abs( Y0(1,1,1) - Y0(end,1,1) );
    zdis = abs( Z0(1,1,1) - Z0(1,1,end) );
    xdel = xdis/Nx; 
    ydel = ydis/Ny; 
    zdel = zdis/Nz;
    dv   = xdel*ydel*zdel;
    % set up spatial location 
    if(SEL=='c' || SEL=='C' || SEL=='e' || SEL=='E') % ellipse
        rx = ANT1.ra;
        ry = ANT1.ri;
        %rx = ANT1.ri;
        %ry = ANT1.ra;
        ANT_LOC = ((X./rx).^2 + (Y./ry).^2 ) <=1;
    elseif(SEL=='r' || SEL=='R' || SEL=='s' || SEL=='S') % rectangle
        rx = ANT1.ri;
        ry = ANT1.ra;
        x1 = -rx/2;
        x2 =  rx/2;
        y1 = -ry/2;
        y2 =  ry/2; 
        ANT_LOC = (X>=x1 & X<=x2 & Y>=y1 & Y<=y2); 
    end

% plotting to check if its obtaining the correct locations 
[nx, ny] = size(X);
nX = reshape(X,nx*ny,1)./1e-3;
nY = reshape(Y,nx*ny,1)./1e-3;
FS = 12;
figure(100)
H1 = imagesc(nX,nY,ANT_LOC.');
axis equal tight;
xlabel('x samples [mm]','FontSize', FS, 'Color', 'r',...
    'FontWeight', 'bold');
ylabel('y samples [mm]','FontSize', FS, 'Color', 'g',...
    'FontWeight', 'bold');
title('','FontSize', FS, 'Color', 'g',...
    'FontWeight', 'bold');
grid on;
%     WM = 0;
%     for nz=1:Nz
%         BNX   = BX(:,:,zn);
%         BNY   = BY(:,:,zn);
%         BNZ   = BZ(:,:,zn);
%         [idx] = find(ANT_LOC)';    % indices where b-fields are located
%         BFx   = BNX(idx);
%         BFy   = BNY(idx);
%         BFz   = BNZ(idx);
%         BF2   = (BFx).^2 + (BFy).^2 + (BFz).^2;
%         % EQU: Wm = (1/2) int_(B^2/mu0) dv'
%         WM = WM + (1/u0).*(1/2).*sum(BF2,'all').*res
%         nz
%     end
%   Wm  = WM;
    
    BF2 = (BX0).^2 + (BY0).^2 + (BZ0).^2;
    Wm  = (1/u0).*(1/2).*sum(BF2.*dv,'all');
    L11 = (2*Wm)./(I.^2);
    t = 't';

%     WM = zeros([Ny Nx Nz]);
%     WM2 = 0;    
%     for nx=1:Nx
%         for ny=1:Ny
%             for nz=1:Nz
%                 WM(ny,nx,nz) = (0.5)*(1/u0)*dv*...
%                     (BX0(ny,nx,nz)^2 + ...
%                      BY0(ny,nx,nz)^2 + ...
%                      BZ0(ny,nx,nz)^2);
%                  %WM2 = WM2 + WM(ny,nx,nz);
%             end
%         end
%     end
%     sumWM = sum(Wm,'all');
%     %sumWM2 = sum(sum(sum(Wm,1),2),3);
%     L = (2*sumWM)./(I.^2);
    t = 't';
end