% Alexander Moreno
% DATE: 08-20-2020
% DESCRIPTION: Plots and saves figures as PNG
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Sx
% Description: 
% UNITS: [m] ARRAY: 1xNs
%
%
% Sy
% Description: 
% UNITS: [m] ARRAY: 1xNs
%
%
% Sz
% Description: 
% UNITS: [m] ARRAY: 1xNs
%
%
% X
% Description: 
% UNITS: [m] ARRAY: Ny by Nx by Nz
%
%
% Y
% Description: 
% UNITS: [m] ARRAY: Ny by Nx by Nz
%
%
% Z
% Description: 
% UNITS: [m] ARRAY: Ny by Nx by Nz
%
%
%
% BX
% Description: 
% UNITS: [m] ARRAY: Ny by Nx by Nz
%
%
% BY
% Description: 
% UNITS: [m] ARRAY: Ny by Nx by Nz
%
%
%
% nx
% Description: 
% UNITS: [m] ARRAY: 1x1
%
%
% ny
% Description: 
% UNITS: [m] ARRAY: 1x1
%
%
% nz
% Description: 
% UNITS: [m] ARRAY: 1x1
%
%
function [] = plot_BF_Ant(Sx,Sy,Sz,X,Y,Z,BX,BY,BZ,nx,ny,nz)
    % initialize variables 
    fontSize = 14;
    normB = sqrt(BX.^2+BY.^2+BZ.^2);
    nBX   = BX./normB;
    nBY   = BY./normB;
    nBZ   = BZ./normB;
    [Ny,Nx,Nz] = size(X); % get the dims of X/Y/Z and BX/BY/BZ
    % checks if the n? is out of bounds of N?
    % ? is a place holder for x, y, or z
    if(nx>Nx)
        nx=1;
    end
    if(ny>Ny)
        ny=1;
    end
    if(nz>Nz)
        nz=1;
    end
% -------------------- PLOT: BFIELDS (XY-PLANE) ------------------------- %
    % 1) Note that B0.? is formatted as the following, where "?" is X,Y, 
    %or Z. B0.?(ny,nx,nz), where n? represents the index to respecting "?"
    % Therefore if you want to plot something in the xy-plane the following
    % format is recommend to be used B0.?(:,:,nz)
    % 2)squeeze reduces the matrix by 1 dim so this 3multi-dim matrix/array
    % is now a 2 dim matrix/array
    XY_X     = squeeze(X(:,:,nz));
    XY_Y     = squeeze(Y(:,:,nz));
    XY_Z     = squeeze(Z(:,:,nz));
    Z0        = zeros(Ny,Nx);
    XY_BX    = squeeze(BX(:,:,nz)); % BX (vector)
    XY_BY    = squeeze(BY(:,:,nz)); % BY (vector)
    XY_BZ    = squeeze(BZ(:,:,nz)); % BZ (vector)
    XY_normB = squeeze(normB(:,:,nz)); % B  (magnitude)   
    % plotting stuff
    p = 'xy'
  
hold on;
figure(1)
% ----------- antenna -------------% 
H=plot3(Sx,Sy,Sz,'-');
lw = 1.5;
set(H,'color','r'); set(H,'linewidth',lw);
% ----------- magnitude -----------% 
[M0_XY,c_XY]=contour(XY_X,XY_Y,XY_normB);
%c_XY.ContourZLevel = XY_Z(1,1);
% ----------- quiver --------------%
Q=quiver3(XY_X,XY_Y,XY_Z, XY_BX,XY_BY,XY_BZ);
set(Q,'color','m');
Q.MaxHeadSize = 0.5;
Q.AutoScaleFactor = 0.5;
Q.MarkerSize = 0.25;
% ----------- plot props -----------%
xlabel('x[m]','FontWeight','bold','FontSize', fontSize); 
ylabel('y[m]','FontWeight','bold','FontSize', fontSize);
title(['XY-Plane (nz/Nz):',num2str((nz)),'/',num2str(Nz)],'FontWeight',...
    'bold','FontSize', fontSize);
hold on; grid on; axis tight;
view(0,90);
% ----------- save figure -----------%
% makes figure max size and saves as pdf
set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, 1, 0.96]);
set(gcf,'Units','inches');
screenposition = get(gcf,'Position');
set(gcf,...
    'PaperPosition',[0 0 screenposition(3:4)],...
    'PaperSize',[screenposition(3:4)]);
print -dpdf -painters Mag_BF_XY
%%
% ---------------------------- COLOR -------------------  % 
clc; close all;
hold on;
figure(1)
% ----------- antenna -------------% 
H=plot3(Sx,Sy,Sz,'-');
lw = 1.5;
set(H,'color','r'); set(H,'linewidth',lw);
% ----------- magnitude (color) -----------% 
[M0_XY,c_XY]=contourf(XY_X,XY_Y,XY_normB);
c_XY.ContourZLevel = 0;
contourcbar;
% ----------- quiver --------------%
Q=quiver3(XY_X,XY_Y,XY_Z, XY_BX,XY_BY,XY_BZ);
set(Q,'color','w');
Q.MaxHeadSize = 0.5;
Q.AutoScaleFactor = 0.5;
Q.MarkerSize = 0.25;
% ----------- plot props -----------%
xlabel('x[m]','FontWeight','bold','FontSize', fontSize); 
ylabel('y[m]','FontWeight','bold','FontSize', fontSize);
title(['XY-Plane (nz/Nz):',num2str((nz)),'/',num2str(Nz)],'FontWeight',...
    'bold','FontSize', fontSize);
hold on; grid on; axis tight;
view(0,90);
% ----------- save figure -----------%
% makes figure max size and saves as pdf
set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, 1, 0.96]);
set(gcf,'Units','inches');
screenposition = get(gcf,'Position');
set(gcf,...
    'PaperPosition',[0 0 screenposition(3:4)],...
    'PaperSize',[screenposition(3:4)]);
saveas(gcf,'Mag_BF_XY_color.pdf');
%print -dpdf -painters Mag_BF_XY_color
clc; close all;
%%
%-------------------------------------------------------------------------%
% -------------------- PLOT: BFIELDS (XZ-PLANE) ------------------------- %
    XZ_X     = squeeze(X(ny,:,:));
    XZ_Y     = squeeze(Y(ny,:,:));
    XZ_Z     = squeeze(Z(ny,:,:));
    Y0       = zeros(Nx,Nz);
    XZ_BX    = squeeze(BX(ny,:,:)); % BX (vector)
    XZ_BY    = squeeze(BY(ny,:,:)); % BY (vector)
    XZ_BZ    = squeeze(BZ(ny,:,:)); % BZ (vector)
    XZ_normB = squeeze(normB(ny,:,:)); % B  (magnitude) 
    % plotting stuff
        p = 'xz'
hold on;
figure(1)
% ----------- antenna -------------% 
%H=plot3(Sx,Sy,Sz,'-');
%lw = 1.5;
%set(H,'color','r'); set(H,'linewidth',lw);
% ----------- magnitude -----------% 
[M0_XZ,c_XZ]=contour(XZ_X,XZ_Z,XZ_normB);
% ----------- quiver --------------%
Q=quiver3(XZ_X,XZ_Z,Y0, XZ_BX,XZ_BZ,XZ_BY);
set(Q,'color','m');
Q.MaxHeadSize = 0.5;
Q.AutoScaleFactor = 0.5;
Q.MarkerSize = 0.25;
% ----------- plot props -----------%
xlabel('x[m]','FontWeight','bold','FontSize', fontSize); 
ylabel('y[m]','FontWeight','bold','FontSize', fontSize);
title(['XZ-Plane (nz/Nz):',num2str((nz)),'/',num2str(Nz)],'FontWeight',...
    'bold','FontSize', fontSize);
hold on; grid on; axis tight;
view(0,90);
% ----------- save figure -----------%
% makes figure max size and saves as pdf
set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, 1, 0.96]);
set(gcf,'Units','inches');
screenposition = get(gcf,'Position');
set(gcf,...
    'PaperPosition',[0 0 screenposition(3:4)],...
    'PaperSize',[screenposition(3:4)]);
print -dpdf -painters Mag_BF_XZ
% ---------------------------- COLOR -------------------  % 
clc; close all;
hold on;
figure(1)
% ----------- antenna -------------% 
H=plot3(Sx,Sy,Sz,'-');
lw = 1.5;
set(H,'color','r'); set(H,'linewidth',lw);
% ----------- magnitude (color) -----------% 
[M0_XZ,c_XZ]=contourf(XZ_X,XZ_Z,XZ_normB);
c_XZ.ContourZLevel = 0;
contourcbar;
% ----------- quiver --------------%
Q=quiver3(XZ_X,XZ_Z,Y0, XZ_BX,XZ_BZ,XZ_BY);
set(Q,'color','w');
Q.MaxHeadSize = 0.5;
Q.AutoScaleFactor = 0.5;
Q.MarkerSize = 0.25;
% ----------- plot props -----------%
xlabel('x[m]','FontWeight','bold','FontSize', fontSize); 
ylabel('y[m]','FontWeight','bold','FontSize', fontSize);
title(['XZ-Plane (nz/Nz):',num2str((nz)),'/',num2str(Nz)],'FontWeight',...
    'bold','FontSize', fontSize);
hold on; grid on; axis tight;
view(0,90);
% ----------- save figure -----------%
% makes figure max size and saves as pdf
set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, 1, 0.96]);
set(gcf,'Units','inches');
screenposition = get(gcf,'Position');
set(gcf,...
    'PaperPosition',[0 0 screenposition(3:4)],...
    'PaperSize',[screenposition(3:4)]);
saveas(gcf,'Mag_BF_XZ_color.pdf');
%print -dpdf -painters Mag_BF_XZ_color
clc; close all;

%-------------------------------------------------------------------------%
% -------------------- PLOT: BFIELDS (YZ-PLANE) ------------------------- %
    YZ_X     = squeeze(X(:,nx,:));
    YZ_Y     = squeeze(Y(:,nx,:));
    YZ_Z     = squeeze(Z(:,nx,:));
    X0       = zeros(Ny,Nz);
    YZ_BX    = squeeze(BX(:,nx,:)); % BX (vector)
    YZ_BY    = squeeze(BY(:,nx,:)); % BY (vector)
    YZ_BZ    = squeeze(BZ(:,nx,:)); % BZ (vector)
    YZ_normB = squeeze(normB(:,nx,:)); % B  (magnitude) 
    % plotting stuff
hold on;

yz = 'yz'

figure(1)
% ----------- antenna -------------% 
%H=plot3(Sx,Sy,Sz,'-');
%lw = 1.5;
%set(H,'color','r'); set(H,'linewidth',lw);
% ----------- magnitude -----------% 
[M0_YZ,c_YZ]=contour(YZ_Y,YZ_Z,YZ_normB);
% ----------- quiver --------------%
Q=quiver3(YZ_Y,YZ_Z,X0, YZ_BY,YZ_BZ,YZ_BX);
set(Q,'color','m');
Q.MaxHeadSize = 0.5;
Q.AutoScaleFactor = 0.5;
Q.MarkerSize = 0.25;
% ----------- plot props -----------%
xlabel('x[m]','FontWeight','bold','FontSize', fontSize); 
ylabel('y[m]','FontWeight','bold','FontSize', fontSize);
title(['YZ-Plane (nz/Nz):',num2str((nz)),'/',num2str(Nz)],'FontWeight',...
    'bold','FontSize', fontSize);
hold on; grid on; axis tight;
view(0,90);
% ----------- save figure -----------%
% makes figure max size and saves as pdf
set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, 1, 0.96]);
set(gcf,'Units','inches');
screenposition = get(gcf,'Position');
set(gcf,...
    'PaperPosition',[0 0 screenposition(3:4)],...
    'PaperSize',[screenposition(3:4)]);
print -dpdf -painters Mag_BF_YZ
% ---------------------------- COLOR -------------------  % 
clc; close all;
hold on;
figure(1)
% ----------- antenna -------------% 
H=plot3(Sx,Sy,Sz,'-');
lw = 1.5;
set(H,'color','r'); set(H,'linewidth',lw);
% ----------- magnitude (color) -----------% 
[M0_YZ,c_YZ]=contourf(YZ_Y,YZ_Z,YZ_normB);
c_YZ.ContourZLevel = 0;
contourcbar;
% ----------- quiver --------------%
Q=quiver3(YZ_Y,YZ_Z,X0, YZ_BY,YZ_BZ,YZ_BX);
set(Q,'color','w');
Q.MaxHeadSize = 0.5;
Q.AutoScaleFactor = 0.5;
Q.MarkerSize = 0.25;
% ----------- plot props -----------%
xlabel('x[m]','FontWeight','bold','FontSize', fontSize); 
ylabel('y[m]','FontWeight','bold','FontSize', fontSize);
title(['YZ-Plane (nz/Nz):',num2str((nz)),'/',num2str(Nz)],'FontWeight',...
    'bold','FontSize', fontSize);
hold on; grid on; axis tight;
view(0,90);
% ----------- save figure -----------%
% makes figure max size and saves as pdf
set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, 1, 0.96]);
set(gcf,'Units','inches');
screenposition = get(gcf,'Position');
set(gcf,...
    'PaperPosition',[0 0 screenposition(3:4)],...
    'PaperSize',[screenposition(3:4)]);
saveas(gcf,'Mag_BF_YZ_color.pdf');
%print -dpdf -painters Mag_BF_YZ_color
clc; close all;    
end


