clear all; close all; clc;

NxNy = [50,100,200,300,400,800,1000];
S    = NxNy;
G    = 26*ones(numel(S),1); 

% bounded to (ri) or less
L11_ri = [1.0399e-08,1.1857e-08,1.1605e-08,...
     1.1526e-08, 1.1488e-08,  1.1431e-08,...
     1.1419e-08]*(1/1e-9);
% bounded to (ri+wT/2) or less
L11_pHwt = [1.0399e-08,1.1857e-08, 1.1605e-08,...
    1.1945e-08,1.1839e-08, 1.1799e-08,...
    1.1848e-08]*(1/1e-9);
% bounded to (ri+wT) or less
L11_pwt = [1.1351e-08,1.1857e-08,1.2078e-08,...
     1.2096e-08,1.2039e-08,1.2072e-08,...
       1.2062e-08]*(1/1e-9);
% bounded to (ri+wT*1.5) or less
L11_pOHwt = [1.1351e-08,1.1956e-08, 1.2017e-08,...
    1.2033e-08,1.2041e-08,1.2085e-08,...
    1.2081e-08]*(1/1e-9);
% bounded to (ri-wT/2) or less
L11_mHwt = [1.0399e-08,9.7916e-09, 1.0621e-08,...
    1.0887e-08, 1.0479e-08, 1.0683e-08,...
     1.0830e-08]*(1/1e-9);


%{
% bounded to (ri) or less
L11_ri = [1.2129e-08, 2.6828e-08, 4.0322e-08,...
    3.7964e-08, 3.3262e-08, 3.4449e-08,...
    4.4844e-08]*(1/1e-9);
% bounded to (ri+wT/2) or less
L11_pHwt = [1.2129e-08,2.6828e-08,4.0322e-08,... 
    3.4232e-08, 2.9383e-08,  2.8573e-08, ...
    3.7928e-08]*(1/1e-9);
% bounded to (ri+wT) or less
L11_pwt = [1.8811e-09,2.6828e-08,3.6414e-08,...
    3.2322e-08,2.7471e-08,2.5729e-08,...
    3.5722e-08]*(1/1e-9);
% bounded to (ri+wT*1.5) or less
L11_pOHwt = [1.8811e-09,2.2845e-08,3.4509e-08,...
    3.1099e-08,2.5347e-08,2.4640e-08,...
    3.4398e-08]*(1/1e-9);
% bounded to (ri-wT/2) or less
L11_mHwt = [1.2129e-08, 1.1162e-08,  3.4509e-08,...
    1.4953e-08, 1.3125e-08, 1.3968e-08,...
    1.4731e-08]*(1/1e-9);
%}

fontSize =12;
figure
H = plot(S,L11_pHwt, S,L11_pwt,... 
    S,L11_pOHwt, S,L11_mHwt);
    %S,G);
set(H(1),'Color','r'); set(H(2),'Color','b');
set(H(3),'Color','k'); set(H(4),'Color','g');
set(H(3),'Color','m');
set(H(1),'Linestyle','-'); set(H(2),'Linestyle','--');
set(H(3),'Linestyle','-'); set(H(4),'Linestyle','--');
%set(H(5),'Linestyle','-.');
set(H(1),'Marker','o'); set(H(2),'Marker','o');
set(H(3),'Marker','o'); set(H(4),'Marker','o');
set(H,'LineWidth',3); 
xlabel('NxNy','FontWeight','bold','FontSize', fontSize);
ylabel('L_{11} [nH]','FontWeight','bold','FontSize', fontSize);
%title('Rect Coil N:3 Nxy:0 Goal_{approx}:172nH Goal_{exact}:161nH','FontWeight','bold','FontSize', fontSize);
title('Single Rect Loop(Matlab Model)','FontWeight','bold','FontSize', fontSize);
legend('ri','ri+wT/2','ri+wT*1.5','ri-wT/2','Location','southeast');
%legend('ri','ri+wT/2','ri+wT*1.5','ri-wT/2','Goal(26nH)','Location','southeast');
%% Rect Loop N3
clear all; close all; clc;
NxNy = [50,100,200,300,400,800,1000];
Gapx = 172*ones(numel(NxNy),1);
Gext = 161.11*ones(numel(NxNy),1);
S    = NxNy;
% L11_N3
% bounded to (ri) or less
L11_N3_ri  = [1.0227e-07, 1.1039e-07, 1.0610e-07,... 
     1.0583e-07,1.0570e-07, 1.0551e-07,...
     1.0547e-07]*(1/1e-9);
% bounded to (ri+wT/2) or less
L11_N3_pHwt = [1.0227e-07,1.0692e-07,1.0610e-07,...
    1.0762e-07,1.0710e-07, 1.0693e-07...    
     1.0693e-07]*(1/1e-9);
% bounded to (ri+wT) or less
L11_N3_pwt = [1.1103e-07,1.0692e-07,1.0855e-07,...
    1.0899e-07,1.0826e-07,1.0863e-07,...
    1.0851e-07]*(1/1e-9);
% bounded to (ri+wT*1.5) or less
L11_N3_pOHwt = [1.1103e-07,1.1039e-07,1.1006e-07,...
    1.0994e-07,1.0989e-07,1.0947e-07,...
    1.0952e-07]*(1/1e-9);
% bounded to (ri-wT/2) or less
L11_N3_mHwt = [1.0227e-07,9.9867e-08,1.0278e-07,...
    1.0367e-07,1.0229e-07,1.0299e-07,...
    1.0348e-07]*(1/1e-9);

fontSize =12;
figure
%H = plot(S,L11_N3_ri,S,L11_N3_pHwt,S,Gapx, S,Gext);
H = plot(S,L11_N3_pHwt, S,L11_N3_pwt,... 
    S,L11_N3_pOHwt, S,L11_N3_mHwt);
set(H(1),'Color','r'); set(H(2),'Color','b');
set(H(3),'Color','k'); set(H(4),'Color','g');
set(H(1),'Linestyle','-'); set(H(2),'Linestyle','--');
set(H(3),'Linestyle','-'); set(H(4),'Linestyle','--');
set(H,'LineWidth',2);
set(H,'Marker','o');
xlabel('NxNy','FontWeight','bold','FontSize', fontSize);
ylabel('L_{11} [nH]','FontWeight','bold','FontSize', fontSize);
%title('Rect Coil N:3 Nxy:0 Goal_{approx}:172nH Goal_{exact}:161nH','FontWeight','bold','FontSize', fontSize);
title('Rect Coil N:3 Nxy:0 (Matlab Model)','FontWeight','bold','FontSize', fontSize);
legend('ri','ri+wT/2','ri+wT*1.5','ri-wT/2','Location','southeast');



%legend('ri','ri+wT/2','Goal:approx','Goal:exact');