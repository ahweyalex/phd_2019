%clear all; close all; clc;

N = 10;
x = linspace(-10,10,N)';
y = linspace(-10,10,N)';
z = linspace(0,10,N)';
[X,Y,Z] = meshgrid(x,y,z);
%[X,Y] = meshgrid(x,y);
%Z = sin(X) + cos(Y);
%X2=X; Y2=Y; Z2=Z;

Nz = 1;
X2 = squeeze(X(:,:,Nz));
Y2 = squeeze(Y(:,:,Nz));
Z2 = squeeze(Z(:,:,Nz));

figure
H = surf(X2,Y2,Z2);
xlabel('x'); ylabel('y'); zlabel('z');
view(45,45);

%
a = 0; %90*(pi/180);
b = 0; %90*(pi/180);
g = 90*(pi/180);
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
X3 = reshape(X2,N*N,1)';
Y3 = reshape(Y2,N*N,1)';
Z3 = reshape(Z2,N*N,1)';
XYZ3 = [X3;Y3;Z3];
%
% old
% for inx=1:numel(X3)
%     rXYZ(inx,:,:) = R*XYZ3(inx,:,:)';
% end
rXYZ = R*XYZ3;
X4 = reshape(rXYZ(1,:,:),N,N);
Y4 = reshape(rXYZ(2,:,:),N,N);
Z4 = reshape(rXYZ(3,:,:),N,N);

figure
H = surf(X4,Y4,Z4);
xlim([-10 10]); ylim([-10 10]);
xlabel('x'); ylabel('y'); zlabel('z');
title('rot')
view(45,45);
%%
r = 1;
tag_x = max(max(x))/2;
tag_y = max(max(x))/2;

E = ((X4 + tag_x) ./r).^2 + ((Z4+tag_y) ./r).^2 <=1;
figure
imagesc(r,r,E.');
[idx] = find(E);
%BF = BFnorm(idx)';