% alexander moreno
% date: 07-08-2020 
%
% Create plots between fast and slow for indutance
% Create plots between the different number of points in x and y planes
% 
%%
% 
clear all; close all; clc;
% x-lower bound: -ri/2
% x-upper bound:  ri/2
% y-lower bound: -ri/2
% y-upper bound:  ri/2

% numSeg: 200
% Nx: 100
% Ny: 100
Nz100 = [1,2,3,5,50,100];
% fast
LF100  = [2.5094e-09, 14.969e-09, 14.969e-09, 14.969e-09,...
    14.969e-09, 14.969e-09];
tF100 = [0.124, 0.251, 0.291, 0.432, 4.73, 9.202]; % seconds
% slow
LS100 = [2.5094e-09, 14.969e-09, 14.969e-09, 14.969e-09,...
    14.969e-09, 14.969e-09];
tS100 = [0.397,0,0,1.236,11.53,22.77]; % seconds
% plots
n=1;
figure(n)
H = plot(Nz100,tF100, Nz100,tS100);
set(H(1),'color','r'); set(H(2),'color','b');
set(H,'linewidth',3);
set(H(2),'linestyle','--');
legend('fast','slow');
title('Nx:100 Ny:100','fontweight','bold','fontsize',16);
xlabel('Nz','fontweight','bold','fontsize',16);
ylabel('time[s]','fontweight','bold','fontsize',16);
n=n+1;
figure(n)
H = plot(Nz100,LF100./1e-9, Nz100,LS100./1e-9);
%H = loglog(Nz100,LF100./1e-9, Nz100,LS100./1e-9);
set(H(1),'color','r'); set(H(2),'color','b');
set(H,'linewidth',3);
set(H(2),'linestyle','--');
legend('fast','slow');
title('Nx:100 Ny:100','fontweight','bold','fontsize',16);
xlabel('Nz','fontweight','bold','fontsize',16);
ylabel('Indutance [nH]','fontweight','bold','fontsize',16);
%%
clear all; close all; clc;
% x-lower bound: -ri/2
% x-upper bound:  ri/2
% y-lower bound: -ri/2
% y-upper bound:  ri/2
% numSeg: 200
% Nx: 150
% Ny: 150
Nz150 = [1,5,50,100,150];
% fast
LF150 = [2.5225e-09, 16.387e-9, 16.387e-9, 16.387e-9, 16.387e-9];
tF150 = [0.215, 0.82, 10.45, 20.68, 30.72];
% slow
LS150 = [2.5225e-09, 16.387e-9, 16.387e-9, 16.387e-9, 16.387e-9];
tSl50 = [0.82, 2.62, 25.7, 51.49, 76.95];
n=1;
figure(n)
H = plot(Nz150,tF150, Nz150,tSl50);
set(H(1),'color','r'); set(H(2),'color','b');
set(H,'linewidth',3);
set(H(2),'linestyle','--');
legend('fast','slow');
title('Nx:100 Ny:100','fontweight','bold','fontsize',16);
xlabel('Nz','fontweight','bold','fontsize',16);
ylabel('time[s]','fontweight','bold','fontsize',16);
n=n+1;
figure(n)
H = plot(Nz150,LF150./1e-9, Nz150,LS150./1e-9);
%H = loglog(Nz100,LF100./1e-9, Nz100,LS100./1e-9);
set(H(1),'color','r'); set(H(2),'color','b');
set(H,'linewidth',3);
set(H(2),'linestyle','--');
legend('fast','slow');
title('Nx:100 Ny:100','fontweight','bold','fontsize',16);
xlabel('Nz','fontweight','bold','fontsize',16);
ylabel('Indutance [nH]','fontweight','bold','fontsize',16);

%%
clear all; close all; clc;
% x-lower bound: -ri/2
% x-upper bound:  ri/2
% y-lower bound: -ri/2
% y-upper bound:  ri/2
N = [100,200,300,...
    400,500,600,...
    700,800,1000,...
    1500,2000,2500,...
    2800,3000];
L = [14.969e-9, 17.39e-9, 18.801e-9,...
    19.8e-9, 20.574e-9,21.207e-9,...
    21.741e-9,22.204e-9,22.977e-9,...
    24.382e-9,25.378e-09,26.151e-09,... 
    26.543e-9, 26.782e-9];
Lmax = 26.219*ones(1,14);
n=1;
figure(n)
H = plot(N,L./1e-9, N,Lmax);
set(H(1),'color','r'); set(H(2),'color','b');
set(H(2),'linestyle','--');
set(H,'linewidth',3);
title('Indutance','fontweight','bold','fontsize',16);
xlabel('Nx/Ny','fontweight','bold','fontsize',16);
ylabel('Indutance [nH]','fontweight','bold','fontsize',16);

