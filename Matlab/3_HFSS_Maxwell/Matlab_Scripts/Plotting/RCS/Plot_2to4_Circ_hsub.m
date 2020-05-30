% Alexander Moreno
% 01-20-2020
% 
% Plot 2to4_Circ_hsub
clear all; close all; clc;
fileName = '2to4_Circ_hsub.csv';
A   = importdata(fileName);
f   = A.data(:,1);
r5  = A.data(:,2);
r10 = A.data(:,3);
r15 = A.data(:,4);
r31 = A.data(:,5);
r62 = A.data(:,6);

i5  = A.data(:,7);
i10 = A.data(:,8);
i15 = A.data(:,9);
i31 = A.data(:,10);
i62 = A.data(:,11);
%%
LW=3;
figure(1)
%subplot(3,2,1)
H1=plot(f,r5,f,i5);
set(H1,'linewidth',LW);
set(H1(2),'Linestyle','--');
ylabel('Input Impedance');
xlabel('Frequency[GHz]');
title('Substrate h:5mil');
legend('real','imag','location','northwest');
xlim([1.8 4.2]);

figure(2)
%subplot(3,2,2)
H1=plot(f,r10,f,i10);
set(H1,'linewidth',LW);
set(H1(2),'Linestyle','--');
ylabel('Input Impedance');
xlabel('Frequency[GHz]');
title('Substrate h:10mil');
legend('real','imag','location','northwest');
xlim([1.8 4.2]);

figure(3)
%subplot(3,2,3)
H1=plot(f,r15,f,i15);
set(H1,'linewidth',LW);
set(H1(2),'Linestyle','--');
ylabel('Input Impedance');
xlabel('Frequency[GHz]');
title('Substrate h:15mil');
legend('real','imag','location','northwest');
xlim([1.8 4.2]);

figure(4)
%subplot(3,2,4)
H1=plot(f,r31,f,i31);
set(H1,'linewidth',LW);
set(H1(2),'Linestyle','--');
ylabel('Input Impedance');
xlabel('Frequency[GHz]');
title('Substrate h:31mil');
legend('real','imag','location','northwest');
xlim([1.8 4.2]);

figure(5)
%subplot(3,2,5)
H1=plot(f,r62,f,i62);
set(H1,'linewidth',LW);
set(H1(2),'Linestyle','--');
ylabel('Input Impedance');
xlabel('Frequency[GHz]');
title('Substrate h:62mil');
legend('real','imag','location','northwest');
xlim([1.8 4.2]);
%{
figure(2)
H1=plot(f,r5,f,i5,f,r10,f,i10);
set(H1(1),'color','r'); 
set(H1(1),'linestyle','-'); 
set(H1(2),'color','b'); 
set(H1(2),'linestyle','--'); 
set(H1(3),'color','r'); 
set(H1(3),'linestyle','-'); 
set(H1(4),'color','b'); 
set(H1(4),'linestyle','--'); 
set(H1,'linewidth',2);
ylabel('Input Impedance');
xlabel('Frequency[GHz]');
title('Input Impedance - h:10mil');
legend('real','imag');

%%
figure(3)
subplot(3,2,1)
H1=plot(f,r5,f,i5);
set(H1(1),'color','r'); 
set(H1(1),'linestyle','-'); 
set(H1(2),'color','b'); 
set(H1(2),'linestyle','--'); 
set(H1,'linewidth',2);
ylabel('Input Impedance: 5mil');
xlabel('Frequency[GHz]');
title('Input Impedance - h:5mil');
legend('real','imag','location','northwest');

subplot(3,2,2)
H1=plot(f,r10,f,i10);
set(H1(1),'color','r'); 
set(H1(1),'linestyle','-'); 
set(H1(2),'color','b'); 
set(H1(2),'linestyle','--'); 
set(H1,'linewidth',2);
ylabel('Input Impedance: 10mil');
xlabel('Frequency[GHz]');
title('Input Impedance - h:10mil');
legend('real','imag','location','northwest');

subplot(3,2,3)
H1=plot(f,r15,f,i15);
set(H1(1),'color','r'); 
set(H1(1),'linestyle','-'); 
set(H1(2),'color','b'); 
set(H1(2),'linestyle','--'); 
set(H1,'linewidth',2);
ylabel('Input Impedance: 10mil');
xlabel('Frequency[GHz]');
title('Input Impedance - h:10mil');
legend('real','imag','location','northwest');

subplot(3,2,4)
H1=plot(f,r31,f,i31);
set(H1(1),'color','r'); 
set(H1(1),'linestyle','-'); 
set(H1(2),'color','b'); 
set(H1(2),'linestyle','--'); 
set(H1,'linewidth',2);
ylabel('Input Impedance: 5mil');
xlabel('Frequency[GHz]');
title('Input Impedance - h:31mil');
legend('real','imag','location','northwest');

subplot(3,2,5)
H1=plot(f,r62,f,i62);
set(H1(1),'color','r'); 
set(H1(1),'linestyle','-'); 
set(H1(2),'color','b'); 
set(H1(2),'linestyle','--'); 
set(H1,'linewidth',2);
ylabel('Input Impedance: 5mil');
xlabel('Frequency[GHz]');
title('Input Impedance - h:62mil');
legend('real','imag','location','northwest');
%}