
function [Wm,WMA,WMB,L11] = Calc_MagEng_v4(SELF_IND,ANT1,AcrossH,I,SEL)
    % permeability of free space
    u0 = 4*pi*10^(-7); % [H/m]
    % all points (BFIELDS and spatial) from SELF_IND
    BX0 = SELF_IND.BX; % (all) x-directed b-fields 
    BY0 = SELF_IND.BY; % (all) y-directed b-fields 
    BZ0 = SELF_IND.BZ; % (all) z-directed b-fields 
    X0  = SELF_IND.X;  % (all) b-fields' x-dir spatial location
    Y0  = SELF_IND.Y;  % (all) b-fields' y-dir spatial location
    Z0  = SELF_IND.Z;  % (all) b-fields' y-dir spatial location
    % vector magnetic potential
    AXH = AcrossH.AXH;
    AYH = AcrossH.AYH;
    AZH = AcrossH.AZH;
    % as a single (XY) plane 
%     zn=1;   
%     BX = squeeze(SELF_IND.BX(:,:,zn)); % x-directed b-fields 
%     BY = squeeze(SELF_IND.BY(:,:,zn)); % y-directed b-fields 
%     BZ = squeeze(SELF_IND.BZ(:,:,zn)); % z-directed b-fields 
%     X  = squeeze(SELF_IND.X(:,:,zn));  % b-fields' x-dir spatial location
%     Y  = squeeze(SELF_IND.Y(:,:,zn));  % b-fields' y-dir spatial location
    % Antenna parameters
    NXY  = ANT1.NXY;
    N    = ANT1.N;
    % Deltas
    [Ny, Nx, Nz] = size(X0);
    xdis = abs( X0(1,1,1) - X0(1,end,1) );
    ydis = abs( Y0(1,1,1) - Y0(end,1,1) );
    zdis = abs( Z0(1,1,1) - Z0(1,1,end) );
    xdel = xdis/Nx; 
    ydel = ydis/Ny; 
    zdel = zdis/Nz; 
    %----------------ADD: 07-21-2021------------------%
    ra1 = 10e-3;        % radius in y-axis <scalar> [m]
    dx = (ra1*2)/200;
    dy = dx;
    dz = 0.001679683928168/200; % dz = zEnd/200
    xdel = dx;
    ydel = dy;
    zdel = dz;
    %--------------END: ADD: 07-21-2021---------------%
    %
    dv   = xdel*ydel*zdel;
%==========================[Computation]==================================%
% Wm = (1/2)(1/u0)int_v'[B^2]dv' - (1/2)*int_s'[AxH]*an ds' (6-17)
%      [         WM1           ] - [        WM2           ]    
    % WM1
    B2  = (BX0).^2 + (BY0).^2 + (BZ0).^2;
    WM1 = (1/u0).*(1/2).*B2.*dv;
    WMA = sum(WM1,'all'); 
    t ='t';
    % WM2
    anP = (+1);
    anN = (-1);
    xP  = (anP)*AXH(:,end,:).*(ydel*zdel);   % + xnorm
    xN  = (anN)*AXH(:,1,:)  .*(ydel*zdel);   % - xnorm
    yP  = (anP)*AYH(end,:,:).*(xdel*zdel);   % + ynorm
    yN  = (anN)*AYH(1,:,:)  .*(xdel*zdel);   % - ynorm
    zP  = (anP)*AZH(:,:,end).*(xdel*ydel);   % + znorm
    zN  = (anN)*AZH(:,:,1)  .*(xdel*ydel);   % - znorm
    WMB = (1/2).*sum(xP+yP+zP+xN+yN+zN,'all');
    
    Wm  = WMA - WMB;
    L11 = (2*Wm)/(I.^2);
    t='t';
end
