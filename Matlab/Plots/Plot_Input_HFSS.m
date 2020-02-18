clear all; close all; clc;

fn1 = 'ZInput_Rect_UHF.csv';
fn2 = 'ZInput_Rect_Sband.csv';
fn3 = 'ZInput_Rect_Xband.csv';
uhf = importdata(fn1);
s   = importdata(fn2);
x   = importdata(fn3);
% frequency
f_uhf = uhf.data(:,1);
f_s   = s.data(:,1);
f_x   = x.data(:,1);
% re & imag
re_uhf = uhf.data(:,2);
re_s   = s.data(:,2);
re_x   = x.data(:,2);
im_uhf = uhf.data(:,3);
im_s   = s.data(:,3);
im_x   = x.data(:,3);
%% plot
fs=12; lw=2;
figure(1)
H1 = plot(f_uhf,re_uhf,f_uhf,im_uhf);
set(H1(1),'color','r');
set(H1(2),'color','b');
set(H1,'LineWidth',lw);
set(H1(2),'LineStyle','--');
xlabel('Frequency[GHz]','Fontsize',fs,'fontweight','bold');
ylabel('Input Impedance','Fontsize',fs,'fontweight','bold');
title('UHF','Fontsize',fs);
legend('real','imag');
xlim([0.2 2]);

figure(2)
H2 = plot(f_s,re_s,f_s,im_s);
set(H2(1),'color','r');
set(H2(2),'color','b');
set(H2,'LineWidth',lw);
set(H2(2),'LineStyle','--');
xlabel('Frequency[GHz]','Fontsize',fs,'fontweight','bold');
ylabel('Input Impedance','Fontsize',fs,'fontweight','bold');
title('S-Band','Fontsize',fs);
legend('real','imag');
xlim([2 4]); ylim([-50 165])

figure(3)
H3 = plot(f_x,re_x,f_x,im_x);
set(H3(1),'color','r');
set(H3(2),'color','b');
set(H3,'LineWidth',lw);
set(H3(2),'LineStyle','--');
xlabel('Frequency[GHz]','Fontsize',fs,'fontweight','bold');
ylabel('Input Impedance','Fontsize',fs,'fontweight','bold');
title('X-Band','Fontsize',fs);
legend('real','imag');
xlim([8 12]); ylim([0 165]);