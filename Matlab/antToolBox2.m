% Alexander Moreno
% 02-25-2020
% 
% description: reviewing Matlab R2019b's Antenna Toolbox 4.1

hx = helix('Radius',28e-3,'Width',1.2e-3,'Turns',4);
show(hx);
f0 = 125e3;
pattern(hx,f0);
fStart = 120e3;
fStep  = 1e3;
fEnd   = 130e3;
%% Calculate Impedance of Antenna
%impedance(hx,fStart:fStep,fEnd);
impedance(hx,1.7e9:1e6:2.2e9)
%% Calculate Reflection Coefficient of Antenna
S = sparameters(hx,1.7e9:1e6:2.2e9,72);
rfplot(S)
%% Calculate Return Loss of Antenna
returnLoss(hx,1.7e9:1e6:2.2e9,72)
%% Calculate Voltage Standing Wave Ratio (VSWR) of Antenna
vswr(hx,1.7e9:1e6:2.2e9,72)
%% Calculate Current and Charge Distribution of Antenna
charge(hx,2.01e9)
figure
current(hx,2.01e9)
%% mesh
mesh(hx)