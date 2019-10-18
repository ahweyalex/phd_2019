clear all; close all; clc;

deltaS = 200; N=2; phi=2;
helixSTEP = phi*(pi/180);
start=0; fin = N*(2*pi) + helixSTEP/2;
cst_xxx = start:helixSTEP:fin;
cstSize = floor(numel(cst_xxx)/4);
W0 = 2; L0 = 6; 

x = linspace(-W0/2,W0/2,cstSize); 
y = linspace(-L0/2,L0/2,cstSize);

%%
xS0 = cat(1,W0*ones(floor(deltaS/4),1),L0*ones(floor(deltaS/4),1),-W0*ones(floor(deltaS/4),1),-L0*ones(floor(deltaS/4),1));
yS0 = cat(1,W0*ones(floor(deltaS/4),1),L0*ones(floor(deltaS/4),1),-W0*ones(floor(deltaS/4),1),-L0*ones(floor(deltaS/4),1));