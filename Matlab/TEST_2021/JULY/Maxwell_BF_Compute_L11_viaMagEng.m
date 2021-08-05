clear all; close all; clc;
%Nx = 201; Ny = 301; Nz = 101;
%BFM = importdata('bf2_200_300_100.fld');
%Nx = 201; Ny = 201; Nz = 201;
%BFM = importdata('bf2_200_200_200.fld');
Nx = 201; Ny = 201; Nz = 201;
BFM = importdata('bf_201_201_201_BDLZ40mm_BDUZ40mm.fld');

%Nx = 201; Ny = 201; Nz = 201;
%BFM = importdata('bf_201_201_201_BDL30mm_BDU30mm.fld');
%Nx = 301; Ny = 301; Nz = 301;
%BFM = importdata('bf_301_301_301_BDL30mm_BDU30mm.fld');

%%
X    = reshape(BFM.data(:,1),Nz,Ny,Nx);
Y    = reshape(BFM.data(:,2),Nz,Ny,Nx);
Z    = reshape(BFM.data(:,3),Nz,Ny,Nx);
BX11 = reshape(BFM.data(:,4),Nz,Ny,Nx);
BY11 = reshape(BFM.data(:,5),Nz,Ny,Nx);
BZ11 = reshape(BFM.data(:,6),Nz,Ny,Nx);
%% bounds 
% lower bounds
xminb11 = min(X,[],'all');
yminb11 = min(Y,[],'all');
zminb11 = min(Z,[],'all');
% upper bounds 
xmaxb11 = max(X,[],'all');
ymaxb11 = max(Y,[],'all');
zmaxb11 = max(Z,[],'all');
%% INPUTS
%----------------------------INPUTS:LOOP1---------------------------------%
wT      = 0.2546e-3;    % 30AWG wire gauge <scalar> [m]
%O       = 0;            % starting orientation: <scalar> [unitless] 1/0
O       = 1;            % rect
I1      = 1;            % current <scalar> [A]
u0      = 4*pi*10^-7;   % free space permeability <scalar> [H/m]
ra1     = 10e-3;        % y-axis <scalar> [m]
ri1     = 15e-3;        % x-axis <scalar> [m]
L1      = ra1;          % y-axis <scalar> [m]
W1      = ri1;          % x-axis <scalar> [m]
%=========================================================================%
Nxy1    = 1;            % number of coils <scalar>
N       = 3;            % number of turns in z-direction <scalar>
%=========================================================================%
numSeg  = 200*6*N;          % number of points along each coil <scalar>
gap     = 0;            % gap <scalar> [m] 
h       = wT*0.35;      % height of structure
zEnd    = N*2*pi*h;     % final z-value 
%zEnd    = 10e-3;
ANT1    = struct('NXY',Nxy1,'N',N,'ra',ra1,'ri',ri1);
%--------------------------CONSTRUCT:LOOP1--------------------------------%
%%% ANT 1
SEL1='e';  % indicator for ellipse self or mutual inductance 
[sx30,sy30,sz30] = constrCircWire(h,ra1,ri1,numSeg,N,O,wT,Nxy1);
%=========================================================================%
%=========================================================================%
%------------------------[[REPLACES CALCBSLOW]]---------------------------%
I    = I1;                  % Current 
mu0  = 4*pi*1e-7;           % Free space permeability <scalar> [H/m]
coef = (mu0*I)/(4*pi);      %
S    = [sx30,sy30,sz30]';   % Source/Ant 
[dl] = compute_dl(S);       % Compute delta l 
% vector magnetic potential 
A0 = 0;
AX = zeros(Nz,Ny,Nx);
AY = zeros(Nz,Ny,Nx);
AZ = zeros(Nz,Ny,Nx);
% Compute vector magnetic potential 
for yn=1:Ny             % iterate y-points (points of interest)
    for xn=1:Nx         % iterate x-points (points of interest)
        for zn=1:Nz     % iterate z-points (points of interest)
            r     = [X(zn,yn,xn);Y(zn,yn,xn);Z(zn,yn,xn)]; 
            Rdiff = r - S;  % Calc R (distance betweewn source and 
            % point of interest)
            R  = (realsqrt(sum(Rdiff.^2,1))).^3; % |R|^3
            AR = realsqrt(sum(Rdiff.^2,2)); % 1/R 
            A0 = coef*sum(dl./AR,2);
            AX(zn,yn,xn) = A0(1);
            AY(zn,yn,xn) = A0(2);
            AZ(zn,yn,xn) = A0(3);            
        end % END: Z
    end % END: X
    % prints progress
    if(mod(yn,10)==0)
        disp(strcat(num2str(yn),'/',num2str(Ny)));
    end
end % END: Y
[siZ,siY,siX]=size(AX)
%%
X11 = X;
Y11 = Y;
Z11 = Z;
SELF_IND = struct('X',  X11, 'Y', Y11, 'Z',Z11,...
                  'BX',BX11,'BY',BY11,'BZ',BZ11);
%------------------------[[COMPUTE L11 VIA MAG_ENG]]----------------------%
% compute self indutance via mag energy 
disp('threeMulti');
[AXH,AYH,AZH] = ThreeMulti_cross(AX,AY,AZ,BX11,BY11,BZ11);
AcrossH = struct('AXH',AXH,'AYH',AYH,'AZH',AZH);
%%
SEL = 'E';
%[Wm, L11] = Calc_MagEng_v3(SELF_IND, ANT1, A, I1, SEL);
[Wm,WMA,WMB,L11] = Calc_MagEng_v5(SELF_IND, ANT1, AcrossH, I1, SEL)
disp('done');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                            <<FUNCTIONS>>
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                          [[Description]]                                % 
%   Computes the delta l (delta_x,delta_y,delta_z) that will be used in the
%   cross product in Biot-Savart Law
%=========================================================================%
%                       [[Input Parameters]]                              %
%
% S
% DESCRIPTION: Contains the x, y, and z spatial coordiantes of the source
% (wire antenna) 
% UNITS: N/A or [m] for each element
% DIM: [numSeg by 3]
% EXAMPLE(S):
% S = [Sx,Sy,Sz], where the size of: 
% Sx is [numSeg by 1],Sy is [numSeg by 1],Sz is [numSeg by 1]
% Ex: S = [1, 2, 3;
%          2, 5, 7;
%          3, 4, 9;]
%=========================================================================%
%                       [[Ouput Parameters]]                              % 
% dl
% DESCRIPTION: delta l (contains delta_x, delta_y, and delta_z) by
% approximating the derivates of the adjecent elements within the source
% (the wire antenna)
% UNITS: N/A or [m] for each elment
% DIM: [numSeg by 3]
%=========================================================================%
function [dl] = compute_dl(varargin)
    dl = [];
    for n=1: nargin 
        rn = varargin{n};
        % approximates derivatives of adjecent elements
        dl_n = my_diff(rn);
        dl   = cat(2,dl,dl_n);
    end
end
function [output] = my_diff(v)
    output  = diff(v,1,2);  
    output = cat(2,output,output(:,length(output))); 
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                          [[Description]]                                % 
% Takes the cross product between two (3D) matrices. Assumes both matrices
% size are equal.
%=========================================================================%
%                       [[Input Parameters]]                              %
% A
% DESCRIPTION: (3D) matrix
% UNITS: N/A
% DIM: [numSeg by 3]
% note: when applying to biot-savart A should be dl
%
% B
% DESCRIPTION: (3D) matrix
% UNITS: N/A
% DIM: [numSeg by 3]
% note: when applying to biot-savart B should be R
%=========================================================================%
%                       [[Ouput Parameters]]                              % 
% C
% DESCRIPTION: (3D) matrix
% UNITS: N/A
% DIM: [numSeg by 3]
% note: when applying to biot-savart B should be dB of x,y,and z
%=========================================================================%
function [C] = ThreeDim_cross(A,B)
    % Initialize zero array (decrease time)
    C = zeros(3,length(A));
    % apply cross product between A and B
    C(3, :) = A(1,:).*B(2,:) - A(2,:).*B(1,:);
    C(1, :) = A(2,:).*B(3,:) - A(3,:).*B(2,:);
    C(2, :) = A(3,:).*B(1,:) - A(1,:).*B(3,:);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


