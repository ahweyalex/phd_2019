% equation
% X_L = 2*pi*f*L

% from HFSS
A  = importdata('In_Im_EL_ra15_ri10_wT30AWG_Nxy1_N1.csv');
f  = A.data(:,1);
XL = A.data(:,2);
L  = XL./(2*pi*f);
%L_nH = L./1e-9;
%%
FS = 14;
figure(1)
% H = plot(f,L_nH);
H = plot(f,L);
xlabel('Freq [GHz]','fontweight','bold','fontsize',FS);
ylabel('Indutance [H]', 'fontweight','bold','fontsize',FS);
title('Ellipse ra15 ri10 wT30AWG','fontweight','bold','fontsize',FS);
%%
% lam = c/f
% f = lam*c
% f = ri*c ==> f = 4.5 MHz