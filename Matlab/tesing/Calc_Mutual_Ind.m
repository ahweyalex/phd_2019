% Alexander Moreno
% 05-13-2019
% ------------------------------------------------------------------------
% Description:
% Mutual Inductances
% 

function [M] = Calc_Mutual_Ind(BX,BY,BZ,I1,Ntag,tagR)
% th=0*(pi/180);  ph=0*(pi/180);
%  sin(th)*cos(ph)
S  = pi*tagR^2;
B0 = BX+BY+BZ; 
M  = (Ntag*S*B0)./I1;
end