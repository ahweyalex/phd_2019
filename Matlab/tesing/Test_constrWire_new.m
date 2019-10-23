clear all; close all; clc;

ra=0.3; ri=0.3; phi=2; N=4; O=1; wT=1; h=(1.1)*(2*wT*N); Nz=3;
%[S0,S1] = constrWireAnt(h,ra,ri,phi,Nz,O,wT,N);
[xS0,yS0,zS0,xS1,yS1,zS1] = constrWireAnt(h,ra,ri,phi,Nz,O,wT,N);
 
% H=plot3(S0(:,1),S0(:,2),S0(:,3),S1(:,1),S1(:,2),S1(:,3));
H=plot3(xS0,yS0,zS0,xS1,yS1,zS1);
set(H(1),'color','r'); set(H(1),'color','b'); 
view(0,90)