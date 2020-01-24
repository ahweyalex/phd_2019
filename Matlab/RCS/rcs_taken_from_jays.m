% Alexander Moreno
% 
% Code edited from Dr. Jay M
% Computes rcs of sphere 
%
clear all; close all; clc;
%% initialze variables 
c = 3e8;            % speed of light [m/s]
iterations = 100;   % approximation for infinity for the Mie series.
d = 0.3048;         % diameter [m]
r = d/2;            % radius [m]  

fn  = 1e3;          % numb freq
f_int = 3e9;        % start freq  
f_fin = 7e9;        % final freq

%% compute RCS for frequency range
for k=0:fn
    f = f_int + ((k/(fn+eps)) * (f_fin-f_int));
    Frequency(k+1) = f;
    lambda = c/(f);
    ka = (2*pi*r)/lambda;
    s  = sqrt(pi/(2*ka));
    n  = 1:iterations;
    [B1(n)] = besselj( n+1/2, ka);
    [B2(n)] = besselh( n+1/2, 2, ka);
    [B3(n)] = besselj( n+(1/2)-1, ka);
    [B4(n)] = besselh( n+(1/2)-1,2,ka);
    
    a(n) = (s*B1)./(s*B2);
    b(n) = (ka*s*B3 - n.*s.*B1) ./ (ka*s*B4 - n.*s.*B2);
    RCS(k+1) = ((lambda^2)/pi)*...
        (abs(sum( ((-1).^n).*(n+1/2).*(b(n)-a(n)) )))^2;
end

%% plot
plot(Frequency, 10.*log10(RCS));
set(gca, 'YScale', 'linear') ;
set(gca,'FontSize',14,'FontWeight','bold')
axis([f_int f_fin -60 20]); %Change plot axis
xticks(f_int:2:f_fin);      %Change the grid lines (x-axis)
yticks(-60:10:20);          %Cahnge the grid lines (y-axis)
title('RCS of perfect sphere versus Frequency','FontSize',15),...
xlabel('Frequency  \{GHz\}','FontSize',10),...
ylabel('RCS  \{dBm^2\}','FontSize',10) ;