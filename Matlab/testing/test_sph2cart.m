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
figure(2)
H2=plot3(x,y,z,'r-');
xlabel('x');ylabel('y');zlabel('z');
grid on;
set(H2,'LineWidth',3);
view(45,45)
xlim([-1 1]);
ylim([-1 1]);
zlim([-1 1]);