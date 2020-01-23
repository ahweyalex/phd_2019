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

%figure(2)
%M = polar(phi,db_rho);