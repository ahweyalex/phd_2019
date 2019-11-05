clear all; close all; clc;

% ra=0.3; ri=0.3; phi=2; N=5; O=1; wT=1; h=(1.1)*(2*wT*N); Nz=3;
%[xS0,yS0,zS0] = constrWireAnt(h,ra,ri,phi,Nz,O,wT,N);

W0=0.3; L0=0.3; phi=2; N=1; O=1; wT=0.1; h=(1.1)*(2*wT*N); Nz=1;
[xS0,yS0,zS0] = constrRectWire_v2(h,W0,L0,phi,N,O,wT);
 
% H=plot3(S0(:,1),S0(:,2),S0(:,3),S1(:,1),S1(:,2),S1(:,3));
p=numel(xS0)/2;
figure(1)
%H=plot3(xS0(1:p),yS0(1:p),zS0(1:p),xS0(p:end),yS0(p:end),zS0(p:end));
H=plot3(xS0,yS0,zS0);
set(H(1),'color','b'); set(H(1),'marker','o');  
% set(H(2),'marker','o');set(H(2),'color','b'); 
xlabel('x'); ylabel('y'); zlabel('z'); 
view(0,90)