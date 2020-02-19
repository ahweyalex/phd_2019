% Alexander Moreno
% 02-18-2020
%
% Description: Computes the mutual indtuance between solenoid with a  
% ferromagnetic core and B-Fields. 
%
% =========================================================================
% Input Parameters
% 
% B.BX
% B.BY
% B.BZ
%
% I
% 
% tag.N
%
% tag.L
%
% tag.r
%
% tag.ur
%
% tag.az(phi)
%
% tag.el(theta)
%
%
% =========================================================================
% Output Parameter:
% [M12]
%
% =========================================================================
function [M12] = Calc_Mutual_Ind(B0,I0,tag)
   % b-fields
   [n1,n2,n3] = size(B0.BX);
   nT = n1*n2*n3;
   BX = reshape(B0.BX,[nT,1]);
   BY = reshape(B0.BY,[nT,1]);
   BZ = reshape(B0.BZ,[nT,1]);
   B = [BX,BY,BZ];
   % tag
   Area  = pi*(tag.r)^2;
   coeff = Area*((tag.N*tag.ur)/(tag.L*I0));
   M12 = zeros(nT,1);
   [x,y,z] = sph2cart(tag.az,tag.el,L);
   tag_o = [x,y,z];
   % calc mutual indutcance  
   for idx=1:nT 
       M12(idx) = coeff*dot(B(idx,:),tag_o);
   end
   M12=reshape(M12,[n1,n2,n3]);
end