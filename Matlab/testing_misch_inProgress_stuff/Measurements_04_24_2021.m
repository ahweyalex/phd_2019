clear all; close all; clc;
% 0.5 by 0.5
FH1   = '1KHz_16MHz_inc10KHz_0.5in_0.5in_N1.txt';
FH2   = '1KHz_16MHz_inc10KHz_0.5in_0.5in_N2.txt';
FH3   = '1KHz_16MHz_inc10KHz_0.5in_0.5in_N3.txt';
FH4   = '1KHz_16MHz_inc10KHz_0.5in_0.5in_N4.txt';
FH5   = '1KHz_16MHz_inc10KHz_0.5in_0.5in_N5.txt';
FH6   = '1KHz_16MHz_inc10KHz_0.5in_0.5in_N6.txt';
FH7   = '1KHz_16MHz_inc10KHz_0.5in_0.5in_N7.txt';
FH8   = '1KHz_16MHz_inc10KHz_0.5in_0.5in_N8.txt';
FH9   = '1KHz_16MHz_inc10KHz_0.5in_0.5in_N9.txt';
FH10  = '1KHz_16MHz_inc10KHz_0.5in_0.5in_N10.txt';
FH20  = '1KHz_16MHz_inc10KHz_0.5in_0.5in_N20.txt';
FH30  = '1KHz_16MHz_inc10KHz_0.5in_0.5in_N30.txt';
FH40  = '1KHz_16MHz_inc10KHz_0.5in_0.5in_N40.txt';
FH50  = '1KHz_16MHz_inc10KHz_0.5in_0.5in_N50.txt';
% 0.75 by 0.75
FTH1   = '1KHz_16MHz_inc10KHz_0.75in_0.75in_N1.txt';
FTH2   = '1KHz_16MHz_inc10KHz_0.75in_0.75in_N2.txt';
FTH3   = '1KHz_16MHz_inc10KHz_0.75in_0.75in_N3.txt';
FTH4   = '1KHz_16MHz_inc10KHz_0.75in_0.75in_N4.txt';
FTH5   = '1KHz_16MHz_inc10KHz_0.75in_0.75in_N5.txt';
FTH6   = '1KHz_16MHz_inc10KHz_0.75in_0.75in_N6.txt';
FTH7   = '1KHz_16MHz_inc10KHz_0.75in_0.75in_N7.txt';
FTH8   = '1KHz_16MHz_inc10KHz_0.75in_0.75in_N8.txt';
FTH9   = '1KHz_16MHz_inc10KHz_0.75in_0.75in_N9.txt';
FTH10  = '1KHz_16MHz_inc10KHz_0.75in_0.75in_N10.txt';
FTH20  = '1KHz_16MHz_inc10KHz_0.75in_0.75in_N20.txt';
FTH30  = '1KHz_16MHz_inc10KHz_0.75in_0.75in_N30.txt';
FTH40  = '1KHz_16MHz_inc10KHz_0.75in_0.75in_N40.txt';
FTH50  = '1KHz_16MHz_inc10KHz_0.75in_0.75in_N50.txt';
%% import data
% 0.5 by 0.5
FH1d  = importdata(FH1);
FH2d  = importdata(FH2);
FH3d  = importdata(FH3);
FH4d  = importdata(FH4);
FH5d  = importdata(FH5);
FH6d  = importdata(FH6);
FH7d  = importdata(FH7);
FH8d  = importdata(FH8);
FH9d  = importdata(FH9);
FH10d = importdata(FH10);
FH20d = importdata(FH20);
FH30d = importdata(FH30);
FH40d = importdata(FH40);
FH50d = importdata(FH50);
% 0.75 by 0.75
FTH1d = importdata(FTH1);
FTH2d = importdata(FTH2);
FTH3d = importdata(FTH3);
FTH4d = importdata(FTH4);
FTH5d = importdata(FTH5);
FTH6d = importdata(FTH6);
FTH7d = importdata(FTH7);
FTH8d = importdata(FTH8);
FTH9d = importdata(FTH9);
FTH10d = importdata(FH10);
FTH20d = importdata(FTH20);
FTH30d = importdata(FTH30);
FTH40d = importdata(FTH40);
FTH50d = importdata(FTH50);
%% extract f and imag
F    = FH1d.data(:,1)./1e6; % frequency
% imag - 0.5 by 0.5
FH1i  = FH1d.data(:,5)./1e-3; 
FH2i  = FH2d.data(:,5)./1e-3; 
FH3i  = FH3d.data(:,5)./1e-3; 
FH4i  = FH4d.data(:,5)./1e-3;
FH5i  = FH5d.data(:,5)./1e-3; 
FH6i  = FH6d.data(:,5)./1e-3;
FH7i  = FH7d.data(:,5)./1e-3; 
FH8i  = FH8d.data(:,5)./1e-3;
FH9i  = FH9d.data(:,5)./1e-3; 
FH10i = FH10d.data(:,5)./1e-3;
FH20i = FH20d.data(:,5)./1e-3;
FH30i = FH30d.data(:,5)./1e-3;
FH40i = FH40d.data(:,5)./1e-3;
FH50i = FH50d.data(:,5)./1e-3;
% imag - 0.75 by 0.75
FTH1i  = FTH1d.data(:,5)./1e-3; 
FTH2i  = FTH2d.data(:,5)./1e-3; 
FTH3i  = FTH3d.data(:,5)./1e-3; 
FTH4i  = FTH4d.data(:,5)./1e-3;
FTH5i  = FTH5d.data(:,5)./1e-3; 
FTH6i  = FTH6d.data(:,5)./1e-3;
FTH7i  = FTH7d.data(:,5)./1e-3; 
FTH8i  = FTH8d.data(:,5)./1e-3;
FTH9i  = FTH9d.data(:,5)./1e-3; 
FTH10i = FTH10d.data(:,5)./1e-3;
FTH20i = FTH20d.data(:,5)./1e-3;
FTH30i = FTH30d.data(:,5)./1e-3;
FTH40i = FTH40d.data(:,5)./1e-3;
FTH50i = FTH50d.data(:,5)./1e-3;
%% convert imag into inductance 
coeff = 2*pi*F;
% converting - 0.5 by 0.5
FH1L  = FH1i./coeff;
FH2L  = FH2i./coeff;
FH3L  = FH3i./coeff;
FH4L  = FH4i./coeff;
FH5L  = FH5i./coeff;
FH6L  = FH6i./coeff;
FH7L  = FH7i./coeff;
FH8L  = FH8i./coeff;
FH9L  = FH9i./coeff;
FH10L = FH10i./coeff;
FH20L = FH20i./coeff;
FH30L = FH30i./coeff;
FH40L = FH40i./coeff;
FH50L = FH50i./coeff;
% converting - 0.75 by 0.75
FTH1L  = FTH1i./coeff;
FTH2L  = FTH2i./coeff;
FTH3L  = FTH3i./coeff;
FTH4L  = FTH4i./coeff;
FTH5L  = FTH5i./coeff;
FTH6L  = FTH6i./coeff;
FTH7L  = FTH7i./coeff;
FTH8L  = FTH8i./coeff;
FTH9L  = FTH9i./coeff;
FTH10L = FTH10i./coeff;
FTH20L = FTH20i./coeff;
FTH30L = FTH30i./coeff;
FTH40L = FTH40i./coeff;
FTH50L = FH50i./coeff;
%% plotting 
FS  = 12; % FONT SIZE
int = 22; % 2MHz, starting index for frequency
% converting - 0.5 by 0.5
figure(1)
H1 = plot(F(int:end),FH1L(int:end), F(int:end),FH3L(int:end),...
    F(int:end),FH4L(int:end), F(int:end),FH5L(int:end),...
    F(int:end),FH6L(int:end), F(int:end),FH7L(int:end),...
    F(int:end),FH8L(int:end), F(int:end),FH9L(int:end),...
    F(int:end),FH10L(int:end));
xlabel('Frequency [MHz]','fontweight','bold','fontsize',FS);
ylabel('Inductance','fontweight','bold','fontsize',FS);
title('radius: 0.5in by 0.5in ',...
    'fontweight','bold','fontsize',FS);
%legend('N=1','N=2','N=3','N=4','N=5','N=6','N=7','N=8','N=9','N=10');
legend('N=1','N=3','N=4','N=5','N=6','N=7','N=8','N=9','N=10');
%
figure(2)
H2 = plot(F(int:end),FH10L(int:end),F(int:end),FH20L(int:end),...
    F(int:end),FH30L(int:end),F(int:end),FH40L(int:end),...
    F(int:end),FH50L(int:end));
xlabel('Frequency [MHz]','fontweight','bold','fontsize',FS);
ylabel('Inductance','fontweight','bold','fontsize',FS);
title('radius: 0.5in by 0.5in ',...
    'fontweight','bold','fontsize',FS);
set(H2(1),'color','r'); set(H2(2),'color','b'); set(H2(3),'color','g');
set(H2(4),'color','m'); set(H2(5),'color','k');
legend('N=10','N=20','N=30','N=40','N=50');

% converting - 0.75 by 0.75
figure(3)
H3 = plot(F(int:end),FTH1L(int:end), F(int:end),FTH3L(int:end),...
    F(int:end),FTH4L(int:end), F(int:end),FTH5L(int:end),...
    F(int:end),FTH6L(int:end), F(int:end),FTH7L(int:end),...
    F(int:end),FTH8L(int:end), F(int:end),FTH9L(int:end),...
    F(int:end),FTH10L(int:end));
xlabel('Frequency [MHz]','fontweight','bold','fontsize',FS);
ylabel('Inductance','fontweight','bold','fontsize',FS);
title('radius: 0.75in by 0.75in ',...
    'fontweight','bold','fontsize',FS);
%legend('N=1','N=2','N=3','N=4','N=5','N=6','N=7','N=8','N=9','N=10');
legend('N=1','N=3','N=4','N=5','N=6','N=7','N=8','N=9','N=10');
%%
figure(4)
H4 = plot(F(int:end),FTH10L(int:end),F(int:end),FTH20L(int:end),...
    F(int:end),FTH30L(int:end),F(int:end),FTH40L(int:end),...
    F(int:end),FTH50L(int:end));
xlabel('Frequency [MHz]','fontweight','bold','fontsize',FS);
ylabel('Inductance','fontweight','bold','fontsize',FS);
title('radius: 0.75in by 0.75in ',...
    'fontweight','bold','fontsize',FS);
set(H4(1),'color','r'); set(H4(2),'color','b'); set(H4(3),'color','g');
set(H4(4),'color','m'); set(H4(5),'color','k');
legend('N=10','N=20','N=30','N=40','N=50');

