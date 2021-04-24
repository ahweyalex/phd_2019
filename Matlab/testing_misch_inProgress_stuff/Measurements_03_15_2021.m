clear all; close all; clc;

da = 'rad35mm_N14_NXY1__1KHz_16MHZ_inc10KHz.xlsx';
db = 'rad35mm_N7_NXY1__1KHz_16MHZ_inc10KHz.xlsx';
dc = 'rad35mm_N4_NXY1__1KHz_16MHZ_inc10KHz.xlsx';

A = importdata(da);
B = importdata(db);
C = importdata(dc);

fA = A.data(:,1); % frequency of A 
iA = A.data(:,5); % imaginary in mOhm of A
fB = B.data(:,1); % frequency of B
iB = B.data(:,5); % imaginary in mOhm of B
fC = C.data(:,1); % frequency of B
iC = C.data(:,5); % imaginary in mOhm of B

XLA = iA/1e-3;
LA  = XLA./(2*pi*fA);
XLB = iB/1e-3;
LB  = XLB./(2*pi*fA);
XLC = iC/1e-3;
LC  = XLC./(2*pi*fA);
%
FS = 12; % font size 
figure(1)
H1 = plot(fA./1e6,LA);
xlabel('Frequency [MHz]','fontweight','bold','fontsize',FS);
ylabel('Inductance [\mu H]','fontweight','bold','fontsize',FS);
title('Radius:35.25mm N:14 NXY:1 MATLAB:27.69uH',...
    'fontweight','bold','fontsize',FS);
%%
figure(2)
H2 = plot(fB./1e6,LB);
xlabel('Frequency [MHz]','fontweight','bold','fontsize',FS);
ylabel('Inductance [\mu H]','fontweight','bold','fontsize',FS);
title('Radius:35.25mm N:7 NXY:1 MATLAB:8.57uH',...
    'fontweight','bold','fontsize',FS);

figure(3)
H3 = plot(fC./1e6,LC);
xlabel('Frequency [MHz]','fontweight','bold','fontsize',FS);
ylabel('Inductance [\mu H]','fontweight','bold','fontsize',FS);
title('Radius:35.25mm N:4 NXY:1 MATLAB:3.21uH',...
    'fontweight','bold','fontsize',FS);

%%
% 
% hValue = ; % mm
% cLengthIn = 2.4;
% cDiamIn = 70.5; %mm
% coilUnits = 1e-3;
% nTurns = 14;
% cResult = hValue * 2.54 * coilUnits * cDiamIn
% lResult = (0.5*cDiamIn*coilUnits*0.5*cDiamIn*coilUnits*nTurns*nTurns)/...
%           (9*0.5*cDiamIn*coilUnits +10*cLengthIn*coilUnits)
% %var cResult = (hValue * 2.54 * coilUnits * cDiamIn).toFixed(3);
% 
% %lResult = (0.5 * cDiamIn * coilUnits * 0.5 * cDiamIn * coilUnits * nTurns * nTurns / (9 * 0.5 * cDiamIn * coilUnits + 10 * cLengthIn * coilUnits)).toFixed(3);
%   
%%
%%z = 12.99mm
%XL = 0.0021;
% z = 6.49mm
XL = 0.0144;
F  = 50e3;
L  = XL./(2*pi*F);
L_nH = L/1e-9