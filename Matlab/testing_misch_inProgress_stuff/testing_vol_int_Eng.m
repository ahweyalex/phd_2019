clc; 
I = 1;
% SET VARIABLES
% permeability of free space
u0 = 4*pi*10^(-7); % [H/m]
% spatial points
X = SELF_IND.X;
Y = SELF_IND.Y;
Z = SELF_IND.Z;
% BField values
BX = SELF_IND.BX;
BY = SELF_IND.BY;
BZ = SELF_IND.BZ;
% del x, del y, del z
% assumes uniform spacing 
delx = abs( X(1,1,1) - X(1,2,1) );
dely = abs( Y(1,1,1) - Y(2,1,1) );
delz = abs( Z(1,1,1) - Z(1,1,2) );
res  = delx*dely*delz;
%% 1) 
% B    = BX + BY + BZ; 
% WM   = (1/(2*u0)).*(B.^2).*res;  
% Wm   = sum(WM,'all');
%% 2)
% B    = BX.^2 + BY.^2 + BZ.^2; 
% WM   = (1/(2*u0)).*(B).*res;  
% Wm   = sum(WM,'all');
%% 3)
% B    = abs(BX).^2 + abs(BY).^2 + abs(BZ).^2; 
% WM   = (1/(2*u0)).*(B).*res;  
% Wm   = sum(WM,'all');
%% 4)
% B    = (abs(BX).^2).*res + (abs(BY).^2).*res + (abs(BZ).^2).*res; 
% WM   = (1/(2*u0)).*(B);  
% Wm   = sum(WM,'all');
%% 5)
% mBX = abs(BX).^2;
% mBY = abs(BY).^2; 
% mBZ = abs(BZ).^2;
% mBX_r = (1/u0).*(mBX.*res);
% mBY_r = (1/u0).*(mBY.*res);
% mBZ_r = (1/u0).*(mBZ.*res);
% sumBX = sum(mBX_r,'all');
% sumBY = sum(mBY_r,'all');
% sumBZ = sum(mBZ_r,'all');
% Wm = (1/2).*(sumBX + sumBY + sumBZ);
%% 6)
% mBX = abs(sum(BX,'all')).^2;
% mBY = abs(sum(BY,'all')).^2; 
% mBZ = abs(sum(BZ,'all')).^2;
% mBX_r = (1/u0).*(mBX.*res);
% mBY_r = (1/u0).*(mBY.*res);
% mBZ_r = (1/u0).*(mBZ.*res);
% Wm = (1/2).*(sumBX + sumBY + sumBZ);
%% 7)
% mBX = abs(sum(BX.*res,'all')).^2;
% mBY = abs(sum(BY.*res,'all')).^2; 
% mBZ = abs(sum(BZ.*res,'all')).^2;
% mBX_r = (1/u0).*(mBX);
% mBY_r = (1/u0).*(mBY);
% mBZ_r = (1/u0).*(mBZ);
% Wm = (1/2).*(sumBX + sumBY + sumBZ);
%% 8)
% mB = sum(BX,'all') + sum(BY,'all') + sum(BZ,'all');
% B2 = mB.^2;
% Wm = (1/(2.*u0)).*B2.*res;
%% 9)
mB = sum(BX.*res,'all') + sum(BY.*res,'all') + sum(BZ.*res,'all');
B2 = mB.^2;
Wm = (1/(2.*u0)).*B2;
%% 10) 
% sz   = size(BX);
% Odel = O.*delx.*dely.*delz;
% sumOdel = sum(Odel,'all');
% O    = ones(sz);
% OO   = O.*res + O.*res + O.*res;
% sumO = sum(OO,'all');
% v = sumO
% w = abs(xminb11 - xmaxb11); % [mm]
% l = abs(yminb11 - ymaxb11); % [mm]
% height = abs(zminb11 - zmaxb11); % [mm]
% V = w*l*height
% L11  = (2.*Wm)./(I.^2);
%% 11)
