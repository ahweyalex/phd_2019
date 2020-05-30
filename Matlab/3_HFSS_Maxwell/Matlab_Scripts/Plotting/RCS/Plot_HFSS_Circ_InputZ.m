clear all; close all; clc;

fn1 = '2to4_Circ_hsub.csv';
A   = importdata(fn1);
f   = A.data(:,1);
re_05 = A.data(:,2);
re_10 = A.data(:,3);
re_15 = A.data(:,4);
re_31 = A.data(:,5);
re_62 = A.data(:,6);

im_05 = A.data(:,7);
im_10 = A.data(:,8);
im_15 = A.data(:,9);
im_31 = A.data(:,10);
im_62 = A.data(:,11);

%% plot
fs=12; lw=2;
% 5mil
figure(1)
H1 = plot(f,re_05,f,im_05);
set(H1(1),'color','r');
set(H1(2),'color','b');
set(H1,'LineWidth',lw);
set(H1(2),'LineStyle','--');
xlabel('Frequency[GHz]','Fontsize',fs,'fontweight','bold');
ylabel('Input Impedance','Fontsize',fs,'fontweight','bold');
title('5mil','Fontsize',fs);
legend('real','imag');
%% 10 mil
figure(2)
H1 = plot(f,re_10,f,im_10);
set(H1(1),'color','r');
set(H1(2),'color','b');
set(H1,'LineWidth',lw);
set(H1(2),'LineStyle','--');
xlabel('Frequency[GHz]','Fontsize',fs,'fontweight','bold');
ylabel('Input Impedance','Fontsize',fs,'fontweight','bold');
title('10mil','Fontsize',fs);
legend('real','imag');
%% 15 mil
figure(3)
H1 = plot(f,re_15,f,im_15);
set(H1(1),'color','r');
set(H1(2),'color','b');
set(H1,'LineWidth',lw);
set(H1(2),'LineStyle','--');
xlabel('Frequency[GHz]','Fontsize',fs,'fontweight','bold');
ylabel('Input Impedance','Fontsize',fs,'fontweight','bold');
title('15mil','Fontsize',fs);
legend('real','imag');
% 31 mil
figure(4)
H1 = plot(f,re_31,f,im_31);
set(H1(1),'color','r');
set(H1(2),'color','b');
set(H1,'LineWidth',lw);
set(H1(2),'LineStyle','--');
xlabel('Frequency[GHz]','Fontsize',fs,'fontweight','bold');
ylabel('Input Impedance','Fontsize',fs,'fontweight','bold');
title('31mil','Fontsize',fs);
legend('real','imag');
% 62 mil
figure(5)
H1 = plot(f,re_62,f,im_62);
set(H1(1),'color','r');
set(H1(2),'color','b');
set(H1,'LineWidth',lw);
set(H1(2),'LineStyle','--');
xlabel('Frequency[GHz]','Fontsize',fs,'fontweight','bold');
ylabel('Input Impedance','Fontsize',fs,'fontweight','bold');
title('62mil','Fontsize',fs);
legend('real','imag');