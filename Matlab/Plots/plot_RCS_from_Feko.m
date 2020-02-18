clear all; close all; clc;

%A = importdata('RCS_SBand_lam_lam.ffe');
A = importdata('RCS_gnd_plane_SBand_lam_lam_Total_Phi0to360.dat');
phi = A.data(:,1)*(pi/180);
rho = A.data(:,2);
db_rho = 20*log10(rho);

figure(1)
M = mmpolar(phi,rho,'Style','compass','TGridVisible','off',...
    'TTickOffset',0.15,'TTickDelta',30);
set(M,'color','b');
set(M,'LineWidth',2);
fig=gcf; 
set(findall(fig,'-property','Fontsize'),'Fontsize',14);
grid off;
%%
clear all; close all; clc;
fn1='RCS_2lam2lam_GND_only_ph0.dat';
fn2='RCS_2lam2lam_GND_only_ph90.dat';
fn3='RCS_2lam2lam3Q_GND_only_ph0.dat';
fn4='RCS_2lam2lam3Q_GND_only_ph90.dat';
twoLam_p0    = importdata(fn1);
twoLam_p90   = importdata(fn2);
twoLam3Q_p0  = importdata(fn3);
twoLam3Q_p90 = importdata(fn4);
% 2lam by 2lam
tlam_p0  = 20*log10(twoLam_p0.data(:,2));
tlam_p90 = 20*log10(twoLam_p90.data(:,2));
% 2lam3Q by 2lam3Q
tlam3Q_p0  = 20*log10(twoLam_p0.data(:,2));
tlam3Q_p90 = 20*log10(twoLam_p90.data(:,2));
% angle
a = twoLam_p0.data(:,1)*(pi/180);

figure(1)
H1 = mmpolar(a,tlam_p0,a,tlam_p90,...
    'Style','compass','TGridVisible','off',...
    'TTickOffset',0.1,'TTickDelta',30);
set(H1,'LineWidth',3);
set(H1(1),'color','r');     set(H1(2),'color','b'); 
set(H1(1),'LineStyle','-'); set(H1(2),'LineStyle','--'); 
fig=gcf; set(findall(fig,'-property','Fontsize'),'Fontsize',14); grid off;
% title('Monostatic RCS: 2\lambda by 2\lambda SBand(3.24GHz)');
title({ 
    ['Monostatic RCS: 2\lambda by 2\lambda SBand(3.24GHz)'] 
    [' ']
    });
legend({'\phi:0^\circ','\phi:90^\circ'},'Location','northwest');

figure(2)
H2 = mmpolar(a,tlam3Q_p0,a,tlam3Q_p90,...
    'Style','compass','TGridVisible','off',...
    'TTickOffset',0.05,'TTickDelta',30);
set(H2,'LineWidth',3);
set(H2(1),'color','r');     set(H2(2),'color','b'); 
set(H2(1),'LineStyle','-'); set(H2(2),'LineStyle','--'); 
fig=gcf; set(findall(fig,'-property','Fontsize'),'Fontsize',14); grid off;
legend({'\phi:0^\circ','\phi:90^\circ'},'Location','northwest');
title({ 
    ['Monostatic RCS: 2\lambda by 2.75\lambda SBand(3.24GHz)'] 
    [' ']
    });
