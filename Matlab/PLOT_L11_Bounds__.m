
%%
%-------------------------------circle/rect------------------------------------%
%
%clear all; close all; clc;
%NN = 19:220;
NN=19:1005;
%NN =1000:1004; 
%load('L11_ci_10mm_NN19to1004.mat');
figure(1)
%H = plot(NN,abs(L11_circ_r5mm)./1e-9,'.-');
%H = plot(NN,abs(L11_circ_r10mm)./1e-9,'.-');
H = plot(NN,abs(L11_sq_L5mm)./1e-9,'.-');
%H = plot(L11_circ_r10mm_mWT2./1e-9,'.-');
%title('d5mm');
title('L5mm');
xlabel('XY Resolution^2');
ylabel('L11[nH]');
grid on;

figure(2)
%H = plot(NN,abs(L11_wT2_circ_r5mm)./1e-9,'.-');
%H = plot(NN,abs(L11_wT2_circ_r10mm)./1e-9,'.-');
H = plot(NN,abs(L11_wT2_sq_L5mm)./1e-9,'.-');
%H = plot(L11_wT2_circ_r10mm_mWT2./1e-9,'.-');
%title('d5mm - wT/2');
title('L5mm +/- wT/2');
xlabel('XY Resolution^2');
ylabel('L11[nH]');
grid on;

figure(3)
%H = plot(NN,abs(L11_wT4_circ_r5mm)./1e-9,'.-');
%H = plot(NN,abs(L11_wT4_circ_r10mm)./1e-9,'.-');
H = plot(NN,abs(L11_wT4_sq_L5mm)./1e-9,'.-');
%H = plot(L11_wT4_circ_r10mm_mWT2./1e-9,'.-');
%title('d5mm - wT/4');
title('L5mm +/- wT/4');
xlabel('XY Resolution^2');
ylabel('L11[nH]');
grid on;

figure(4)
%H = plot(NN,abs(L11_wT50_circ_r5mm)./1e-9,'.-');
%H = plot(NN,abs(L11_wT50_circ_r10mm)./1e-9,'.-');
H = plot(NN,abs(L11_wT50_sq_L5mm)./1e-9,'.-');
%H = plot(L11_wT4_circ_r10mm_mWT2./1e-9,'.-');
%title('d5mm - wT/50');
title('L5mm +/- wT/50');
xlabel('XY Resolution^2');
ylabel('L11[nH]');
grid on;

figure(5)
%H = plot(NN,abs(L11_wT75_circ_r5mm)./1e-9,'.-');
%H = plot(NN,abs(L11_wT75_circ_r10mm)./1e-9,'.-');
H = plot(NN,abs(L11_wT75_sq_L5mm)./1e-9,'.-');
%H = plot(L11_wT4_circ_r10mm_mWT2./1e-9,'.-');
%title('d5mm - wT/75');
title('L5mm +/- wT/75');
xlabel('XY Resolution^2');
ylabel('L11[nH]');
grid on;

figure(6)
%H = plot(NN,abs(L11_wT100_circ_r5mm)./1e-9,'.-');
%H = plot(NN,abs(L11_wT100_circ_r10mm)./1e-9,'.-');
H = plot(NN,abs(L11_wT100_sq_L5mm)./1e-9,'.-');
%H = plot(L11_wT4_circ_r10mm_mWT2./1e-9,'.-');
%title('d5mm - wT/100');
title('L5mm +/- wT/100');
xlabel('XY Resolution^2');
ylabel('L11[nH]');
grid on;
%}