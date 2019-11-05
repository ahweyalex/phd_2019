
function [xS0] = constrRect(x0,xi,N,hSize,one_co)
    xS0 = repmat(x0,N,1);   % creates repeating values (along z-dir)
    xS0(end-hSize:end)=[];  % removes half of the last section
    xS0 = [one_co*xi;xS0];         % concatenates half of a section
end