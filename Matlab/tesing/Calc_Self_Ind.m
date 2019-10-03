% Alexander Moreno
% 05-13-2019
% ------------------------------------------------------------------------
% Description:
% Self Inductances
% 

function [M] = Calc_Self_Ind(BX,BY,BZ,ra,ri,N)
S  = ra*ri*pi;
B0 = BX+BY+BZ; 
M  = (S*N*B0)./I1;
end