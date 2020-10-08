%-------------------------------square------------------------------------%
%% 5mm
%{
clear all; close all; clc;
NN=19:1004;
load('L11_sq_5mm_NN19to1004.mat');
figure(1)
H = plot(NN,abs(L11_wT2_sq_r5mm')./1e-9,'.-');
title('Square:5mm +/- wT/2');
xlabel('XY Resolution^2');
ylabel('L11[nH]');
figure(2)
H = plot(NN,abs(L11_sq_r5mm)./1e-9,'.-');
title('Square equal 5mm');
xlabel('XY Resolution^2');
ylabel('L11[nH]');
figure(3)
H = plot(NN,abs(L11_notEq_sq_r5mm)./1e-9,'.-');
title('Square not equal 5mm');
xlabel('XY Resolution^2');
ylabel('L11[nH]');
%}
%% 10mm
%clear all; close all; clc;
%NN=19:1004;
NN=1e3:1e3+4;
%load('L11_sq_10mm_NN19to1004.mat');
figure(1)
H = plot(NN,abs(L11_wT2_sq_r10mm')./1e-9,'.-');
title('Square:10mm +/- wT/2');
xlabel('XY Resolution^2');
ylabel('L11[nH]');
figure(2)
H = plot(NN,abs(L11_sq_r10mm)./1e-9,'.-');
title('Square equal 10mm');
xlabel('XY Resolution^2');
ylabel('L11[nH]');
figure(3)
H = plot(NN,abs(L11_wT4_sq_r10mm)./1e-9,'.-');
title('Square +/- wT/4');
xlabel('XY Resolution^2');
ylabel('L11[nH]');

%%
%-------------------------------circle------------------------------------%
%{
%% 5mm
%clear all; close all; clc;
NN=19:1004;
%load('L11_ci_5mm_NN19to1004.mat');
%
figure(1)
H = plot(NN,abs(L11_circ_r5mm)./1e-9,'.-');
title('Circle:d5mm +/- wT/2');
xlabel('XY Resolution^2');
ylabel('L11[nH]');
figure(2)
H = plot(NN,abs(L11_wT2_circ_r5mm)./1e-9,'.-');
title('Circle d5mm');
xlabel('XY Resolution^2');
ylabel('L11[nH]');
figure(3)
H = plot(NN,abs(L11_wT2_circ_r5mm)./1e-9,'.-');
title('Circle d5mm');
xlabel('XY Resolution^2');
ylabel('L11[nH]');
%% 10mm
%clear all; close all; clc;
%NN=19:1004;
NN =1000:1004; 
%load('L11_ci_10mm_NN19to1004.mat');
figure(1)
%H = plot(NN,abs(L11_circ_r10mm)./1e-9,'.-');
H = plot(abs(L11_circ_r10mm_mwT2)./1e-9,'.-');
title('Circle:d10mm');
xlabel('XY Resolution^2');
ylabel('L11[nH]');
figure(2)
%H = plot(NN,abs(L11_wT2_circ_r10mm)./1e-9,'.-');
H = plot(abs(L11_wT2_circ_r10mm_mwT2)./1e-9,'.-');
title('Circle d10mm +/- wT/2');
xlabel('XY Resolution^2');
ylabel('L11[nH]');
figure(3)
%H = plot(NN,abs(L11_wT4_circ_r10mm)./1e-9,'.-');
H = plot(abs(L11_wT4_circ_r10mm_mwT2)./1e-9,'.-');
title('Circle d10mm +/- wT/4');
xlabel('XY Resolution^2');
ylabel('L11[nH]');
%}