clear all; close all; clc;

ra=0.3; ri=0.3; phi=2; N=2; O=1; wT=0.1; h=(1.1)*(2*wT*N);
W0=2; L0=6; 

deltaS = 200; 
helixSTEP = phi*(pi/180);
start=0; fin = N*(2*pi) + helixSTEP/2;
cst_xxx = start:helixSTEP:fin;
cstSize = floor((numel(cst_xxx)/4)/N);

x = linspace(-W0/2,W0/2,cstSize)'; xc = W0*ones(1,cstSize)';
y = linspace(-L0/2,L0/2,cstSize)'; yc = L0*ones(1,cstSize)';
x0 = [x;xc;flipud(x);-xc];           y0 = [-yc;y;yc;flipud(y)];

xS0 = repmat(x0,N,1);
yS0 = repmat(y0,N,1);

zSize = numel(xS0);
zS0 = linspace(start,fin, zSize)';

%%
H1=plot3(xS0,yS0,zS0);
%H=plot(xS0,yS0);
title('rect wire');
xlabel('x'); ylabel('y'); 
%zlabel('z');
view(0,90)
%zS0 = ((h*cst_xxx)./(2*pi*N))';
