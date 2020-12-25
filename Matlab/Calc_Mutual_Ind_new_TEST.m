% Alexander Moreno
% 12-24-2020
%
% Test Calc_Mutual_Ind_new
%-------------------------[INPUT PARAMETERS]-------------------------%
global tag;
% example
% radius = 0.5 [mm], length = 7 [mm], N = 250, AZ/EL = 0 [deg]
r  = 0.5e-3; 
l  = 7e-3;
N  = 250;
AZ = 0;
EL = 0;
xpos = 0;
ypos = 0;
ur   = 2.5; % common nickel-zinc
tag = struct('r',r,'l',l,'N',N,'AZ',AZ,'EL',EL,'Z',Z,...
             'xpos',xpos,'ypos',ypos,'ur',ur);
I2  = 1;

M12 = Calc_Mutual_Ind_new(BX1,BY1,BZ1,X1,Y1,I2,tag);
