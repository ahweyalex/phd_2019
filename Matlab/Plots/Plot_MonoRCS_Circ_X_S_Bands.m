%% import data 
clear all; close all; clc;
% 2to4GHz (SBAND)
fn1  = 'Mono_RCS_Circ_2to4GHz.csv';
fn2  = 'Mono_RCS_Circ_2to4GHz_500Ohms.csv';
fn3  = 'Mono_RCS_Circ_2to4GHz_Short.csv';
fn4  = 'Mono_RCS_Circ_2to4GHz_Small.csv';
fn5  = 'Mono_RCS_Circ_2to4GHz_PhTh.csv';
fn6  = 'Mono_RCS_Circ_2to4GHz_500Ohms_PhTh.csv';
fn7  = 'Mono_RCS_Circ_2to4GHz_Short_PhTh.csv';
% import data
s   = importdata(fn1);
s50 = importdata(fn2);
sSh = importdata(fn3);
sSm = importdata(fn4);
sPT = importdata(fn5);
s50_PT = importdata(fn6);
sSh_PT = importdata(fn7);

s_ph0    = 20*log10(s.data(:,2));
s_ph90   = 20*log10(s.data(:,3));
s50_ph0  = 20*log10(s50.data(:,2));
s50_ph90 = 20*log10(s50.data(:,3));
sSh_ph0  = 20*log10(sSh.data(:,2));
sSh_ph90 = 20*log10(sSh.data(:,3));
sSm_ph0  = 20*log10(sSm.data(:,2));
sSm_ph90 = 20*log10(sSm.data(:,3));
% open
sP_ph0  = 20*log10(sPT.data(:,2));
sP_ph90 = 20*log10(sPT.data(:,3));
sT_ph0  = 20*log10(sPT.data(:,4));
sT_ph90 = 20*log10(sPT.data(:,5));
% 500Ohms
s50_P_ph0  = 20*log10(s50_PT.data(:,2));
s50_P_ph90 = 20*log10(s50_PT.data(:,3));
s50_T_ph0  = 20*log10(s50_PT.data(:,4));
s50_T_ph90 = 20*log10(s50_PT.data(:,5));
% short
sSh_P_ph0  = 20*log10(sSh_PT.data(:,2));
sSh_P_ph90 = 20*log10(sSh_PT.data(:,3));
sSh_T_ph0  = 20*log10(sSh_PT.data(:,4));
sSh_T_ph90 = 20*log10(sSh_PT.data(:,5));

% 8to12GHz (XBAND)
fn1  = 'Mono_RCS_Circ_8to12GHz.csv';
fn2  = 'Mono_RCS_Circ_8to12GHz_500Ohms.csv';
fn3  = 'Mono_RCS_Circ_8to12GHz_Short.csv';
fn4  = 'Mono_RCS_Circ_8to12GHz_Small.csv';
fn5  = 'Mono_RCS_Circ_8to12GHz_PhTh.csv';
fn6  = 'Mono_RCS_Circ_8to12GHz_500Ohms_PhTh.csv';
fn7  = 'Mono_RCS_Circ_8to12GHz_Short_PhTh.csv';
% import data
x   = importdata(fn1);
x50 = importdata(fn2);
xSh = importdata(fn3);
xSm = importdata(fn4);
xPT = importdata(fn5);
x50_PT = importdata(fn6);
xSh_PT = importdata(fn7);

x_ph0    = 20*log10(x.data(:,2));
x_ph90   = 20*log10(x.data(:,3));
x50_ph0  = 20*log10(x50.data(:,2));
x50_ph90 = 20*log10(x50.data(:,3));
xSh_ph0  = 20*log10(xSh.data(:,2));
xSh_ph90 = 20*log10(xSh.data(:,3));
xSm_ph0  = 20*log10(xSm.data(:,2));
xSm_ph90 = 20*log10(xSm.data(:,3));
% open
xP_ph0  = 20*log10(xPT.data(:,2));
xP_ph90 = 20*log10(xPT.data(:,3));
xT_ph0  = 20*log10(xPT.data(:,4));
xT_ph90 = 20*log10(xPT.data(:,5));
% 500Ohms
x50_P_ph0  = 20*log10(x50_PT.data(:,2));
x50_P_ph90 = 20*log10(x50_PT.data(:,3));
x50_T_ph0  = 20*log10(x50_PT.data(:,4));
x50_T_ph90 = 20*log10(x50_PT.data(:,5));
% short
xSh_P_ph0  = 20*log10(xSh_PT.data(:,2));
xSh_P_ph90 = 20*log10(xSh_PT.data(:,3));
xSh_T_ph0  = 20*log10(xSh_PT.data(:,4));
xSh_T_ph90 = 20*log10(xSh_PT.data(:,5));

% gnd
fn01 = 'Mono_RCS_Circ_GND_Sband.csv';
fn02 = 'Mono_RCS_Circ_GND_Small_Sband.csv';
fn03 = 'Mono_RCS_Circ_GND_Xband.csv';
fn04 = 'Mono_RCS_Circ_GND_Small_Xband.csv';
sG  = importdata(fn01);
sGS = importdata(fn02);
xG  = importdata(fn03);
xGS = importdata(fn04);
sG_0  = 20*log10(sG.data(:,2));
sGS_0 = 20*log10(sGS.data(:,2));
xG_0  = 20*log10(xG.data(:,2));
xGS_0 = 20*log10(xGS.data(:,2));
% angles
a = s.data(:,1)*(pi/180);
%% plots
%{
figure(1)
%subplot(2,1,1);
H = mmpolar(a,s_ph0,a,s50_ph0,a,sSh_ph0,...
    'Style','compass','TGridVisible','off',...
    'TTickOffset',0.05,'TTickDelta',30);
set(H,'LineWidth',3);
set(H(1),'color','r'); set(H(2),'color','b'); set(H(3),'color','g');
set(H(1),'LineStyle','-'); set(H(2),'LineStyle','--'); 
set(H(3),'LineStyle',':');
fig=gcf; set(findall(fig,'-property','Fontsize'),'Fontsize',14); grid off;
title('RCS: SBand(3.46GHz) \phi:0^\circ');
legend({'open','500\Omega','short'},'Location','northwest');
%subplot(2,1,2);
figure(2)
H = mmpolar(a,s_ph90,a,s50_ph90,a,sSh_ph90,...
    'Style','compass','TGridVisible','off',...
    'TTickOffset',0.05,'TTickDelta',30);
set(H,'LineWidth',3);
set(H(1),'color','r'); set(H(2),'color','b'); set(H(3),'color','g');
set(H(1),'LineStyle','-'); set(H(2),'LineStyle','--'); 
set(H(3),'LineStyle',':');
fig=gcf; set(findall(fig,'-property','Fontsize'),'Fontsize',14); grid off;
title('RCS: SBand(3.46GHz) \phi:90^\circ');
legend({'open','500\Omega','short'},'Location','northwest');
%%
figure(3)
H = mmpolar(a,x_ph0,a,x50_ph0,a,xSh_ph0,...
    'Style','compass','TGridVisible','off',...
    'TTickOffset',0.05,'TTickDelta',30);
set(H,'LineWidth',3);
set(H(1),'color','r'); set(H(2),'color','b'); set(H(3),'color','g');
set(H(1),'LineStyle','-'); set(H(2),'LineStyle','--'); 
set(H(3),'LineStyle',':');
fig=gcf; set(findall(fig,'-property','Fontsize'),'Fontsize',14); grid off;
title('Monostatic RCS: XBand(9.675GHz) \phi:0^\circ');
legend({'open','500\Omega','short'},'Location','northwest');

figure(4)
H = mmpolar(a,x_ph90,a,x50_ph90,a,xSh_ph90,...
    'Style','compass','TGridVisible','off',...
    'TTickOffset',0.05,'TTickDelta',30);
set(H,'LineWidth',3);
set(H(1),'color','r'); set(H(2),'color','b'); set(H(3),'color','g');
set(H(1),'LineStyle','-'); set(H(2),'LineStyle','--'); 
set(H(3),'LineStyle',':');
fig=gcf; set(findall(fig,'-property','Fontsize'),'Fontsize',14); grid off;
title('Monostatic RCS: XBand(9.675GHz) \phi:90^\circ');
legend({'open','500\Omega','short'},'Location','northwest');
%% gnd planes 
figure(5)
H = mmpolar(a,sG_0, a,sGS_0,...
    'Style','compass','TGridVisible','off',...
    'TTickOffset',0.05,'TTickDelta',30);
set(H,'LineWidth',3);
set(H(1),'color','r'); set(H(2),'color','b');
set(H(1),'LineStyle','-'); set(H(2),'LineStyle','--'); 
fig=gcf; set(findall(fig,'-property','Fontsize'),'Fontsize',14); grid off;

figure(6)
H = mmpolar(a,xG_0, a,xGS_0,...
    'Style','compass','TGridVisible','off',...
    'TTickOffset',0.05,'TTickDelta',30);
set(H,'LineWidth',3);
set(H(1),'color','r'); set(H(2),'color','b');
set(H(1),'LineStyle','-'); set(H(2),'LineStyle','--'); 
fig=gcf; set(findall(fig,'-property','Fontsize'),'Fontsize',14); grid off;
%}
%% sband, pol:ph&th
%{
% pol_phi
figure(7)
H = mmpolar(a,sP_ph0,a,s50_P_ph0,a,sSh_P_ph0,...
    'Style','compass','TGridVisible','off',...
    'TTickOffset',0.05,'TTickDelta',30);
set(H,'LineWidth',3);
set(H(1),'color','r'); set(H(2),'color','b'); set(H(3),'color','g');
set(H(1),'LineStyle','-'); set(H(2),'LineStyle','--'); 
set(H(3),'LineStyle',':');
fig=gcf; set(findall(fig,'-property','Fontsize'),'Fontsize',14); grid off;
title('Monostatic RCS: SBand(3.46GHz) pol:\phi \phi:0^\circ');
legend({'open','500\Omega','short'},'Location','northwest');

figure(8)
H = mmpolar(a,sP_ph90,a,s50_P_ph90,a,sSh_P_ph90,...
    'Style','compass','TGridVisible','off',...
    'TTickOffset',0.05,'TTickDelta',30);
set(H,'LineWidth',3);
set(H(1),'color','r'); set(H(2),'color','b'); set(H(3),'color','g');
set(H(1),'LineStyle','-'); set(H(2),'LineStyle','--'); 
set(H(3),'LineStyle',':');
fig=gcf; set(findall(fig,'-property','Fontsize'),'Fontsize',14); grid off;
title('Monostatic RCS: SBand(3.46GHz) pol:\phi \phi:90^\circ');
legend({'open','500\Omega','short'},'Location','northwest');

% pol_th
figure(9)
H = mmpolar(a,sT_ph0,a,s50_T_ph0,a,sSh_T_ph0,...
    'Style','compass','TGridVisible','off',...
    'TTickOffset',0.05,'TTickDelta',30);
set(H,'LineWidth',3);
set(H(1),'color','r'); set(H(2),'color','b'); set(H(3),'color','g');
set(H(1),'LineStyle','-'); set(H(2),'LineStyle','--'); 
set(H(3),'LineStyle',':');
fig=gcf; set(findall(fig,'-property','Fontsize'),'Fontsize',14); grid off;
title('Monostatic RCS: SBand(3.46GHz) pol:\theta \phi:0^\circ');
legend({'open','500\Omega','short'},'Location','northwest');

figure(10)
H = mmpolar(a,sT_ph90,a,s50_T_ph90,a,sSh_T_ph90,...
    'Style','compass','TGridVisible','off',...
    'TTickOffset',0.05,'TTickDelta',30);
set(H,'LineWidth',3);
set(H(1),'color','r'); set(H(2),'color','b'); set(H(3),'color','g');
set(H(1),'LineStyle','-'); set(H(2),'LineStyle','--'); 
set(H(3),'LineStyle',':');
fig=gcf; set(findall(fig,'-property','Fontsize'),'Fontsize',14); grid off;
title('Monostatic RCS: SBand(3.46GHz) pol:\theta \phi:90^\circ');
legend({'open','500\Omega','short'},'Location','northwest');
%}
%% xband, pol:ph&th
%
% pol_phi
figure(11)
H = mmpolar(a,xP_ph0,a,x50_P_ph0,a,xSh_P_ph0,...
    'Style','compass','TGridVisible','off',...
    'TTickOffset',0.05,'TTickDelta',30);
set(H,'LineWidth',3);
set(H(1),'color','r'); set(H(2),'color','b'); set(H(3),'color','g');
set(H(1),'LineStyle','-'); set(H(2),'LineStyle','--'); 
set(H(3),'LineStyle',':');
fig=gcf; set(findall(fig,'-property','Fontsize'),'Fontsize',14); grid off;
title('Monostatic RCS: XBand(9.675GHz) pol:\phi \phi:0^\circ');
legend({'open','500\Omega','short'},'Location','northwest');

figure(12)
H = mmpolar(a,xP_ph90,a,x50_P_ph90,a,xSh_P_ph90,...
    'Style','compass','TGridVisible','off',...
    'TTickOffset',0.05,'TTickDelta',30);
set(H,'LineWidth',3);
set(H(1),'color','r'); set(H(2),'color','b'); set(H(3),'color','g');
set(H(1),'LineStyle','-'); set(H(2),'LineStyle','--'); 
set(H(3),'LineStyle',':');
fig=gcf; set(findall(fig,'-property','Fontsize'),'Fontsize',14); grid off;
title('Monostatic RCS: XBand(9.675GHz) pol:\phi \phi:90^\circ');
legend({'open','500\Omega','short'},'Location','northwest');
%% pol_th
figure(13)
H = mmpolar(a,xT_ph0,a,x50_T_ph0,a,xSh_T_ph0,...
    'Style','compass','TGridVisible','off',...
    'TTickOffset',0.05,'TTickDelta',30);
set(H,'LineWidth',3);
set(H(1),'color','r'); set(H(2),'color','b'); set(H(3),'color','g');
set(H(1),'LineStyle','-'); set(H(2),'LineStyle','--'); 
set(H(3),'LineStyle',':');
fig=gcf; set(findall(fig,'-property','Fontsize'),'Fontsize',14); grid off;
title('Monostatic RCS: XBand(9.675GHz) pol:\theta \phi:0^\circ');
legend({'open','500\Omega','short'},'Location','northwest');

figure(14)
H = mmpolar(a,xT_ph90,a,x50_T_ph90,a,xSh_T_ph90,...
    'Style','compass','TGridVisible','off',...
    'TTickOffset',1,'TTickDelta',30);
set(H,'LineWidth',3);
set(H(1),'color','r'); set(H(2),'color','b'); set(H(3),'color','g');
set(H(1),'LineStyle','-'); set(H(2),'LineStyle','--'); 
set(H(3),'LineStyle',':');
fig=gcf; set(findall(fig,'-property','Fontsize'),'Fontsize',14); grid off;
title('Monostatic RCS: XBand(9.675GHz) pol:\theta \phi:90^\circ');
legend({'open','500\Omega','short'},'Location','northwest');
%}