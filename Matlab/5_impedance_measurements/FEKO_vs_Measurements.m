clear all; close all; clc;

FH30    = '1KHz_16MHz_inc10KHz_0.5in_0.5in_N30.txt';
FK30    = 'FEKO_N30.dat';
%FK30    = 'FEKO_EX.dat';
FK30d   = importdata(FK30);
FH30d   = importdata(FH30);
F       = FK30d.data(:,1)./1e6; % frequency
FM      = FH30d.data(:,1)./1e6; % frequency

FK30i   = FK30d.data(:,2)./1e-3;
FH30i   = FH30d.data(:,5)./1e3;
%%% MEASUREMENTS @ DC: 22.31
FK_MAT = 22.31*ones(numel(F),1);
FM_MAT = 22.31*ones(numel(FM),1);

%%% FEKO EX @ DC: 2.7e-6
%FK_MAT = (2.7e-6)*ones(numel(F),1);
%FM_MAT = (2.7e-6)*ones(numel(FM),1);

coeff   = 2*pi*F;
coeffM  = 2*pi*FM;
FK30L   = FK30i./coeff;
FH30L   = FH30i./coeffM;
% plots
FS  = 12; % FONT SIZE
int = 1; % 2MHz, starting index for frequency
% converting - 0.5 by 0.5
%%
figure(1)
subplot(2,1,1);
H1 = plot(F(int:end), (FK30L(int:end)./1e3)*(1e-6));
          %%F(int:end), FK_MAT(int:end));
xlabel('Frequency [MHz]','fontweight','bold','fontsize',FS);
ylabel('Inductance [H]','fontweight','bold','fontsize',FS);
title('FEKO Simulation ',...
    'fontweight','bold','fontsize',FS);
xlim([1 16]);
legend('AC');

subplot(2,1,2);
H2 = plot(FM(int:end),FH30L(int:end),...
          FM(int:end), FM_MAT(int:end),'--');
xlabel('Frequency [MHz]','fontweight','bold','fontsize',FS);
ylabel('Inductance [H]','fontweight','bold','fontsize',FS);
title('Measurements: radius: 0.5in by 0.5in N:30',...
    'fontweight','bold','fontsize',FS);
xlim([1 16]);
legend('AC','DC');
%%
figure
H3 = plot(F(int:end), (FK30L(int:end)./1e3)*(1e-6),...
           F(int:end), FK_MAT(int:end),'--');
xlabel('Frequency [MHz]','fontweight','bold','fontsize',FS);
ylabel('Inductance[H]','fontweight','bold','fontsize',FS);
title('FEKO Simulation Example',...
    'fontweight','bold','fontsize',FS);
legend('AC','DC');