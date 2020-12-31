clear all; close all; clc;

N = 10;
x = linspace(-10,10,N)';
y = linspace(-10,10,N)';
z = linspace(0,10,2)';
[X,Y,Z] = meshgrid(x,y,z);
nx = 1;
X2 = squeeze(X(:,:,nx));
Y2 = squeeze(Y(:,:,nx));
Z2 = squeeze(Z(:,:,nx));

a=0; b=0; g=90;
[RX,RY,RZ] = rotate_loop2(X2,Y2,Z2,a,b,g);
a=0; b=0; g=-90;
[RX2,RY2,RZ2] = rotate_loop2(RX,RY,RZ,a,b,g);
a=0; b=0; g=-45;
[RX3,RY3,RZ3] = rotate_loop2(RX,RY,RZ,a,b,g);
%%
FS=16;

figure(1)
H = surf(X2,Y2,Z2);
xlabel('x','FontSize', FS, 'Color', 'g', 'FontWeight', 'bold'); 
ylabel('y','FontSize', FS, 'Color', 'r', 'FontWeight', 'bold');
zlabel('z','FontSize', FS, 'Color', 'b', 'FontWeight', 'bold');
view(45,45);
xlim([-10 10]); ylim([-10 10]); zlim([-10 10]);
title('XY-Plane Spatial  Points at Z=0');

figure(2)
H = surf(RX,RY,RZ);
xlabel('x','FontSize', FS, 'Color', 'g', 'FontWeight', 'bold'); 
ylabel('y','FontSize', FS, 'Color', 'r', 'FontWeight', 'bold');
zlabel('z','FontSize', FS, 'Color', 'b', 'FontWeight', 'bold');
view(45,45);
xlim([-10 10]); ylim([-10 10]); zlim([-10 10]);
title('(A) rotated by \gamma = 90^\circ');
%
figure(3)
H = surf(RX3,RY3,RZ3);
xlabel('x','FontSize', FS, 'Color', 'g', 'FontWeight', 'bold'); 
ylabel('y','FontSize', FS, 'Color', 'r', 'FontWeight', 'bold');
zlabel('z','FontSize', FS, 'Color', 'b', 'FontWeight', 'bold');
view(45,45);
xlim([-10 10]); ylim([-10 10]); zlim([-10 10]);
title('(A) rotated by \gamma = -45^\circ');

figure(4)
H = surf(RX2,RY2,RZ2);
xlabel('x','FontSize', FS, 'Color', 'g', 'FontWeight', 'bold'); 
ylabel('y','FontSize', FS, 'Color', 'r', 'FontWeight', 'bold');
zlabel('z','FontSize', FS, 'Color', 'b', 'FontWeight', 'bold');
view(45,45);
xlim([-10 10]); ylim([-10 10]); zlim([-10 10]);
title('(B) rotated by \gamma = -90^\circ');