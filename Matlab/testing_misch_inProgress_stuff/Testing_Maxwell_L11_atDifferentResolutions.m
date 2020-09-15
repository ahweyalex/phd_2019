clear all; close all; clc;

ri = 10e-3;
ra = 10e-3;
I  = 1;
G  = 's';
N  = 1;
res   = 219:225;
%res   = 519:525;
rSize = numel(res);
for n=1: rSize-1
    
    disp(strcat('Rect_ri10_ra10_res',....
                num2str(res(n)),...
                '.fld'))
            
    A  = importdata(strcat('Rect_ri10_ra10_res',....
                num2str(res(n)),...
                '.fld'));
    x  = reshape(A.data(:,1),res(n+1),res(n+1));
    y  = reshape(A.data(:,2),res(n+1),res(n+1));
    z  = reshape(A.data(:,3),res(n+1),res(n+1));
    bx = reshape(A.data(:,4),res(n+1),res(n+1));
    by = reshape(A.data(:,5),res(n+1),res(n+1));
    bz = reshape(A.data(:,6),res(n+1),res(n+1));
    
    t= 't';
    
    [L11(n)] = selfInductance_BFields(ri,ra,I,x,y,bz,N,G);
end
disp('done');