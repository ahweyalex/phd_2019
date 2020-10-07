clear all; close all; clc;
NN=19:1004;
load('L11_sq_5mm_NN19to1004.mat');
%
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
%%
clear all; close all; clc;
NN=19:1004;
load('L11_sq_10mm_NN19to1004.mat');

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
H = plot(NN,abs(L11_notEq_sq_r10mm)./1e-9,'.-');
title('Square not equal 10mm');
xlabel('XY Resolution^2');
ylabel('L11[nH]');