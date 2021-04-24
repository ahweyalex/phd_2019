l  = 10; % inches
D  = 8;  % inches
N  = 50;
lw = ((3.14*D)*N)/12; %feet

FR = (246/lw)*(0.37*log(l/D)+1.06);
%%
m2in = 39.3701;
% l  = 5.3e-3 * m2in;
% D  = 70.50e-3 * m2in;
% N  = 14;

l  = 1.8e-3 * m2in;
D  = 70.50e-3 * m2in;
N  = 7;

lw = ((3.14*D)*N)/12; %feet
FR = (246/lw)*(0.37*log(l/D) + 1.06);
%%
L  = 27.69e-6;
f0 = 1/(2*pi*sqrt(L));
F0 = 2*pi*1;
%%
m2in = 39.3701;
% l  = 5.3e-3 * m2in;
% D  = 70.50e-3 * m2in;
% N  = 14;

l  = 5.3e-3;
D  = 70.50e-3;
N  = 14;
% l  = 1.8e-3 * m2in;
% D  = 70.50e-3 * m2in;
% N  = 7;

%l  = 1.3;
%D  = 1.6; % in
%N  = 70;

lw = ((3.14*D)*N)/12; %feet
%FR = (246/lw)*(0.37*log(l/D) + 1.06);% in ft and in
FR = (75/lw)*(0.37*log(l/D) + 1.06); 

%%
% % To resonate the antenna enough inductive reactance (XL) is needed to
% % cancel the capacitive reactance (Xa) at the feedpoint, i.e. 
% % XL=Xa (figure 6.1):
% % f [MHz]
% % L [uH]
% L = XL/(2*pi*f);
% 
% 0.2<l/D<10 and 0.33<d/c<0.7

% ref [6] and [8]


