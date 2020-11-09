clear all; close all; clc;

% DATE: 10-21-2020

% Nxy1 N1
%
load('L11_circ_r5mm_30AWG_Nxy1_N1_matlab.mat');

figure(1)
title('t')
subplot(3,2,1);
H=plot(NN,L11_circ_r5mm_30AWG_Nxy1_N1/1e-9,'.-');
xlabel('Resolution^2 in XY Plane');
ylabel('L11[nH]');
%title('Nxy:1 N:1');
title('Calculated at ri');

subplot(3,2,2);
H=plot(NN,L11_wT2_circ_r5mm_30AWG_Nxy1_N1/1e-9,'.-');
xlabel('Resolution^2 in XY Plane');
ylabel('L11[nH]');
title('Calculated at ri-wT/2');

subplot(3,2,3);
H=plot(NN,L11_wT4_circ_r5mm_30AWG_Nxy1_N1/1e-9,'.-');
xlabel('Resolution^2 in XY Plane');
ylabel('L11[nH]');
title('Calculated at ri-wT/4');

subplot(3,2,4);
H=plot(NN,L11_wT50_circ_r5mm_30AWG_Nxy1_N1/1e-9,'.-');
xlabel('Resolution^2 in XY Plane');
ylabel('L11[nH]');
title('Calculated at ri-wT/50');

subplot(3,2,5);
H=plot(NN,L11_wT75_circ_r5mm_30AWG_Nxy1_N1/1e-9,'.-');
xlabel('Resolution^2 in XY Plane');
ylabel('L11[nH]');
title('Calculated at ri-wT/75');

subplot(3,2,6);
H=plot(NN,L11_wT100_circ_r5mm_30AWG_Nxy1_N1/1e-9,'.-');
xlabel('Resolution^2 in XY Plane');
ylabel('L11[nH]');
title('Calculated at ri-wT/100');

suptitle('Circle d:10mm Nxy:1 N:1');
%}

% Nxy1 N2
%{
load('L11_circ_r5mm_30AWG_Nxy1_N2_matlab.mat');

figure(1)
title('t')
subplot(3,2,1);
H=plot(NN,L11_circ_r5mm_30AWG_Nxy1_N2/1e-9,'.-');
xlabel('Resolution^2 in XY Plane');
ylabel('L11[nH]');
%title('Nxy:1 N:1');
title('Calculated at ri');

subplot(3,2,2);
H=plot(NN,L11_wT2_circ_r5mm_30AWG_Nxy1_N2/1e-9,'.-');
xlabel('Resolution^2 in XY Plane');
ylabel('L11[nH]');
title('Calculated at ri-wT/2');

subplot(3,2,3);
H=plot(NN,L11_wT4_circ_r5mm_30AWG_Nxy1_N2/1e-9,'.-');
xlabel('Resolution^2 in XY Plane');
ylabel('L11[nH]');
title('Calculated at ri-wT/4');

subplot(3,2,4);
H=plot(NN,L11_wT50_circ_r5mm_30AWG_Nxy1_N2/1e-9,'.-');
xlabel('Resolution^2 in XY Plane');
ylabel('L11[nH]');
title('Calculated at ri-wT/50');

subplot(3,2,5);
H=plot(NN,L11_wT75_circ_r5mm_30AWG_Nxy1_N2/1e-9,'.-');
xlabel('Resolution^2 in XY Plane');
ylabel('L11[nH]');
title('Calculated at ri-wT/75');

subplot(3,2,6);
H=plot(NN,L11_wT100_circ_r5mm_30AWG_Nxy1_N2/1e-9,'.-');
xlabel('Resolution^2 in XY Plane');
ylabel('L11[nH]');
title('Calculated at ri-wT/100');

suptitle('Circle d:10mm N:2 Nxy:1');
%}

% Nxy1 N3
%{
load('L11_circ_r5mm_30AWG_Nxy1_N3_matlab.mat');

figure(1)
title('t')
subplot(3,2,1);
H=plot(NN,L11_circ_r5mm_30AWG_Nxy1_N3/1e-9,'.-');
xlabel('Resolution^2 in XY Plane');
ylabel('L11[nH]');
%title('Nxy:1 N:1');
title('Calculated at ri');

subplot(3,2,2);
H=plot(NN,L11_wT2_circ_r5mm_30AWG_Nxy1_N3/1e-9,'.-');
xlabel('Resolution^2 in XY Plane');
ylabel('L11[nH]');
title('Calculated at ri-wT/2');

subplot(3,2,3);
H=plot(NN,L11_wT4_circ_r5mm_30AWG_Nxy1_N3/1e-9,'.-');
xlabel('Resolution^2 in XY Plane');
ylabel('L11[nH]');
title('Calculated at ri-wT/4');

subplot(3,2,4);
H=plot(NN,L11_wT50_circ_r5mm_30AWG_Nxy1_N3/1e-9,'.-');
xlabel('Resolution^2 in XY Plane');
ylabel('L11[nH]');
title('Calculated at ri-wT/50');

subplot(3,2,5);
H=plot(NN,L11_wT75_circ_r5mm_30AWG_Nxy1_N3/1e-9,'.-');
xlabel('Resolution^2 in XY Plane');
ylabel('L11[nH]');
title('Calculated at ri-wT/75');

subplot(3,2,6);
H=plot(NN,L11_wT100_circ_r5mm_30AWG_Nxy1_N3/1e-9,'.-');
xlabel('Resolution^2 in XY Plane');
ylabel('L11[nH]');
title('Calculated at ri-wT/100');

suptitle('Circle d:10mm N:3 Nxy:1');
%}

% Nxy2 N1
%{
load('L11_circ_r5mm_30AWG_Nxy2_N1_matlab.mat');

figure(1)
title('t')
subplot(3,2,1);
H=plot(NN,L11_circ_r5mm_30AWG_Nxy2_N1/1e-9,'.-');
xlabel('Resolution^2 in XY Plane');
ylabel('L11[nH]');
%title('Nxy:1 N:1');
title('Calculated at ri');

subplot(3,2,2);
H=plot(NN,L11_wT2_circ_r5mm_30AWG_Nxy2_N1/1e-9,'.-');
xlabel('Resolution^2 in XY Plane');
ylabel('L11[nH]');
title('Calculated at ri-wT/2');

subplot(3,2,3);
H=plot(NN,L11_wT4_circ_r5mm_30AWG_Nxy2_N1/1e-9,'.-');
xlabel('Resolution^2 in XY Plane');
ylabel('L11[nH]');
title('Calculated at ri-wT/4');

subplot(3,2,4);
H=plot(NN,L11_wT50_circ_r5mm_30AWG_Nxy2_N1/1e-9,'.-');
xlabel('Resolution^2 in XY Plane');
ylabel('L11[nH]');
title('Calculated at ri-wT/50');

subplot(3,2,5);
H=plot(NN,L11_wT75_circ_r5mm_30AWG_Nxy2_N1/1e-9,'.-');
xlabel('Resolution^2 in XY Plane');
ylabel('L11[nH]');
title('Calculated at ri-wT/75');

subplot(3,2,6);
H=plot(NN,L11_wT100_circ_r5mm_30AWG_Nxy2_N1/1e-9,'.-');
xlabel('Resolution^2 in XY Plane');
ylabel('L11[nH]');
title('Calculated at ri-wT/100');

suptitle('Circle d:10mm Nxy:2 N:1');
%}

% Nxy2 N2
%{
load('L11_circ_r5mm_30AWG_Nxy2_N2_matlab.mat');

figure(1)
subplot(3,2,1);
H=plot(NN,L11_circ_r5mm_30AWG_Nxy2_N2/1e-9,'.-');
xlabel('Resolution^2 in XY Plane');
ylabel('L11[nH]');
%title('Nxy:1 N:1');
title('Calculated at ri');

subplot(3,2,2);
H=plot(NN,L11_wT2_circ_r5mm_30AWG_Nxy2_N2/1e-9,'.-');
xlabel('Resolution^2 in XY Plane');
ylabel('L11[nH]');
title('Calculated at ri-wT/2');

subplot(3,2,3);
H=plot(NN,L11_wT4_circ_r5mm_30AWG_Nxy2_N2/1e-9,'.-');
xlabel('Resolution^2 in XY Plane');
ylabel('L11[nH]');
title('Calculated at ri-wT/4');

subplot(3,2,4);
H=plot(NN,L11_wT50_circ_r5mm_30AWG_Nxy2_N2/1e-9,'.-');
xlabel('Resolution^2 in XY Plane');
ylabel('L11[nH]');
title('Calculated at ri-wT/50');

subplot(3,2,5);
H=plot(NN,L11_wT75_circ_r5mm_30AWG_Nxy2_N2/1e-9,'.-');
xlabel('Resolution^2 in XY Plane');
ylabel('L11[nH]');
title('Calculated at ri-wT/75');

subplot(3,2,6);
H=plot(NN,L11_wT100_circ_r5mm_30AWG_Nxy2_N2/1e-9,'.-');
xlabel('Resolution^2 in XY Plane');
ylabel('L11[nH]');
title('Calculated at ri-wT/100');

suptitle('Circle d:10mm Nxy:2 N:2');
%}


% Nxy2 N3
%{
load('L11_circ_r5mm_30AWG_Nxy2_N3_matlab.mat');

figure(1)
subplot(3,2,1);
H=plot(NN,L11_circ_r5mm_30AWG_Nxy2_N3/1e-9,'.-');
xlabel('Resolution^2 in XY Plane');
ylabel('L11[nH]');
%title('Nxy:1 N:1');
title('Calculated at ri');

subplot(3,2,2);
H=plot(NN,L11_wT2_circ_r5mm_30AWG_Nxy2_N3/1e-9,'.-');
xlabel('Resolution^2 in XY Plane');
ylabel('L11[nH]');
title('Calculated at ri-wT/2');

subplot(3,2,3);
H=plot(NN,L11_wT4_circ_r5mm_30AWG_Nxy2_N3/1e-9,'.-');
xlabel('Resolution^2 in XY Plane');
ylabel('L11[nH]');
title('Calculated at ri-wT/4');

subplot(3,2,4);
H=plot(NN,L11_wT50_circ_r5mm_30AWG_Nxy2_N3/1e-9,'.-');
xlabel('Resolution^2 in XY Plane');
ylabel('L11[nH]');
title('Calculated at ri-wT/50');

subplot(3,2,5);
H=plot(NN,L11_wT75_circ_r5mm_30AWG_Nxy2_N3/1e-9,'.-');
xlabel('Resolution^2 in XY Plane');
ylabel('L11[nH]');
title('Calculated at ri-wT/75');

subplot(3,2,6);
H=plot(NN,L11_wT100_circ_r5mm_30AWG_Nxy2_N3/1e-9,'.-');
xlabel('Resolution^2 in XY Plane');
ylabel('L11[nH]');
title('Calculated at ri-wT/100');

suptitle('Circle d:10mm Nxy:2 N:3');
%}