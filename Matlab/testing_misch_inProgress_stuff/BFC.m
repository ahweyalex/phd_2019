
function [Br,Bz,R,Z] = BFC(a,r,z)
    mu = 4*pi*1e-7;     % free space permeability <scalar> [H/m]
    I  = 1;
    [R,Z] = meshgrid(r,z);   
%--------------------------set upcoefficients-----------------------------%
    K = sqrt( (4.*R.*a) ./ (Z.^2 + (a+R).^2) );
    gamma_val   = sqrt(Z.^2 + (a+R).^2);
    epsilon_val = Z.^2 + (R-a).^2;
    [E1,E2] = ellipke(K.^2); 
%-----------------------------  Compute  ---------------------------------%    
    % Bz
    U = ((mu.*I)./(2.*pi.*gamma_val))... 
         .*(((a.^2 - Z.^2 - R.^2)./epsilon_val).*...
         E2 + E1);
    Bz = U;
    % Br
    V = ((mu.*I.*Z)./(2.*pi.*R.*gamma_val))...
         .*(((Z.^2 + R.^2 + a.^2)./epsilon_val).*...
         E2 - E1);
    Br = V; 
end