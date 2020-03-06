% Alexander Moreno
% 02-18-2020
%
% Description: Computes induced voltage on tag from mutual indutcance 
% between multi-coil wire and tag
% =========================================================================
% Input Parameters
% =========================================================================
%
%
% =========================================================================
% Output Parameters
% =========================================================================
%
% =========================================================================

function [tagV,R2,L2] = induced_tagV(M,I0,f,tag)
    mu0  = 4*pi*10^-7; %[H/m]
    mu   = mu0*tag.ur;
    o_cu = 5.8*10^7; % [S/m] 
    tagLength = (tag.N^2 * tag.r^2)/(9*tag.r + 10*tag.L);
    tagA = pi*tag.r^2;
    %tagRes = tagLength/(pi*tag.r^2);
    R2 = tagLength/(o_cu*tagA);
    %tag_selfL = mu0*mu*(tag.N/tag.L)*(pi*tag.r^2);
    L2 = mu*(tag.N/tag.L)*(tagA);
    RL = 0.01;
    w = 2*pi*f;
    coeff = (1j*w*L2 + R2)/(RL);
    tagV = M.*(1j*w*I0.I)/(coeff);
end