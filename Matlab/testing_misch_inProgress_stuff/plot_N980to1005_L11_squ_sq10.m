clear all; close all; clc;

% Nxy1 N1
%{
load('L11_squ_s10mm_30AWG_Nxy1_N1');

figure(1)
title('t')
subplot(3,2,1);
H=plot(NN,L11_squ_s10mm_30AWG_Nxy1_N1/1e-9,'.-');
xlabel('Resolution^2 in XY Plane');
ylabel('L11[nH]');
%title('Nxy:1 N:1');
title('Calculated at (ri,ra)');

subplot(3,2,2);
H=plot(NN,L11_wT2_squ_s10mm_30AWG_Nxy1_N1/1e-9,'.-');
xlabel('Resolution^2 in XY Plane');
ylabel('L11[nH]');
title('Calculated at (ri,ra)-wT/2');

subplot(3,2,3);
H=plot(NN,L11_wT4_squ_s10mm_30AWG_Nxy1_N1/1e-9,'.-');
xlabel('Resolution^2 in XY Plane');
ylabel('L11[nH]');
title('Calculated at (ri,ra)-wT/4');

subplot(3,2,4);
H=plot(NN,L11_wT50_squ_s10mm_30AWG_Nxy1_N1/1e-9,'.-');
xlabel('Resolution^2 in XY Plane');
ylabel('L11[nH]');
title('Calculated at (ri,ra)-wT/50');

subplot(3,2,5);
H=plot(NN,L11_wT75_squ_s10mm_30AWG_Nxy1_N1/1e-9,'.-');
xlabel('Resolution^2 in XY Plane');
ylabel('L11[nH]');
title('Calculated at (ri,ra)-wT/75');

subplot(3,2,6);
H=plot(NN,L11_wT100_squ_s10mm_30AWG_Nxy1_N1/1e-9,'.-');
xlabel('Resolution^2 in XY Plane');
ylabel('L11[nH]');
title('Calculated at (ri,ra)-wT/100');

suptitle('Square s10mm Nxy:1 N:1');
%}

% Nxy1 N2
%{
load('L11_squ_s10mm_30AWG_Nxy1_N2');

figure(1)
title('t')
subplot(3,2,1);
H=plot(NN,L11_squ_s10mm_30AWG_Nxy1_N2/1e-9,'.-');
xlabel('Resolution^2 in XY Plane');
ylabel('L11[nH]');
%title('Nxy:1 N:1');
title('Calculated at (ri,ra)');

subplot(3,2,2);
H=plot(NN,L11_wT2_squ_s10mm_30AWG_Nxy1_N2/1e-9,'.-');
xlabel('Resolution^2 in XY Plane');
ylabel('L11[nH]');
title('Calculated at (ri,ra)-wT/2');

subplot(3,2,3);
H=plot(NN,L11_wT4_squ_s10mm_30AWG_Nxy1_N2/1e-9,'.-');
xlabel('Resolution^2 in XY Plane');
ylabel('L11[nH]');
title('Calculated at (ri,ra)-wT/4');

subplot(3,2,4);
H=plot(NN,L11_wT50_squ_s10mm_30AWG_Nxy1_N2/1e-9,'.-');
xlabel('Resolution^2 in XY Plane');
ylabel('L11[nH]');
title('Calculated at (ri,ra)-wT/50');

subplot(3,2,5);
H=plot(NN,L11_wT75_squ_s10mm_30AWG_Nxy1_N2/1e-9,'.-');
xlabel('Resolution^2 in XY Plane');
ylabel('L11[nH]');
title('Calculated at (ri,ra)-wT/75');

subplot(3,2,6);
H=plot(NN,L11_wT100_squ_s10mm_30AWG_Nxy1_N2/1e-9,'.-');
xlabel('Resolution^2 in XY Plane');
ylabel('L11[nH]');
title('Calculated at (ri,ra)-wT/100');

suptitle('Square s10mm Nxy:1 N:2');
%}

% Nxy1 N3
%{
load('L11_squ_s10mm_30AWG_Nxy1_N3');

figure(1)
title('t')
subplot(3,2,1);
H=plot(NN,L11_squ_s10mm_30AWG_Nxy1_N3/1e-9,'.-');
xlabel('Resolution^2 in XY Plane');
ylabel('L11[nH]');
%title('Nxy:1 N:1');
title('Calculated at (ri,ra)');

subplot(3,2,2);
H=plot(NN,L11_wT2_squ_s10mm_30AWG_Nxy1_N3/1e-9,'.-');
xlabel('Resolution^2 in XY Plane');
ylabel('L11[nH]');
title('Calculated at (ri,ra)-wT/2');

subplot(3,2,3);
H=plot(NN,L11_wT4_squ_s10mm_30AWG_Nxy1_N3/1e-9,'.-');
xlabel('Resolution^2 in XY Plane');
ylabel('L11[nH]');
title('Calculated at (ri,ra)-wT/4');

subplot(3,2,4);
H=plot(NN,L11_wT50_squ_s10mm_30AWG_Nxy1_N3/1e-9,'.-');
xlabel('Resolution^2 in XY Plane');
ylabel('L11[nH]');
title('Calculated at (ri,ra)-wT/50');

subplot(3,2,5);
H=plot(NN,L11_wT75_squ_s10mm_30AWG_Nxy1_N3/1e-9,'.-');
xlabel('Resolution^2 in XY Plane');
ylabel('L11[nH]');
title('Calculated at (ri,ra)-wT/75');

subplot(3,2,6);
H=plot(NN,L11_wT100_squ_s10mm_30AWG_Nxy1_N3/1e-9,'.-');
xlabel('Resolution^2 in XY Plane');
ylabel('L11[nH]');
title('Calculated at (ri,ra)-wT/100');

suptitle('Square s10mm Nxy:1 N:3');
%}

% Nxy2 N1
%{
load('L11_squ_s10mm_30AWG_Nxy2_N1');

figure(1)
title('t')
subplot(3,2,1);
H=plot(NN,L11_squ_s10mm_30AWG_Nxy2_N1/1e-9,'.-');
xlabel('Resolution^2 in XY Plane');
ylabel('L11[nH]');
%title('Nxy:1 N:1');
title('Calculated at (ri,ra)');

subplot(3,2,2);
H=plot(NN,L11_wT2_squ_s10mm_30AWG_Nxy2_N1/1e-9,'.-');
xlabel('Resolution^2 in XY Plane');
ylabel('L11[nH]');
title('Calculated at (ri,ra)-wT/2');

subplot(3,2,3);
H=plot(NN,L11_wT4_squ_s10mm_30AWG_Nxy2_N1/1e-9,'.-');
xlabel('Resolution^2 in XY Plane');
ylabel('L11[nH]');
title('Calculated at (ri,ra)-wT/4');

subplot(3,2,4);
H=plot(NN,L11_wT50_squ_s10mm_30AWG_Nxy2_N1/1e-9,'.-');
xlabel('Resolution^2 in XY Plane');
ylabel('L11[nH]');
title('Calculated at (ri,ra)-wT/50');

subplot(3,2,5);
H=plot(NN,L11_wT75_squ_s10mm_30AWG_Nxy2_N1/1e-9,'.-');
xlabel('Resolution^2 in XY Plane');
ylabel('L11[nH]');
title('Calculated at (ri,ra)-wT/75');

subplot(3,2,6);
H=plot(NN,L11_wT100_squ_s10mm_30AWG_Nxy2_N1/1e-9,'.-');
xlabel('Resolution^2 in XY Plane');
ylabel('L11[nH]');
title('Calculated at (ri,ra)-wT/100');

suptitle('Square s10mm Nxy:2 N:1');
%}

% Nxy2 N2
%
load('L11_squ_s10mm_30AWG_Nxy2_N2');

figure(1)
title('t')
subplot(3,2,1);
H=plot(NN,L11_squ_s10mm_30AWG_Nxy2_N2/1e-9,'.-');
xlabel('Resolution^2 in XY Plane');
ylabel('L11[nH]');
%title('Nxy:1 N:1');
title('Calculated at (ri,ra)');

subplot(3,2,2);
H=plot(NN,L11_wT2_squ_s10mm_30AWG_Nxy2_N2/1e-9,'.-');
xlabel('Resolution^2 in XY Plane');
ylabel('L11[nH]');
title('Calculated at (ri,ra)-wT/2');

subplot(3,2,3);
H=plot(NN,L11_wT4_squ_s10mm_30AWG_Nxy2_N2/1e-9,'.-');
xlabel('Resolution^2 in XY Plane');
ylabel('L11[nH]');
title('Calculated at (ri,ra)-wT/4');

subplot(3,2,4);
H=plot(NN,L11_wT50_squ_s10mm_30AWG_Nxy2_N2/1e-9,'.-');
xlabel('Resolution^2 in XY Plane');
ylabel('L11[nH]');
title('Calculated at (ri,ra)-wT/50');

subplot(3,2,5);
H=plot(NN,L11_wT75_squ_s10mm_30AWG_Nxy2_N2/1e-9,'.-');
xlabel('Resolution^2 in XY Plane');
ylabel('L11[nH]');
title('Calculated at (ri,ra)-wT/75');

subplot(3,2,6);
H=plot(NN,L11_wT100_squ_s10mm_30AWG_Nxy2_N2/1e-9,'.-');
xlabel('Resolution^2 in XY Plane');
ylabel('L11[nH]');
title('Calculated at (ri,ra)-wT/100');

suptitle('Square s10mm Nxy:2 N:2');
%}