% Alexander Moreno
% RCS Circ
% match, short, open

clear all; close all; clc;
%% file names
fn1 = 'E0P0T1_Circ_Short.csv';
fn2 = 'E0P0T1_Circ_Short_polPhTh.csv';
fn3 = 'E0P0T1_Circ_Open.csv';
fn4 = 'E0P0T1_Circ_Open_polPhTh.csv';
fn5 = 'E0P0T1_Circ_Match.csv';
fn6 = 'E0P0T1_Circ_Match_polPhTh.csv';

% import data
% short
sh  = importdata(fn1);
shp = importdata(fn2);
% open
op  = importdata(fn3);
opp = importdata(fn4);
% match
mh  = importdata(fn5);
mhp = importdata(fn6);

% extract data
a = (pi/180)*sh.data(:,1);

% short
sh_p0     = 20*log10(sh.data(:,2));
sh_p90    = 20*log10(sh.data(:,3));
sh_p0_ph  = 20*log10(shp.data(:,2));
sh_p90_ph = 20*log10(shp.data(:,3));
sh_p0_th  = 20*log10(shp.data(:,4));
sh_p90_th = 20*log10(shp.data(:,5));
% open
op_p0     = 20*log10(op.data(:,2));
op_p90    = 20*log10(op.data(:,3));
op_p0_ph  = 20*log10(opp.data(:,2));
op_p90_ph = 20*log10(opp.data(:,3));
op_p0_th  = 20*log10(opp.data(:,4));
op_p90_th = 20*log10(opp.data(:,5));
% match
mh_p0     = 20*log10(mh.data(:,2));
mh_p90    = 20*log10(mh.data(:,3));
mh_p0_ph  = 20*log10(mhp.data(:,2));
mh_p90_ph = 20*log10(mhp.data(:,3));
mh_p0_th  = 20*log10(mhp.data(:,4));
mh_p90_th = 20*log10(mhp.data(:,5));

%% total
tck=0.15; lw=4;
% cut plane 0
figure(1)
H = mmpolar(a,sh_p0,a,op_p0,a,mh_p0,...
    'Style','compass','TGridVisible','off',...
    'TTickOffset',tck,'TTickDelta',30);
set(H(1),'color','r'); set(H(2),'color','b'); set(H(3),'color','g');
set(H(1),'LineStyle','-'); set(H(2),'LineStyle','-.');
set(H(3),'LineStyle','--');
set(H,'linewidth',lw);
fig=gcf; set(findall(fig,'-property','Fontsize'),'Fontsize',14); grid off;
%{
title({
['Far-Field Back-Scatter \phi:0^\circ'] 
[' ']});
% legend({'pos:horizontal','pos:vertical'},'Location','northwest');
legend({'Short','Open','Match'},'Location','northwest');
%}
%%
% cut plane 90
figure(2)
H = mmpolar(a,sh_p90,a,op_p90,a,mh_p90,...
    'Style','compass','TGridVisible','off',...
    'TTickOffset',tck,'TTickDelta',30);
set(H(1),'color','r'); set(H(2),'color','b'); set(H(3),'color','g');
set(H(1),'LineStyle','-'); set(H(2),'LineStyle','-.');
set(H(3),'LineStyle','--');
set(H,'linewidth',lw);
fig=gcf; set(findall(fig,'-property','Fontsize'),'Fontsize',14); grid off;
%{
title({
['Far-Field Back-Scatter \phi:0^\circ'] 
[' ']});
% legend({'pos:horizontal','pos:vertical'},'Location','northwest');
legend({'Short','Open','Match'},'Location','northwest');
%}
%% pol: phi
tck=0.15; lw=4;
figure(3)
H = mmpolar(a,sh_p0_ph,a,op_p0_ph,a,mh_p0_ph,...
    'Style','compass','TGridVisible','off',...
    'TTickOffset',tck,'TTickDelta',30);
set(H(1),'color','r'); set(H(2),'color','b'); set(H(3),'color','g');
set(H(1),'LineStyle','-'); set(H(2),'LineStyle','-.');
set(H(3),'LineStyle','--');
set(H,'linewidth',lw);
fig=gcf; set(findall(fig,'-property','Fontsize'),'Fontsize',14); grid off;
%{
title({
['Far-Field Back-Scatter \phi:0^\circ'] 
[' ']});
% legend({'pos:horizontal','pos:vertical'},'Location','northwest');
legend({'Short','Open','Match'},'Location','northwest');
%}
%%
% cut plane 90
figure(4)
H = mmpolar(a,sh_p90_ph,a,op_p90_ph,a,mh_p90_ph,...
    'Style','compass','TGridVisible','off',...
    'TTickOffset',tck,'TTickDelta',30);
set(H(1),'color','r'); set(H(2),'color','b'); set(H(3),'color','g');
set(H(1),'LineStyle','-'); set(H(2),'LineStyle','-.');
set(H(3),'LineStyle','--');
set(H,'linewidth',lw);
fig=gcf; set(findall(fig,'-property','Fontsize'),'Fontsize',14); grid off;
%{
title({
['Far-Field Back-Scatter \phi:0^\circ'] 
[' ']});
% legend({'pos:horizontal','pos:vertical'},'Location','northwest');
legend({'Short','Open','Match'},'Location','northwest');
%}
%% pol: theta
tck=0.15; lw=4;
figure(3)
H = mmpolar(a,sh_p0_th,a,op_p0_th,a,mh_p0_th,...
    'Style','compass','TGridVisible','off',...
    'TTickOffset',tck,'TTickDelta',30);
set(H(1),'color','r'); set(H(2),'color','b'); set(H(3),'color','g');
set(H(1),'LineStyle','-'); set(H(2),'LineStyle','-.');
set(H(3),'LineStyle','--');
set(H,'linewidth',lw);
fig=gcf; set(findall(fig,'-property','Fontsize'),'Fontsize',14); grid off;
%{
title({
['Far-Field Back-Scatter \phi:0^\circ'] 
[' ']});
% legend({'pos:horizontal','pos:vertical'},'Location','northwest');
legend({'Short','Open','Match'},'Location','northwest');
%}
%% cut plane 90
figure(4)
H = mmpolar(a,sh_p90_th,a,op_p90_th,a,mh_p90_th,...
    'Style','compass','TGridVisible','off',...
    'TTickOffset',tck,'TTickDelta',30);
set(H(1),'color','r'); set(H(2),'color','b'); set(H(3),'color','g');
set(H(1),'LineStyle','-'); set(H(2),'LineStyle','-.');
set(H(3),'LineStyle','--');
set(H,'linewidth',lw);
fig=gcf; set(findall(fig,'-property','Fontsize'),'Fontsize',14); grid off;
%{
title({
['Far-Field Back-Scatter \phi:0^\circ'] 
[' ']});
% legend({'pos:horizontal','pos:vertical'},'Location','northwest');
legend({'Short','Open','Match'},'Location','northwest');
%}