clear all; close all; clc;
% importing data
% i dont think it converage
% 5,10,31,62mil
% fileName = 'Circ_Z_12_10_2019.csv'; 

% mesh op added
% 5,10,15,31,62mil
% 10mil seems to be the best option as [12-12-2019]
fileName = 'Circ_Z_12_12_2019.csv';   

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
%% plotting
%{
figure(1)
subplot(2,1,1);
H1=plot(f,r5,f,r10,f,r31,f,r62);
set(H1(1),'color','r');
set(H1(2),'color','b');
set(H1(2),'linestyle','--');
set(H1(3),'color','g');
set(H1(4),'color','k');
set(H1,'linewidth',2);
set(H1(4),'linestyle','--');
xlabel('Frequency[GHz]');
title('Real Input Impedance');
legend('h:5mil','h:10mil','h:31mil','h:62mil','Location','northwest');
%xlim([9.6 9.9]);
subplot(2,1,2);
H1=plot(f,i5,f,i10,f,i31,f,i62);
set(H1(1),'color','r');
set(H1(2),'color','b');
set(H1(2),'linestyle','--');
set(H1(3),'color','g');
set(H1(4),'color','k');
set(H1,'linewidth',2);
set(H1(4),'linestyle','--');
xlabel('Frequency[GHz]');
title('Imaginary Input Impedance');
legend('h:5mil','h:10mil','h:31mil','h:62mil','Location','northwest');
%xlim([9.6 9.9]);
%}
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

figure(2)
%subplot(3,2,2)
H1=plot(f,r10,f,i10);
set(H1,'linewidth',LW);
set(H1(2),'Linestyle','--');
ylabel('Input Impedance');
xlabel('Frequency[GHz]');
title('Substrate h:10mil');
legend('real','imag','location','northwest');

figure(3)
%subplot(3,2,3)
H1=plot(f,r15,f,i15);
set(H1,'linewidth',LW);
set(H1(2),'Linestyle','--');
ylabel('Input Impedance');
xlabel('Frequency[GHz]');
title('Substrate h:15mil');
legend('real','imag','location','northwest');

figure(4)
%subplot(3,2,4)
H1=plot(f,r31,f,i31);
set(H1,'linewidth',LW);
set(H1(2),'Linestyle','--');
ylabel('Input Impedance');
xlabel('Frequency[GHz]');
title('Substrate h:31mil');
legend('real','imag','location','northwest');

figure(5)
%subplot(3,2,5)
H1=plot(f,r62,f,i62);
set(H1,'linewidth',LW);
set(H1(2),'Linestyle','--');
ylabel('Input Impedance');
xlabel('Frequency[GHz]');
title('Substrate h:62mil');
legend('real','imag','location','northwest');
%%
%{
figure(1)
H1=plot(f,r5,f,r10,f,r15,f,r31,f,r62);
set(H1(1),'color','r'); set(H1(1),'linestyle','-'); 
set(H1(2),'color','b'); set(H1(2),'linestyle','--'); 
set(H1(3),'color','g'); set(H1(3),'marker','o'); 
set(H1(4),'color','k'); set(H1(4),'marker','x'); 
set(H1(5),'color','m'); set(H1(5),'marker','h'); 
ylabel('Input Impedance');
xlabel('Frequency[GHz]');
title('Input Impedance');
legend('5mil','10mil','15mil','32mil','62mil','location','northwest');

figure(2)
H1=plot(f,i5,f,i10,f,i15,f,i31,f,i62);
set(H1(1),'color','r'); set(H1(1),'linestyle','-'); 
set(H1(2),'color','b'); set(H1(2),'linestyle','--'); 
set(H1(3),'color','g'); set(H1(3),'marker','o'); 
set(H1(4),'color','k'); set(H1(4),'marker','x'); 
set(H1(5),'color','m'); set(H1(5),'marker','h'); 
ylabel('Input Impedance');
xlabel('Frequency[GHz]');
title('Input Impedance');
legend('5mil','10mil','15mil','32mil','62mil','location','northwest');
%}

%%
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