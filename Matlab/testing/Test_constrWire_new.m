clear all; close all; clc;

%wT=0.0002546;
wT=0.1;
ra=0.3; ri=0.3; phi=2; N=2; O=1;h=(1.1)*(2*wT*N); Nxy=2;
%W0=0.3; L0=0.3; phi=2; N=2; O=1;h=(1.1)*(2*wT*N); Nxy=2;
[xS0,yS0,zS0] = constrWireAnt(h,ra,ri,phi,N,O,wT,Nxy);
%[xS0,yS0,zS0] = constrRectWire(h,W0,L0,phi,N,O,wT,Nxy);
%[xS0,yS0,zS0] = constrWireAnt_2(h,ra,ri,phi,N,O,wT,Nxy);
  
%nn=round(numel(xS0)/2);
figure(1)
%H=plot3(xS0(1:nn),yS0(1:nn),zS0(1:nn),xS0(nn+1:end),yS0(nn+1:end),zS0(nn+1:end));
H=plot3(xS0,yS0,zS0);
set(H(1),'color','b'); %set(H(1),'marker','o');
%set(H(1),'Linestyle','-');  
%set(H(2),'marker','o'); set(H(2),'color','r');
set(H,'marker','o');
xlabel('x'); ylabel('y'); zlabel('z');  
grid on;
view(0,90)