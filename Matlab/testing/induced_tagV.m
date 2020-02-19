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

function [tagV,tagRes,tag_selfL] = induced_tagV(M,I0,f,tag)
    mu0 = 4*pi*10^-7; %[H/m]
    mu = mu0*tag.ur;
    tagLength = (tag.N^2 * tag.r^2)/(9*tag.r + 10*tag.H);
    tagRes = tagLength/(pi*tag.r^2);
    tag_selfL = mu*(tag.N/tag.h)*(pi*tag.r^2);
    RL = 0.01;
    w = 2*pi*f;
    coeff = (1j*w*tag_selfL + tagRes)/(RL);
    tagV = M.*(1j*w*I0)/(coeff);
end