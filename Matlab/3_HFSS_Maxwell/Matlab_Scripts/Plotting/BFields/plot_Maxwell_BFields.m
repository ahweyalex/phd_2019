clear all; close all; clc;

N = 100;
%A = importdata('s3N_oct.fld');
A = importdata('s3N_oct.fld');
xx = reshape(A.data(:,1),N,N);
yy = reshape(A.data(:,2),N,N);
zz = reshape(A.data(:,3),N,N);
mm = reshape(A.data(:,4),N,N);
figure
H=surf(xx,yy,mm);
colorbar;
view(0,90)
title('octo'); xlabel('x'); ylabel('y');

A = importdata('s3N_sq.fld');
xs = reshape(A.data(:,1),N,N);
ys = reshape(A.data(:,2),N,N);
zs = reshape(A.data(:,3),N,N);
ms = reshape(A.data(:,4),N,N);
figure
H=surf(xx,yy,mm);
colorbar;
view(0,90)
title('square'); xlabel('x'); ylabel('y');

md = ms-mm;
figure
H=surf(xs,ys,md);
colorbar;
view(0,90)
title('diff'); xlabel('x'); ylabel('y');
