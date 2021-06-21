% DATE: 05-18-2021
% this one works 

% clear all; close all; clc;
FK    = 'FEKO_N30.dat';
FKd   = importdata(FK);
FKF   = (FKd.data(:,1)./1e6)*1e6; % frequency
FKi   = FKd.data(:,2);
FKc   = 2*pi*FKF;
FKL   = FKi./FKc;

%%
%FM    = '0.5_0.5_N9.txt';
% @ DC 4.54e-6 
FM    = '0.5_0.5_N32.txt';
% @ DC 32.53e-6 
FM9d  = importdata(FM);
F     = FM9d.data(:,1)./1e6;
FM9i  = FM9d.data(:,5)./1e3;
coeff = 2*pi*F;
FM9L  = FM9i./coeff;
DC    = 32.53*ones(numel(F),1);
%%
FS = 12;

figure(1)
subplot(2,1,1);
H1= plot(F,FM9L,...
         F,DC,'--');
title('Measurments Radius: 0.6in by 0.6in N:32')
ylabel('Inductance [uH]','fontweight','bold','fontsize',FS);
xlabel('Frequency [MHz]','fontweight','bold','fontsize',FS);
legend('Measurements: AC','Model: DC');
%xlim([1 2]);
xlim([1 16]);

% N30
% @ DC 29.61e-6

subplot(2,1,2);
% H2 = plot(FKF(20:end)./1e6,FKL(20:end));
H2 = plot(FKF(20:end)./1e6,FKL(20:end)./1e-6);
title('N:32');
ylabel('Inductance [uH]','fontweight','bold','fontsize',FS);
xlabel('Frequency [MHz]','fontweight','bold','fontsize',FS);
title('FEKO Simulation');
%xlim([1 2]);
xlim([1 16]);
%%
FK    = 'FEKO_EX.dat';
FKd   = importdata(FK);
FKF   = (FKd.data(:,1)./1e6)*1e6; % frequency
FKi   = FKd.data(:,2);
FKc   = 2*pi*FKF;
FKL   = FKi./FKc;
%%% FEKO EX @ DC: 2.7e-6 from Model 
FK_MAT = (2.7e-6)*ones(numel(FKF),1);
figure(2)
H3 = plot(FKF(20:end)./1e6, FKL(20:end)./1e-6,...
          FKF(20:end)./1e6, FK_MAT(20:end)./1e-6);
ylabel('Inductance [uH]','fontweight','bold','fontsize',FS);
xlabel('Frequency [MHz]','fontweight','bold','fontsize',FS);
title('FEKO Simulation');
legend('FEKO(AC)','Model DC');