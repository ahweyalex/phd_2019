function [] = sphere_rcs()
% SPHERE_RCS calculates the exact RCS for a perfect sphere of given diameter, using
%   the Mie series solution, given by equations 4-19, 4-16, and 4-17 in section
%   4.2 of "Radar Cross Section," by Eugene F. Knott, John F. Shaeffer, and
%   Michael T. Tuley (c1985 Artech House).

%   Inputs: Dia = diameter of sphere {inches}.
%           Freq = frequency {GHz} (a second frequency causes the RCS over the range
%                  between the two frequencies to be plotted.

close all
clear all
clc

% input parameters:
Dia = input('Sphere diameter {inches}? [12.0]:   ');  % diameter of perfect conducting sphere
if isempty(Dia)
  Dia = 12.0 ;                       % if no entry, the default diameter is 12".
end

%Input a start and stop frequency to simulate over a frequency range
%Make sure to put a comma or a space in between the start and stop
%frequency
Freq_input = input('Frequency [Start Frequency, End Frequency] {GHz}? [3.0]:   ', 's');  % frequency, in GHz
if isempty(Freq_input)
  Freq1 = 3.0 ;                      % if no entry, the default frequency is 3.0 GHz.
  Freq2 = 0 ;
  freq_steps = 0 ;
else
  [F1,rem] = strtok(Freq_input, ' ,') ; % search for tokens using space and/or comma delimiters.
  Freq1 = str2num(F1) ;
  if ~isempty(rem)
    F2 = strtok(rem,' ,') ;
    Freq2 = str2num(F2) ;
    freq_steps = 1000;                  %Change the number of points between frequency range
  else
    Freq2 = 0 ;
    freq_steps = 0 ;
  end
end


c = 2.997925e008 ;                  % speed of light {m/sec}.
ipm = 39.3700787402 ;               % conversion factor from inches to meters.
iterations = 100 ;                  % approximation for infinity for the Mie series.
r = Dia / 2 / ipm ;                 % calculate sphere radius {m}.

for k = 0 : freq_steps ;
  Freq = Freq1 + ( k / (freq_steps + eps) * ( Freq2 - Freq1 ) ) ;  % frequency range, in GHz.
  Frequency( k + 1 ) = Freq ;
  lambda = c / ( Freq * 1e9 ) ;     % calculate wavelength in meters for each frequency step.
  ka = 2 * pi * r / lambda ;        % a frequently used constant {dimensionless}.
  s = sqrt( pi / 2 / ka ) ;         % to convert cartesian Bessel and Hankel functions to
                                    %   spherical Bessel and Hankel functions, increase the
                                    %   ORDER of the function by 1/2, and multiply by 's'.
  n = 1 : iterations ;              % "n" is the ORDER of the Bessel and Hankel functions.

  [B1(n)] = besselj( n + 1/2, ka ) ;
  [B2(n)] = besselh( n + 1/2, 2, ka ) ;
  [B3(n)] = besselj( n + 1/2 - 1, ka ) ;
  [B4(n)] = besselh( n + 1/2 - 1, 2, ka ) ;
%   if any(any(ierr))                 % if any element in 'ierr' is non-zero...
%     disp('Warning: There was an accuracy error in evaluating a Bessel or Hankel function.')
%   end

  a(n) = ( s*B1 ) ./ ( s*B2 ) ;
  b(n) = ( ka * s*B3 - n .* s.*B1 ) ./ ...
         ( ka * s*B4 - n .* s.*B2 ) ;
  RCS(k+1) = (lambda^2 / pi) * ( abs( sum( (-1).^n .* ( n + 1/2 ) .* ( b(n) - a(n) ) ) ) )^2 ;
end


if ( freq_steps == 0 )              % if you specified RCS for a single frequency...
  % print the results in the command window:
  fprintf(1,'Sphere diameter {inches} \tFrequency {GHz} \t   RCS {m^2} \t RCS {dBm^2} \n ' ) ;
  fprintf(1,'\t  %2.1f \t\t         %4.3f \t       %6.5f \t      %4.2f \n\n', ...
          Dia, Freq1, RCS, 10*log10(RCS) ) ;
else

  q = input('\nRCS in dBm^2 {D} or in \m^2 {M} ?  [D]/M: ','s');
  if ~isempty(q) & ( q == 'm' | q == 'M' )
    h1 = plot( Frequency, RCS ) ;
    set(gca, 'YScale', 'linear') ;
%    set(gca, 'YTick', [min(RCS):(max(RCS)-min(RCS))/10:max(RCS)] ) ;
    title('RCS of perfect sphere versus Frequency','FontSize',15),...
      xlabel('Frequency  \{GHz\}','FontSize',10),...
      ylabel('RCS  \{m^2\}','FontSize',10) ;
  else
    h1 = plot( Frequency, 10.*log10(RCS) ) ;
    set(gca, 'YScale', 'linear') ;
    set(gca,'FontSize',14,'FontWeight','bold')
    axis([Freq1 Freq2 -60 20])              %Change plot axis
    xticks(Freq1:2:Freq2)                   %Change the grid lines (x-axis)
    yticks(-60:10:20)                       %Cahnge the grid lines (y-axis)
%    set(gca, 'YTick', [min(RCS):(max(RCS)-min(RCS))/10:max(RCS)] ) ;
    title('RCS of perfect sphere versus Frequency','FontSize',15),...
      xlabel('Frequency  \{GHz\}','FontSize',10),...
      ylabel('RCS  \{dBm^2\}','FontSize',10) ;
  end

   end

end
