clear all; close all; clc;

SCR = get(0,'Screensize');
% creates figure
fx = SCR(3)/4-200; fy = SCR(4)/4-200; fdx = 825+380; fdy = 400;
S.fh = figure('numbertitle','off',...
              'menubar','none',...
              'units','pixels',...
              'position',[fx ,fy , fdx, fdy],...
              'name','Wire Antenna Design Tool',...
              'resize','off');
% creates empty plot
px=50; py=100; pdx=300; pdy=230;
S.ax1 = axes('units','pixels','position',[50 100 300 230]);  
rotate3d on;
S.ax2 = axes('units','pixels','position',[750 100 300 230]);
grid on;
xlabel('x'); ylabel('y'); zlabel('z');
rotate3d on;
ax=gca;
%
a=linspace(1,100);
b=linspace(200,400);
%axes1 = axes('Parent',Parent1,'Position',[50 100 300 230],'Units','pixels');
%hold(axes1,'on');
HH1 = plot(a,b,'Parent',S.ax1);

%axes2 = axes('Parent',Parent1,'Position',[750 100 300 230],'Units','pixels');
%hold(axes1,'on');
HH2 = plot(a,sin(b),'Parent',S.ax2);
%H2 = plot(a,a);
%}


