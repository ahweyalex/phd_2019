%% extract measurements

clear all; close all; clc; 
% file names, assumes its already in your matlab path
%d1 = '90KHz_to_110KHz.xlsx';
%d2 = '1KHz_to_16MHz.xlsx';
d1 = 'rad35mm_N14_NXY1__1KHz_16MHZ_inc10KHz.xlsx';
d2 = 'rad35mm_N7_NXY1__1KHz_16MHZ_inc10KHz.xlsx';
%d1 = 'rad35mm_N4_NXY1__1KHz_16MHZ_inc10KHz.xlsx';
% import data into struct
A = importdata(d1);
B = importdata(d2);
% extract useful data into 1D arrays
fA = A.data(:,1); % frequency of A 
fB = B.data(:,1); % frequency of B
iA = A.data(:,5); % imaginary in mOhm of A
iB = B.data(:,5); % imaginary in mOhm of B
XL = iA/1e-3;
% convert imag into ind
L  = XL./(2*pi*fA);
%L_nH = L./1e-9;
% plots
FS = 12; % font size 
figure(1)
H1 = plot(fA./1e3,L);
xlabel('Frequency [KHz]','fontweight','bold','fontsize',FS);
ylabel('Inductance [\mu H]','fontweight','bold','fontsize',FS);
title('Inductance @ 100KHz expected: 27\mu H','fontweight','bold','fontsize',FS);
figure(2)
H1 = plot(fB./1e3,iB./1e-3);
xlabel('Frequency [KHz]','fontweight','bold','fontsize',FS);
ylabel('Imag Impedance','fontweight','bold','fontsize',FS);
title('Impedance Across Frequency','fontweight','bold','fontsize',FS);
%%
clear all; close all; clc;
d1 = 'rad35mm_N3_1KH_10KHz.xlsx';
d2 = 'rad35mm_N3_1KHz_16MHz.xlsx';
% import data into struct
A = importdata(d1);
B = importdata(d2);
% extract useful data into 1D arrays
fA  = A.data(:,1); % frequency of A 
fB  = B.data(:,1); % frequency of B
iA  = A.data(:,5); % imaginary in mOhm of A
iB  = B.data(:,5); % imaginary in mOhm of B
XL  = iA/1e-3;
XLB = iB/1e-3;
% convert imag into ind
L  = XL./(2*pi*fA);
LB  = XLB./(2*pi*fB);

%L_nH = L./1e-9;
% plots
FS = 12; % font size 
figure(1)
H1 = plot(fA./1e3,L);
xlabel('Frequency [KHz]','fontweight','bold','fontsize',FS);
ylabel('Inductance [\mu H]','fontweight','bold','fontsize',FS);
title('Inductance Across Frequency (radius:35.25mm, N:3)',...
    'fontweight','bold','fontsize',FS);
figure(2)
H1 = plot(fB./1e3,iB./1e-3);
xlabel('Frequency [KHz]','fontweight','bold','fontsize',FS);
ylabel('Imag Impedance','fontweight','bold','fontsize',FS);
title('Impedance Across Frequency (radius:35.25mm, N:3)',...
    'fontweight','bold','fontsize',FS);
figure(3)
H1 = plot(fB./1e3,LB);
xlabel('Frequency [KHz]','fontweight','bold','fontsize',FS);
ylabel('Inductance [\mu H]','fontweight','bold','fontsize',FS);
title('Inductance Across Frequency (radius:35.25mm, N:3)',...
    'fontweight','bold','fontsize',FS);