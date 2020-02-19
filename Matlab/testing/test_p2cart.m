%%
clear al; close all; clc;
hold all;
p = linspace(-pi/2,pi/2);
t = linspace(0,0);
z = linspace(1,1); 
[x,y,z] = pol2cart(t,p,z);
%
figure(1)
H1=plot3(x,y,z,'bo');
xlabel('x');ylabel('y');zlabel('z');
grid on;
set(H1,'LineWidth',3);
xlim([-2 2]);
ylim([-2 2]);
zlim([-2 2]);
view(0,90)
%% hold all
p = linspace(0,pi);
t = linspace(0.5,0.5);
z = linspace(0,1); 
[x,y,z] = pol2cart(t,p,z);
%
figure(1)
H2=plot3(x,y,z,'ro');
xlabel('x');ylabel('y');zlabel('z');
grid on;
set(H2,'LineWidth',3);
xlim([-2 2]);
ylim([-2 2]);
zlim([-2 2]);
view(0,90)
%%
az = linspace(0,pi/2);
el = linspace(0,0);
r  = linspace(7,7); 
[x,y,z] = sph2cart(az,el,r);
plot(x,y);
xlabel('x');ylabel('y');zlabel('z');