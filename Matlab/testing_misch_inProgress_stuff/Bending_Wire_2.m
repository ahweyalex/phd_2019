% Alexander Moreno
% DATE: 06-19-2021
% ver: 0.2
%
% description: going to "bend" coil 

clear all; close all; clc;
%%
%=========================================================================%
%%-------------------MULTI-LAYER COIL PARAMETERS-------------------------%%
%=========================================================================%
Nxy1    = 1;            % number of coils <scalar>
%N       = 9;            % number of turns in z-direction <scalar>
N       = 3;            % number of turns in z-direction <scalar>
ra1     = 10e-3;        % y-axis <scalar> [m]
ri1     = 15e-3;        % x-axis <scalar> [m]
%=========================================================================%
wT      = 0.2546e-3;    % 30AWG wire gauge <scalar> [m]
%O       = 0;            % starting orientation: <scalar> [unitless] 1/0
O       = 1;            % rect
I1      = 1;            % current <scalar> [A]
u0      = 4*pi*10^-7;   % free space permeability <scalar> [H/m]
L1      = ra1;          % y-axis <scalar> [m]
W1      = ri1;          % x-axis <scalar> [m]
%=========================================================================%
numSeg  = 200*6*N;          % number of points along each coil <scalar>
gap     = 0;            % gap <scalar> [m]
h       = wT*0.35;      % height of structure
zEnd    = N*2*pi*h;     % final z-value 
ANT1    = struct('NXY',Nxy1,'N',N,'ra',ra1,'ri',ri1);
%=========================================================================%
% self-inductance
X11=[];Y11=[];Z11=[]; BX11=[];BY11=[];BZ11=[];
SELF_IND = struct('X11',  X11,'Y11',  Y11,'Z11',  Z11,...
                  'BX11',BX11,'BY11',BY11,'BZ11',BZ11);
%
%=========================================================================%
%%--------------------------CONSTRUCT COIL--------------------------------%%
%=========================================================================%
SEL1='e';  % indicator for ellipse self or mutual inductance 
[sx30,sy30,sz30] = constrCircWire(h,ra1,ri1,numSeg,N,O,wT,Nxy1);
%=========================================================================%
%%-----------------------<<NEW CODE: BENDING>>---------------------------%%
%=========================================================================%
clc; close all;
NUM4   = floor(((numel(sz30)/N)/Nxy1)/4);
bRad   = 5e-3; % [m]
bR     = linspace(0,bRad,NUM4); 
%angle  = pi*(2/3);
angle  = pi*(2/3);
bCurv0 =  bR.*sin(linspace(0,angle,NUM4));
%bCurv0 =  bRad.*sin(linspace(0,angle,NUM4));
bCurv1 =  fliplr(bCurv0);
dir   = 0; 
count = 1; 
for idx=1:numel(sx30)
    if(dir==0)     % go up
        szB(idx) = sz30(idx) + bCurv1(count);
        count = count + 1;
        if(count==NUM4)
            dir=1;
            count = 1; 
        end
        
    elseif(dir==1) % go down
        szB(idx) = sz30(idx) + bCurv0(count);
        count = count+1;
        if(count==NUM4)
            dir=0;
            count = 1;
        end        
    end
end

%
%=========================================================================%
%%-----------------------------PlOTTING----------------------------------%%
%=========================================================================%
FS=10;
hold all;
figure(1)
%subplot(1,2,1);
H1 = plot3(sx30./1e-3, sy30./1e-3, sz30./1e-3);
set(H1(1),'color','b'); 
xlabel('x[mm]','FontSize', FS, 'Color', 'r', 'FontWeight', 'bold'); 
ylabel('y[mm]','FontSize', FS, 'Color', 'g', 'FontWeight', 'bold'); 
zlabel('z[mm]','FontSize', FS, 'Color', 'b', 'FontWeight', 'bold');
title('Example Nxy:1 N:3','FontSize', FS,...
    'FontWeight', 'bold');
axis equal
%view(140,45); 
view(133,6); 
grid on;
figure(2)
%subplot(1,2,2);
H2 = plot3(sx30./1e-3,sy30./1e-3,szB./1e-3,'-');
set(H2(1),'color','r'); 
xlabel('x[mm]','FontSize', FS, 'Color', 'r', 'FontWeight', 'bold'); 
ylabel('y[mm]','FontSize', FS, 'Color', 'g', 'FontWeight', 'bold'); 
zlabel('z[mm]','FontSize', FS, 'Color', 'b', 'FontWeight', 'bold');
title('Example Nxy:1 N:3','FontSize', FS,...
    'FontWeight', 'bold');
axis equal
%view(140,45);
view(133,6); 
grid on;
%}
hold on;