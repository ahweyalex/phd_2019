% define
% a: radius of coil
% b: axial lenght of coil 
% n: number of turns 
% K: induction reducion factor (unity in the limit of a long coil)
% L: indutance
% d: diagonal
% F(k), E(k): Complete elliptic intergrals 

mu0 = 4*pi*1e-7;   
 
 % long coil
 Kl = 1/(1 +(8/(3*pi))*a/b);
 % short coil
 Ks = log(1 + pi*(a/b)) + 0.4357;
 
 L = ((mu0*(n^2)*pi*a^2)/b)*K;
 