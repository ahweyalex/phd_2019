clear all; close all; clc;
% file names
fn1 = 'Mono_RCS_Rect_Sband_2lam2lam_GND.csv';
fn2 = 'Mono_RCS_Rect_Sband_2lam2lam_GND_polPhTh.csv';
fn3 = 'Mono_RCS_Rect_Sband_2lam2lam_GND_FlipV.csv';
fn4 = 'Mono_RCS_Rect_Sband_2lam2lam_GND_FlipV_polPhTh.csv';
fn5 = 'Mono_RCS_Rect_Sband_2lam2lam3Q_GND.csv';
fn6 = 'Mono_RCS_Rect_Sband_2lam2lam3Q_GND_polPhTh.csv';
fn7 = 'Mono_RCS_Rect_Sband_2lam2lam3Q_GND_FlipV.csv';
fn8 = 'Mono_RCS_Rect_Sband_2lam2lam3Q_GND_FlipV_polPhTh.csv';
fn9 = 'Mono_RCS_Rect_Sband_2lam2lam_GND_F45.csv';
fn10 = 'Mono_RCS_Rect_Sband_2lam2lam_GND_F45_polPhTh.csv';
% import data
% 2 lam by 2 lam 
twoLam        = importdata(fn1);
twoLam_pol    = importdata(fn2);
% 2 lam by 2 lam flip
twoLamv       = importdata(fn3);
twoLamv_pol   = importdata(fn4);
% 2lam by 2lam flip 45
twoLam45 = importdata(fn9);
twoLam45_pol = importdata(fn10);
% 2 lam by 2 lam3Q
twoLam3Q      = importdata(fn5);
twoLam3Q_pol  = importdata(fn6);
% 2 lam by 2 lam3Q flip
twoLam3Qv     = importdata(fn7);
twoLam3Qv_pol = importdata(fn8);
% extract data
a= twoLam.data(:,1).*(pi/180);
% 2 lam by 2 lam
%tLam_p0     = twoLam.data(:,2);
%tLam_p90    = twoLam.data(:,3);
tLam_p0     = 20*log10(twoLam.data(:,2));
tLam_p90    = 20*log10(twoLam.data(:,3));
tLam_p0_ph  = 20*log10(twoLam_pol.data(:,2));
tLam_p90_ph = 20*log10(twoLam_pol.data(:,3));
tLam_p0_th  = 20*log10(twoLam_pol.data(:,4));
tLam_p90_th = 20*log10(twoLam_pol.data(:,5));
% 2 lam by 2 lam flip
tLamv_p0     = 20*log10(twoLamv.data(:,2));
tLamv_p90    = 20*log10(twoLamv.data(:,3));
tLamv_p0_ph  = 20*log10(twoLamv_pol.data(:,2));
tLamv_p90_ph = 20*log10(twoLamv_pol.data(:,3));
tLamv_p0_th  = 20*log10(twoLamv_pol.data(:,4));
tLamv_p90_th = 20*log10(twoLamv_pol.data(:,5));
% 2lam by 2lam flip 45 degrees
tLam45_p0     = 20*log10(twoLam45.data(:,2));
tLam45_p90    = 20*log10(twoLam45.data(:,3));
tLam45_p0_ph  = 20*log10(twoLam45_pol.data(:,2));
tLam45_p90_ph = 20*log10(twoLam45_pol.data(:,3));
tLam45_p0_th  = 20*log10(twoLam45_pol.data(:,4));
tLam45_p90_th = 20*log10(twoLam45_pol.data(:,5));

% 2 lam by 2 lam3Q
tLam3Q_p0     = 20*log10(twoLam3Q.data(:,2));
tLam3Q_p90    = 20*log10(twoLam3Q.data(:,3));
tLam3Q_p0_ph  = 20*log10(twoLam3Q_pol.data(:,2));
tLam3Q_p90_ph = 20*log10(twoLam3Q_pol.data(:,3));
tLam3Q_p0_th  = 20*log10(twoLam3Q_pol.data(:,4));
tLam3Q_p90_th = 20*log10(twoLam3Q_pol.data(:,5));
% 2 lam by 2 lam3Q flip
tLam3Qv_p0     = 20*log10(twoLam3Qv.data(:,2));
tLam3Qv_p90    = 20*log10(twoLam3Qv.data(:,3));
tLam3Qv_p0_ph  = 20*log10(twoLam3Qv_pol.data(:,2));
tLam3Qv_p90_ph = 20*log10(twoLam3Qv_pol.data(:,3));
tLam3Qv_p0_th  = 20*log10(twoLam3Qv_pol.data(:,4));
tLam3Qv_p90_th = 20*log10(twoLam3Qv_pol.data(:,5));
%% plots
% 2lam by 2lam
% total RCS
figure(1)
H = mmpolar(a,tLam_p0,a,tLamv_p0,a,tLam45_p0,...
    'Style','compass','TGridVisible','off',...
    'TTickOffset',0.05,'TTickDelta',30);
set(H,'LineWidth',3);
set(H(1),'color','r'); set(H(2),'color','b'); 
set(H(1),'LineStyle','-'); set(H(2),'LineStyle','--'); 
set(H(3),'color','k'); set(H(3),'LineStyle','-');
fig=gcf; set(findall(fig,'-property','Fontsize'),'Fontsize',14); grid off;
title('Monostatic RCS: 2 \lambda by 2 \lambda \phi:0^\circ');
% legend({'pos:horizontal','pos:vertical'},'Location','northwest');
legend({'pos:horizontal','pos:vertical','pos:45^\circ'},'Location','northwest');
figure(2)
H = mmpolar(a,tLam_p90,a,tLamv_p90,a,tLam45_p90,...
    'Style','compass','TGridVisible','off',...
    'TTickOffset',0.05,'TTickDelta',30);
set(H,'LineWidth',3);
set(H(1),'color','r'); set(H(2),'color','b');
set(H(1),'LineStyle','-'); set(H(2),'LineStyle','--'); 
fig=gcf; set(findall(fig,'-property','Fontsize'),'Fontsize',14); grid off;
title('Monostatic RCS: 2 \lambda by 2 \lambda \phi:90^\circ');
% legend({'pos:horizontal','pos:vertical'},'Location','northwest');
legend({'pos:horizontal','pos:vertical','pos:45^\circ'},'Location','northwest');
set(H(3),'color','k'); set(H(3),'LineStyle','-');

%% pol: phi
figure(3)
H = mmpolar(a,tLam_p0_ph,a,tLamv_p0_ph,a,tLam45_p0_ph,...
    'Style','compass','TGridVisible','off',...
    'TTickOffset',0.05,'TTickDelta',30);
set(H,'LineWidth',3);
set(H(1),'color','r'); set(H(2),'color','b');
set(H(1),'LineStyle','-'); set(H(2),'LineStyle','--'); 
fig=gcf; set(findall(fig,'-property','Fontsize'),'Fontsize',14); grid off;
title('Monostatic RCS: 2 \lambda by 2 \lambda  pol:\phi \phi:0^\circ');
% legend({'pos:horizontal','pos:vertical'},'Location','northwest');
legend({'pos:horizontal','pos:vertical','pos:45^\circ'},'Location','northwest');
set(H(3),'color','k'); set(H(3),'LineStyle','-');

figure(4)
H = mmpolar(a,tLam_p90_ph,a,tLamv_p90_ph,a,tLam45_p90_ph,...
    'Style','compass','TGridVisible','off',...
    'TTickOffset',0.05,'TTickDelta',30);
set(H,'LineWidth',3);
set(H(1),'color','r'); set(H(2),'color','b');
set(H(1),'LineStyle','-'); set(H(2),'LineStyle','--'); 
fig=gcf; set(findall(fig,'-property','Fontsize'),'Fontsize',14); grid off;
title('Monostatic RCS: 2 \lambda by 2 \lambda  pol:\phi \phi:90^\circ');
% legend({'pos:horizontal','pos:vertical'},'Location','northwest');
legend({'pos:horizontal','pos:vertical','pos:45^\circ'},'Location','northwest');
set(H(3),'color','k'); set(H(3),'LineStyle','-');

%% pol: theta
figure(5)
H = mmpolar(a,tLam_p0_th,a,tLamv_p0_th,a,tLam45_p0_th,...
    'Style','compass','TGridVisible','off',...
    'TTickOffset',0.05,'TTickDelta',30);
set(H,'LineWidth',3);
set(H(1),'color','r'); set(H(2),'color','b');
set(H(1),'LineStyle','-'); set(H(2),'LineStyle','--'); 
fig=gcf; set(findall(fig,'-property','Fontsize'),'Fontsize',14); grid off;
title('Monostatic RCS: 2 \lambda by 2 \lambda  pol:\theta \phi:0^\circ');
% legend({'pos:horizontal','pos:vertical'},'Location','northwest');
legend({'pos:horizontal','pos:vertical','pos:45^\circ'},'Location','northwest');
set(H(3),'color','k'); set(H(3),'LineStyle','-');

figure(6)
H = mmpolar(a,tLam_p90_th,a,tLamv_p90_th,a,tLam45_p90_th,...
    'Style','compass','TGridVisible','off',...
    'TTickOffset',0.05,'TTickDelta',30);
set(H,'LineWidth',3);
set(H(1),'color','r'); set(H(2),'color','b');
set(H(1),'LineStyle','-'); set(H(2),'LineStyle','--'); 
fig=gcf; set(findall(fig,'-property','Fontsize'),'Fontsize',14); grid off;
title('Monostatic RCS: 2 \lambda by 2 \lambda  pol:\theta \phi:90^\circ');
% legend({'pos:horizontal','pos:vertical'},'Location','northwest');
legend({'pos:horizontal','pos:vertical','pos:45^\circ'},'Location','northwest');
set(H(3),'color','k'); set(H(3),'LineStyle','-');

%}