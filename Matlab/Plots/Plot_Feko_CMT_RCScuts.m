% Alexander Moreno
% 02-13-2020
% 
% 
clear all; close all; clc;
%% CTM
fn = 'FEKO_mIndx_vs_modSig_lam_lam.dat';
A = importdata(fn);

modeIndx = A.data(:,1);
charMode = A.data(:,2);

figure(1)
H=plot(modeIndx,charMode,'-');
set(H,'color','b'); set(H,'linewidth',3); set(H,'marker','o');
title('Characterstic Mode','FontSize',12);
xlabel('Modal Significance'); ylabel('Mode Index');
grid on;
%% 
clear all; close all; clc;
% file names
%{
fn1='Mono_RCS_lam_lam_Ph0.dat';
fn2='Mono_RCS_lam_lam_Ph90.dat';
fn3='Mono_RCS_lam_lam_polPh_Ph0.dat';
fn4='Mono_RCS_lam_lam_polPh_Ph90.dat';
fn5='Mono_RCS_lam_lam_polTh_Ph0.dat';
fn6='Mono_RCS_lam_lam_polTh_Ph90.dat';
%}
fn1='Mono_RCS_2lam_2lam_Ph0.dat';
fn2='Mono_RCS_2lam_2lam_Ph90.dat';
fn3='Mono_RCS_2lam_2lam_polPh_Ph0.dat';
fn4='Mono_RCS_2lam_2lam_polPh_Ph90.dat';
fn5='Mono_RCS_2lam_2lam_polTh_Ph0.dat';
fn6='Mono_RCS_2lam_2lam_polTh_Ph90.dat';

% import data
lam_lam_Ph0       = importdata(fn1);
lam_lam_Ph90      = importdata(fn2);
lam_lam_polP_Ph0  = importdata(fn3);
lam_lam_polP_Ph90 = importdata(fn4);
lam_lam_polT_Ph0  = importdata(fn5);
lam_lam_polT_Ph90 = importdata(fn6);
% extract the values
a         = lam_lam_Ph0.data(:,1)*(pi/180);
ph0       = 20*log10(lam_lam_Ph0.data(:,2));
ph90      = 20*log10(lam_lam_Ph90.data(:,2));
polP_ph0  = 20*log10(lam_lam_polP_Ph0.data(:,2));
polP_ph90 = 20*log10(lam_lam_polP_Ph90.data(:,2));
polT_ph0  = 20*log10(lam_lam_polT_Ph0.data(:,2));
polT_ph90 = 20*log10(lam_lam_polT_Ph90.data(:,2));

data = [ph0,ph90,polP_ph0,polP_ph90,polT_ph0,polT_ph90];
pStr = {' ',' pol:\phi',' pol:\theta'};
pDeg = {' \phi:0^\circ',' \phi:90^\circ',' \phi:0^\circ',' \phi:90^\circ',...
    ' \phi:0^\circ',' \phi:90^\circ'};
for n=1:size(data,2)/2
    figure(n)
    H = mmpolar(a,data(:,n),a,data(:,n+1),...
        'Style','compass','TGridVisible','off',...
        'TTickOffset',0.14,'TTickDelta',30);
    fig=gcf; set(findall(fig,'-property','Fontsize'),'Fontsize',14); 
    set(H(1),'color','r');
    set(H(1),'lineStyle','-');
    set(H(2),'color','b');
    set(H(2),'lineStyle','-.');
    set(H,'LineWidth',2)
    grid off;
    legend('\phi:0^\circ','\phi:90^\circ','Location','northwest');
    title({
    %[strcat('Monostatic RCS (Plate:\lambda_0 by \lambda_0)',pStr{n})] 
    [strcat('Monostatic RCS (Plate:2\lambda_0 by 2\lambda_0)',pStr{n})] 
    [' '] 
    });
end