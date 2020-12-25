clear all; close all; clc;

N = 10;
x = linspace(-10,10,N)';
y = linspace(-10,10,N)';
z = linspace(0,10,N)';
[X,Y,Z] = meshgrid(x,y,z);
Nz = 5;
X2 = squeeze(X(:,:,Nz));
Y2 = squeeze(Y(:,:,Nz));
Z2 = squeeze(Z(:,:,Nz));
%
figure
H = surf(X2,Y2,Z2);
xlabel('x');
ylabel('y');
zlabel('z');
%%
%{
t  = linspace(pi/4,pi/4,N)';
Rx = [1 0 0; 0 cos(t) -sin(t); 0 sin(t) cos(t)];
Ry = [cos(t) 0 sin(t); 0 1 0; -sin(t) 0 cos(t)];
Rz = [cos(t) -sin(t) 0; sin(t) cos(t) 0; 0 0 1];
xyzRx = Rx.*[x;y;z];
%Rx45 = subs(xyzRx, t, pi/4);
figure
fsurf(Rx45(1), Rx45(2), Rx45(3))
title('Rotating by \pi/4 about x, counterclockwise')
axis equal
%}
%%
a = 0;
b = 0;
g = -45;
r1 = [cos(a)*cos(b),...
      cos(a)*sin(b)*sin(g)-sin(a)*cos(g),...
      cos(a)*sin(b)*cos(g) + sin(a)*sin(g)];
r2 = [sin(a)*cos(b),...
      sin(a)*sin(b)*sin(g) + cos(a)*cos(g),...
      sin(a)*sin(b)*cos(g) - cos(a)*sin(g)];
r3 = [sin(b),...
      cos(b)*sin(g),...
      cos(b)*cos(g)];
R  = [r1;r2;r3];
X3 = reshape(X2,N*N,1);
Y3 = reshape(Y2,N*N,1);
Z3 = reshape(Z2,N*N,1);
XYZ3 = [X3,Y3,Z3];
%
for inx=1:numel(X3)
    rXYZ(inx,:,:) = R*XYZ3(inx,:,:)';
end
X4 = reshape(rXYZ(:,1,1),N,N);
Y4 = reshape(rXYZ(:,2,1),N,N);
Z4 = reshape(rXYZ(:,3,1),N,N);

figure
H = surf(X4,Y4,Z4);
xlabel('x');
ylabel('y');
zlabel('z');