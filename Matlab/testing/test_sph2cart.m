%%
clear all; close all; clc;

az = linspace(0,45*(pi/180),2);
el = linspace(0,45*(pi/180),2);
r  = linspace(0,1,2); 
[x,y,z] = sph2cart(az,el,r);
%{
figure(1)
H1=plot(x,y,'o');
xlabel('x');ylabel('y');zlabel('z');
grid on;
set(H1,'LineWidth',3);
%}
%
figure(2)
H2=plot3(x,y,z,'r-');
xlabel('x');ylabel('y');zlabel('z');
grid on;
set(H2,'LineWidth',3);
view(45,45)
xlim([-1 1]);
ylim([-1 1]);
zlim([-1 1]);
%}
%% rotate
dx=xS(1)-xS(end);
dy=yS(1)-yS(end);
dz=zS(1)-zS(end);

az=90;
el=0;
[rx,ry,rz]=sph2cart(az,el,dz);

p=[xS',yS',zS']*vrrotvec2mat(vrrotvec([dx dy dz],[rx ry rz]));
sx=p(:,1)+xS(1);
sy=p(:,2)+yS(1);
sz=p(:,3)+zS(1);

H=plot3(sx,sy,sz);
%% circle
clear all; close all; clc;
radius=2;
N=20;
load('data_antUI.mat')

T = linspace(0,2*pi,N);
R = linspace(0,radius,N);
Z = linspace(1,1,N);
% rotate 
dx=xS(1)-xS(end);
dy=yS(1)-yS(end);
dz=zS(1)-zS(end);
az=90;
el=0;
[rx,ry,rz]=sph2cart(az,el,dz);
p=[T',R',Z']*vrrotvec2mat(vrrotvec([dx dy dz],[rx ry rz]));
sx=p(:,1)+xS(1);
sy=p(:,2)+yS(1);
sz=p(:,3)+zS(1);

%[TT,RR] = meshgrid(T,R);
[TT,RR] = meshgrid(sx,sy);
X = RR.*cos(TT);
Y = RR.*sin(TT);
Z = ones(size(X));
%
hold all
figure(1)
surf(X,Y,Z)
surf(X,Y,5*Z)
%}
%%
cylinder