clear all; close all; clc;
N  = 100; 
ri = 10e-3;
A  = importdata('rect_bvector_xy.fld');
x  = reshape(A.data(:,1),N,N);
y  = reshape(A.data(:,2),N,N);
z  = reshape(A.data(:,3),N,N);
bx = A.data(:,4);
by = A.data(:,5);
bz = A.data(:,6);

b  = [bx,by];
for n=1:10000 
    bn(n) = norm(b(n,:));
end    
bn = reshape(bn,N,N);
%%
bx = reshape(A.data(:,4),N,N);
by = reshape(A.data(:,5),N,N);
bz = reshape(A.data(:,6),N,N);

si=26; sf=75;
x2 = x(si:sf,si:sf);
y2 = y(si:sf,si:sf);
z2 = z(si:sf,si:sf);
bx2 = bx(si:sf,si:sf);
by2 = by(si:sf,si:sf);
bz2 = bz(si:sf,si:sf);
bn2 = bn(si:sf,si:sf);
%% inductance'
% this works
% not used becauses its already in BFIELDS from MAXWELL
u0    = 4*pi*10^-7;          % Permeability  of free space
uc    = 1.256629*10^-6;      % Permeability of copper 
u     = u0*uc;
%
xdel  = 2.0202e-04;          % del x
ydel  = 2.0202e-04;          % del y
A     = xdel*ydel;           % area (ds)
%bn3   = bn2.*A;
bz3   = bz2.*A;
%sumB  = sum(sum(bn3,1),2);   % sum of Bz
sumB  = sum(sum(bz3,1),2);   % sum of Bz
%phi11 = u0*sumB*A;           % phi_11
phi11 = sumB;              % phi_11
L11   = phi11/1;             % self ind

%L11 =  -2.6267e-08