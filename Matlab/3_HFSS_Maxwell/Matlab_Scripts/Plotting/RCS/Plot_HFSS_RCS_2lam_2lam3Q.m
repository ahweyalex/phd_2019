clear all; close all; clc;
% 2lam_2lam3Q
% P0T1
f1 = 'E0P0T1_2lam_2lam3Q.csv';
f2 = 'E0P0T1_2lam_2lam3Q_polPhTh.csv';
f3 = 'E0P0T1_2lam_2lam3Q_FlipV.csv';
f4 = 'E0P0T1_2lam_2lam3Q_FlipV_polPhTh.csv';
f5 = 'E0P0T1_2lam_2lam3Q_FlipVR.csv';
f6 = 'E0P0T1_2lam_2lam3Q_FlipVR_polPhTh.csv';
f7 = 'E0P0T1_2lam_2lam3Q_TopH.csv';
f8 = 'E0P0T1_2lam_2lam3Q_TopH_polPhTh.csv';
% P1T0
f01 = 'E0P1T0_2lam_2lam3Q.csv';
f02 = 'E0P1T0_2lam_2lam3Q_polPhTh.csv';
f03 = 'E0P1T0_2lam_2lam3Q_FlipV.csv';
f04 = 'E0P1T0_2lam_2lam3Q_FlipV_polPhTh.csv';
f05 = 'E0P1T0_2lam_2lam3Q_FlipVR.csv';
f06 = 'E0P1T0_2lam_2lam3Q_FlipVR_polPhTh.csv';
f07 = 'E0P1T0_2lam_2lam3Q_TopH.csv';
f08 = 'E0P1T0_2lam_2lam3Q_TopH_polPhTh.csv';
%% import data
E0P0T1          = importdata(f1);
E0P0T1_pol      = importdata(f2);
E0P0T1_FV       = importdata(f3); 
E0P0T1_FV_pol   = importdata(f4);
E0P0T1_VR       = importdata(f5);
E0P0T1_VR_pol   = importdata(f6);
E0P0T1_TopH     = importdata(f7);
E0P0T1_TopH_pol = importdata(f8);
%
E0P1T0          = importdata(f01);
E0P1T0_pol      = importdata(f02);
E0P1T0_FV       = importdata(f03); 
E0P1T0_FV_pol   = importdata(f04);
E0P1T0_VR       = importdata(f05);
E0P1T0_VR_pol   = importdata(f06);
E0P1T0_TopH     = importdata(f07);
E0P1T0_TopH_pol = importdata(f08);
%}
%% extract data from csv files
% P0T1
a = E0P0T1.data(:,1)*(pi/180);
% center
E0P0T1_p0       = 20*log10(E0P0T1.data(:,2));
E0P0T1_p90      = 20*log10(E0P0T1.data(:,3));
E0P0T1_polP_p0  = 20*log10(E0P0T1_pol.data(:,2));
E0P0T1_polP_p90 = 20*log10(E0P0T1_pol.data(:,3));
E0P0T1_polT_p0  = 20*log10(E0P0T1_pol.data(:,4));
E0P0T1_polT_p90 = 20*log10(E0P0T1_pol.data(:,5));
% center top 
E0P0T1_TopH_p0       = 20*log10(E0P0T1_TopH.data(:,2));
E0P0T1_TopH_p90      = 20*log10(E0P0T1_TopH.data(:,3));
E0P0T1_TopH_polP_p0  = 20*log10(E0P0T1_TopH_pol.data(:,2));
E0P0T1_TopH_polP_p90 = 20*log10(E0P0T1_TopH_pol.data(:,3));
E0P0T1_TopH_polT_p0  = 20*log10(E0P0T1_TopH_pol.data(:,4));
E0P0T1_TopH_polT_p90 = 20*log10(E0P0T1_TopH_pol.data(:,5));
% flip v
E0P0T1_FV_p0       = 20*log10(E0P0T1_FV.data(:,2));
E0P0T1_FV_p90      = 20*log10(E0P0T1_FV.data(:,3));
E0P0T1_FV_polP_p0  = 20*log10(E0P0T1_FV_pol.data(:,2));
E0P0T1_FV_polP_p90 = 20*log10(E0P0T1_FV_pol.data(:,3));
E0P0T1_FV_polT_p0  = 20*log10(E0P0T1_FV_pol.data(:,4));
E0P0T1_FV_polT_p90 = 20*log10(E0P0T1_FV_pol.data(:,5));
% flip v right
E0P0T1_VR_p0       = 20*log10(E0P0T1_VR.data(:,2));
E0P0T1_VR_p90      = 20*log10(E0P0T1_VR.data(:,3));
E0P0T1_VR_polP_p0  = 20*log10(E0P0T1_VR_pol.data(:,2));
E0P0T1_VR_polP_p90 = 20*log10(E0P0T1_VR_pol.data(:,3));
E0P0T1_VR_polT_p0  = 20*log10(E0P0T1_VR_pol.data(:,4));
E0P0T1_VR_polT_p90 = 20*log10(E0P0T1_VR_pol.data(:,5));
%}

%
% P1T0
a = E0P1T0.data(:,1)*(pi/180);
% center
E0P1T0_p0       = 20*log10(E0P1T0.data(:,2));
E0P1T0_p90      = 20*log10(E0P1T0.data(:,3));
E0P1T0_polP_p0  = 20*log10(E0P1T0_pol.data(:,2));
E0P1T0_polP_p90 = 20*log10(E0P1T0_pol.data(:,3));
E0P1T0_polT_p0  = 20*log10(E0P1T0_pol.data(:,4));
E0P1T0_polT_p90 = 20*log10(E0P1T0_pol.data(:,5));
% flip v
E0P1T0_FV_p0       = 20*log10(E0P1T0_FV.data(:,2));
E0P1T0_FV_p90      = 20*log10(E0P1T0_FV.data(:,3));
E0P1T0_FV_polP_p0  = 20*log10(E0P1T0_FV_pol.data(:,2));
E0P1T0_FV_polP_p90 = 20*log10(E0P1T0_FV_pol.data(:,3));
E0P1T0_FV_polT_p0  = 20*log10(E0P1T0_FV_pol.data(:,4));
E0P1T0_FV_polT_p90 = 20*log10(E0P1T0_FV_pol.data(:,5));
% flip v right
E0P1T0_VR_p0       = 20*log10(E0P1T0_VR.data(:,2));
E0P1T0_VR_p90      = 20*log10(E0P1T0_VR.data(:,3));
E0P1T0_VR_polP_p0  = 20*log10(E0P1T0_VR_pol.data(:,2));
E0P1T0_VR_polP_p90 = 20*log10(E0P1T0_VR_pol.data(:,3));
E0P1T0_VR_polT_p0  = 20*log10(E0P1T0_VR_pol.data(:,4));
E0P1T0_VR_polT_p90 = 20*log10(E0P1T0_VR_pol.data(:,5));
% center top 
E0P1T0_TopH_p0       = 20*log10(E0P1T0_TopH.data(:,2));
E0P1T0_TopH_p90      = 20*log10(E0P1T0_TopH.data(:,3));
E0P1T0_TopH_polP_p0  = 20*log10(E0P1T0_TopH_pol.data(:,2));
E0P1T0_TopH_polP_p90 = 20*log10(E0P1T0_TopH_pol.data(:,3));
E0P1T0_TopH_polT_p0  = 20*log10(E0P1T0_TopH_pol.data(:,4));
E0P1T0_TopH_polT_p90 = 20*log10(E0P1T0_TopH_pol.data(:,5));
%}
%% plots
%{
tck=0.15; lw=3;
% P0T1
%
% total
% cut plane 0
figure(1)
H = mmpolar(a,E0P0T1_p0,a,E0P0T1_TopH_p0 ,a,E0P0T1_FV_p0,a,E0P0T1_VR_p0,...
    'Style','compass','TGridVisible','off',...
    'TTickOffset',tck,'TTickDelta',30);
set(H,'LineWidth',lw);
% color
set(H(1),'color','r'); set(H(2),'color','b'); 
set(H(3),'color','k'); set(H(4),'color','g');
% lineStyle
set(H(1),'LineStyle','-'); set(H(2),'LineStyle','--');
set(H(3),'LineStyle','-.'); set(H(4),'LineStyle','-.');
fig=gcf; set(findall(fig,'-property','Fontsize'),'Fontsize',14); grid off;
%{
title({
% ['Far-Field Back-Scatter: 2 \lambda by 2.75 \lambda \phi:0^\circ'] 
['Far-Field Back-Scatter CutPlane:\phi:0^\circ'] 
[' ']});
% legend({'pos:horizontal','pos:vertical'},'Location','northwest');
legend({'Center Middle','Center Top',...
    'Vertical Top', 'Vertical Side'});
%}
%% cut plane 90
figure(2)
H = mmpolar(a,E0P0T1_p90,a,E0P0T1_TopH_p90 ,a,E0P0T1_FV_p90,a,...
    E0P0T1_VR_p90,...
    'Style','compass','TGridVisible','off',...
    'TTickOffset',tck,'TTickDelta',30);
set(H,'LineWidth',3);
% color
set(H(1),'color','r'); set(H(2),'color','b'); 
set(H(3),'color','k'); set(H(4),'color','g');
% lineStyle
set(H(1),'LineStyle','-'); set(H(2),'LineStyle','--');
set(H(3),'LineStyle','-.'); set(H(4),'LineStyle','-.');
fig=gcf; set(findall(fig,'-property','Fontsize'),'Fontsize',14); grid off;
%{
title({
% ['Far-Field Back-Scatter: 2 \lambda by 2.75 \lambda \phi:0^\circ'] 
['Far-Field Back-Scatter CutPlane:\phi:90^\circ'] 
[' ']});
% legend({'pos:horizontal','pos:vertical'},'Location','northwest');
legend({'Center Middle','Center Top',...
    'Vertical Top', 'Vertical Side'});
%}
%%
% pol: phi
figure(3)
H = mmpolar(a,E0P0T1_polP_p0,a,E0P0T1_TopH_polP_p0,...
    a,E0P0T1_FV_polP_p0,a,E0P0T1_VR_polP_p0,...
    'Style','compass','TGridVisible','off',...
    'TTickOffset',tck,'TTickDelta',30);
set(H,'LineWidth',3);
% color
set(H(1),'color','r'); set(H(2),'color','b'); 
set(H(3),'color','k'); set(H(4),'color','g');
% lineStyle
set(H(1),'LineStyle','-');  set(H(2),'LineStyle','--');
set(H(3),'LineStyle','-.'); set(H(4),'LineStyle','-.');
%{
title({
% ['Far-Field Back-Scatter: 2 \lambda by 2.75 \lambda \phi:0^\circ'] 
['Far-Field Back-Scatter Polarized:\phi CutPlane:\phi:0^\circ'] 
[' ']});
legend({'Center Middle','Center Top',...
    'Vertical Top', 'Vertical Side'});
%}
%%
figure(4)
H = mmpolar(a,E0P0T1_polP_p90,a,E0P0T1_TopH_polP_p90,...
    a,E0P0T1_FV_polP_p90,a,E0P0T1_VR_polP_p90,...
    'Style','compass','TGridVisible','off',...
    'TTickOffset',tck,'TTickDelta',30);
set(H,'LineWidth',lw);
% color
set(H(1),'color','r'); set(H(2),'color','b'); 
set(H(3),'color','k'); set(H(4),'color','g');
% lineStyle
set(H(1),'LineStyle','-');  set(H(2),'LineStyle','--');
set(H(3),'LineStyle','-.'); set(H(4),'LineStyle','-.');
%{
title({
% ['Far-Field Back-Scatter: 2 \lambda by 2.75 \lambda \phi:0^\circ'] 
['Far-Field Back-Scatter Polarized:\phi CutPlane:\phi:90^\circ'] 
[' ']});
legend({'Center Middle','Center Top',...
    'Vertical Top', 'Vertical Side'});
%}
%%
% pol: theta
figure(5)
H = mmpolar(a,E0P0T1_polT_p0,a,E0P0T1_TopH_polT_p0,...
    a,E0P0T1_FV_polT_p0,a,E0P0T1_VR_polT_p0,...
    'Style','compass','TGridVisible','off',...
    'TTickOffset',tck,'TTickDelta',30);
set(H,'LineWidth',lw);
% color
set(H(1),'color','r'); set(H(2),'color','b'); 
set(H(3),'color','k'); set(H(4),'color','g');
% lineStyle
set(H(1),'LineStyle','-');  set(H(2),'LineStyle','--');
set(H(3),'LineStyle','-.'); set(H(4),'LineStyle','-.');
%{
title({
% ['Far-Field Back-Scatter: 2 \lambda by 2.75 \lambda \phi:0^\circ'] 
['Far-Field Back-Scatter Polarized:\theta CutPlane:\phi:0^\circ'] 
[' ']});
legend({'Center Middle','Center Top',...
    'Vertical Top', 'Vertical Side'});
%}
%%
figure(6)
H = mmpolar(a,E0P0T1_polT_p90,a,E0P0T1_TopH_polT_p90,...
    a,E0P0T1_FV_polT_p90,a,E0P0T1_VR_polT_p90,...
    'Style','compass','TGridVisible','off',...
    'TTickOffset',tck,'TTickDelta',30);
set(H,'LineWidth',3);
% color
set(H(1),'color','r'); set(H(2),'color','b'); 
set(H(3),'color','k'); set(H(4),'color','g');
% lineStyle
set(H(1),'LineStyle','-');  set(H(2),'LineStyle','--');
set(H(3),'LineStyle','-.'); set(H(4),'LineStyle','-.');
%{
title({
% ['Far-Field Back-Scatter: 2 \lambda by 2.75 \lambda \phi:0^\circ'] 
['Far-Field Back-Scatter Polarized:\theta CutPlane:\phi:90^\circ'] 
[' ']});
legend({'Center Middle','Center Top',...
    'Vertical Top', 'Vertical Side'});
%}
%}

% P1T0
%
% total
% cut plane 0
tck=0.15; lw=3;
figure(1)
H = mmpolar(a,E0P1T0_p0,a,E0P1T0_TopH_p0 ,a,E0P1T0_FV_p0,a,E0P1T0_VR_p0,...
    'Style','compass','TGridVisible','off',...
    'TTickOffset',tck,'TTickDelta',30);
set(H,'LineWidth',3);
% color
set(H(1),'color','r'); set(H(2),'color','b'); 
set(H(3),'color','k'); set(H(4),'color','g');
% lineStyle
set(H(1),'LineStyle','-'); set(H(2),'LineStyle','--');
set(H(3),'LineStyle','-.'); set(H(4),'LineStyle','-.');
fig=gcf; set(findall(fig,'-property','Fontsize'),'Fontsize',14); grid off;
%{
title({
% ['Far-Field Back-Scatter: 2 \lambda by 2.75 \lambda \phi:0^\circ'] 
['Far-Field Back-Scatter CutPlane:\phi:0^\circ'] 
[' ']});
% legend({'pos:horizontal','pos:vertical'},'Location','northwest');
legend({'Center Middle','Center Top',...
    'Vertical Top', 'Vertical Side'});
%}
%% cut plane 90
figure(2)
H = mmpolar(a,E0P1T0_p90,a,E0P1T0_TopH_p90 ,a,E0P1T0_FV_p90,a,...
    E0P1T0_VR_p90,...
    'Style','compass','TGridVisible','off',...
    'TTickOffset',tck,'TTickDelta',30);
set(H,'LineWidth',3);
% color
set(H(1),'color','r'); set(H(2),'color','b'); 
set(H(3),'color','k'); set(H(4),'color','g');
% lineStyle
set(H(1),'LineStyle','-'); set(H(2),'LineStyle','--');
set(H(3),'LineStyle','-.'); set(H(4),'LineStyle','-.');
fig=gcf; set(findall(fig,'-property','Fontsize'),'Fontsize',14); grid off;
%{
title({
% ['Far-Field Back-Scatter: 2 \lambda by 2.75 \lambda \phi:0^\circ'] 
['Far-Field Back-Scatter CutPlane:\phi:90^\circ'] 
[' ']});
% legend({'pos:horizontal','pos:vertical'},'Location','northwest');
legend({'Center Middle','Center Top',...
    'Vertical Top', 'Vertical Side'});
%}
%%
% pol: phi
figure(3)
H = mmpolar(a,E0P1T0_polP_p0,a,E0P1T0_TopH_polP_p0,...
    a,E0P1T0_FV_polP_p0,a,E0P1T0_VR_polP_p0,...
    'Style','compass','TGridVisible','off',...
    'TTickOffset',tck,'TTickDelta',30);
set(H,'LineWidth',3);
% color
set(H(1),'color','r'); set(H(2),'color','b'); 
set(H(3),'color','k'); set(H(4),'color','g');
% lineStyle
set(H(1),'LineStyle','-');  set(H(2),'LineStyle','--');
set(H(3),'LineStyle','-.'); set(H(4),'LineStyle','-.');
%{
title({
% ['Far-Field Back-Scatter: 2 \lambda by 2.75 \lambda \phi:0^\circ'] 
['Far-Field Back-Scatter Polarized:\phi CutPlane:\phi:0^\circ'] 
[' ']});
legend({'Center Middle','Center Top',...
    'Vertical Top', 'Vertical Side'});
%}
%%
figure(4)
H = mmpolar(a,E0P1T0_polP_p90,a,E0P1T0_TopH_polP_p90,...
    a,E0P1T0_FV_polP_p90,a,E0P1T0_VR_polP_p90,...
    'Style','compass','TGridVisible','off',...
    'TTickOffset',tck,'TTickDelta',30);
set(H,'LineWidth',3);
% color
set(H(1),'color','r'); set(H(2),'color','b'); 
set(H(3),'color','k'); set(H(4),'color','g');
% lineStyle
set(H(1),'LineStyle','-');  set(H(2),'LineStyle','--');
set(H(3),'LineStyle','-.'); set(H(4),'LineStyle','-.');
%{
title({
% ['Far-Field Back-Scatter: 2 \lambda by 2.75 \lambda \phi:0^\circ'] 
['Far-Field Back-Scatter Polarized:\phi CutPlane:\phi:90^\circ'] 
[' ']});
legend({'Center Middle','Center Top',...
    'Vertical Top', 'Vertical Side'});
%}
%%
% pol: theta
lw=3;
figure(5)
H = mmpolar(a,E0P1T0_polT_p0,a,E0P1T0_TopH_polT_p0,...
    a,E0P1T0_FV_polT_p0,a,E0P1T0_VR_polT_p0,...
    'Style','compass','TGridVisible','off',...
    'TTickOffset',tck,'TTickDelta',30);
set(H,'LineWidth',lw);
% color
set(H(1),'color','r'); set(H(2),'color','b'); 
set(H(3),'color','k'); set(H(4),'color','g');
% lineStyle
set(H(1),'LineStyle','-');  set(H(2),'LineStyle','--');
set(H(3),'LineStyle','-.'); set(H(4),'LineStyle','-.');
%{
title({
% ['Far-Field Back-Scatter: 2 \lambda by 2.75 \lambda \phi:0^\circ'] 
['Far-Field Back-Scatter Polarized:\theta CutPlane:\phi:0^\circ'] 
[' ']});
legend({'Center Middle','Center Top',...
    'Vertical Top', 'Vertical Side'});
%}
%%
figure(6)
H = mmpolar(a,E0P1T0_polT_p90,a,E0P1T0_TopH_polT_p90,...
    a,E0P1T0_FV_polT_p90,a,E0P1T0_VR_polT_p90,...
    'Style','compass','TGridVisible','off',...
    'TTickOffset',tck,'TTickDelta',30);
set(H,'LineWidth',3);
% color
set(H(1),'color','r'); set(H(2),'color','b'); 
set(H(3),'color','k'); set(H(4),'color','g');
% lineStyle
set(H(1),'LineStyle','-');  set(H(2),'LineStyle','--');
set(H(3),'LineStyle','-.'); set(H(4),'LineStyle','-.');
%{
title({
% ['Far-Field Back-Scatter: 2 \lambda by 2.75 \lambda \phi:0^\circ'] 
['Far-Field Back-Scatter Polarized:\theta CutPlane:\phi:90^\circ'] 
[' ']});
legend({'Center Middle','Center Top',...
    'Vertical Top', 'Vertical Side'});
%}