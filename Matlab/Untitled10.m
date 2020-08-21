nz = 4;
fontSize = 14;
%
% nz = 70; % testing
% recall that B0.? is formatted as the following, where "?" is X,Y, or Z
% B0.?(ny,nx,nz), where n? represents the index to respecting "?"
% Therefore if you want to plot something in the xy-plane the following
% format is recommend to be used B0.?(:,:,nz)
%{
XY_X     = squeeze(B0.X(:,:,nz));
XY_Y     = squeeze(B0.Y(:,:,nz));
XY_Z     = squeeze(B0.Z(:,:,nz));
Z        = zeros(Ny,Nx);
XY_BX    = squeeze(B0.BX(:,:,nz));
XY_BY    = squeeze(B0.BY(:,:,nz));
XY_BZ    = squeeze(B0.BZ(:,:,nz));
XY_normB = squeeze(normB(:,:,nz));
%}

XY_X     = squeeze(X(:,:,nz));
XY_Y     = squeeze(Y(:,:,nz));
XY_Z     = squeeze(Z(:,:,nz));
Z        = zeros(Ny,Nx);
XY_BX    = squeeze(BX(:,:,nz));
XY_BY    = squeeze(BY(:,:,nz));
XY_BZ    = squeeze(BZ(:,:,nz));
XY_normB = squeeze(normB(:,:,nz));
%%
%{
nz=1;
hold on;
figure(1)
% ----------- antenna -------------% 
%H=plot3(Sx,Sy,Sz,'-');
%lw = 1.5;
%set(H,'color','r'); set(H,'linewidth',lw);
% ----------- magnitude -----------% 
[M0_XY,c_XY]=contourf(XY_X,XY_Y,XY_normB);
%c_XY.ContourZLevel = XY_Z(1,1);
% ----------- quiver --------------%
%Q=quiver3(XY_X,XY_Y,XY_Z, XY_BX,XY_BY,XY_BZ);
%set(Q,'color','m');
%Q.MaxHeadSize = 0.5;
%Q.AutoScaleFactor = 0.5;
%Q.MarkerSize = 0.25;
% ----------- plot props -----------%
xlabel('x[m]','FontWeight','bold','FontSize', fontSize); 
ylabel('y[m]','FontWeight','bold','FontSize', fontSize);
title(['XY-Plane (nz/Nz):',num2str((nz)),'/',num2str(Nz)],'FontWeight',...
    'bold','FontSize', fontSize);
grid on; %axis tight;
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
Q=quiver3(XY_X,XY_Y,Z, XY_BX,XY_BY,XY_BZ);
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
%}

%
%% PLOT: XZ PLANE
% (working)
if(Ny>1)
    ny = floor(Ny/2);
else
    ny = 1;
end
ny =25; % testing
% recall that B0.? is formatted as the following, where "?" is X,Y, or Z
% B0.?(ny,nx,nz), where n? represents the index to respecting "?"
% Therefore if you want to plot something in the xy-plane the following
% format is recommend to be used B0.?(:,:,nz)
XZ_X     = squeeze(B0.X(ny,:,:));
XZ_Y     = squeeze(B0.Y(ny,:,:));
XZ_Z     = squeeze(B0.Z(ny,:,:));
Y        = zeros(Nx,Nz);
XZ_BX    = squeeze(B0.BX(ny,:,:));
XZ_BY    = squeeze(B0.BY(ny,:,:));
XZ_BZ    = squeeze(B0.BZ(ny,:,:));
XZ_normB = squeeze(normB(ny,:,:));  
%%
%{
%[M0_XZ,c_XZ]=contourf(XZ_X,XZ_Z,XZ_normB);
Q=quiver3(XZ_X,XZ_Y,XZ_Z, XZ_BX,XZ_BY,XZ_BZ);
set(Q,'color','r');
direction = [1 0 0];
rotate(Q,direction,90)
xlabel('x'); ylabel('y'); zlabel('z');
%}
%{
hold on;
% ----------- antenna -------------% 
%H=plot3(Sx,Sy,Sz,'-');
%direction = [0 0 1];
%rotate(H,direction,90)
%direction = [1 0 0];
%rotate(H,direction,90)
%lw = 5;
%set(H,'color','r'); set(H,'linewidth',lw);
% ----------- magnitude -----------% 
[M0_XZ,c_XZ]=contourf(XZ_X,XZ_Z,XZ_normB);
%c_XZ.ContourZLevel =  XZ_Y(1,1);
c_XZ.ContourZLevel = 0;
contourcbar;
% ----------- quiver --------------%
Q=quiver3(XZ_X,XZ_Z,Y, XZ_BX,XZ_BZ,XZ_BY);
%Q=quiver(XZ_X,XZ_Z, XZ_BX,XZ_BZ);
Q.MaxHeadSize = 1;
Q.AutoScaleFactor = 1.5;
set(Q,'color','r');
% ----------- plot props -----------%
xlabel('x[m]','FontWeight','bold','FontSize', fontSize); 
ylabel('z[m]','FontWeight','bold','FontSize', fontSize);
title(['XZ-Plane (ny/Ny):',num2str((ny)),'/',num2str(Ny)],'FontWeight',...
    'bold','FontSize', fontSize);
grid on; 
%axis tight;
view(0,90);
contourcbar;
saveas(gcf,'MagBFields_XZPlane.png')
hold off;
%}

%
%% PLOT: YZ PLANE
% working on
if(Nx>1)
    nx = floor(Nx/2);
else
    nx = 1;
end
nx = 51; % testing
% recall that B0.? is formatted as the following, where "?" is X,Y, or Z
% B0.?(ny,nx,nz), where n? represents the index to respecting "?"
% Therefore if you want to plot something in the xy-plane the following
% format is recommend to be used B0.?(:,:,nz)
YZ_X     = squeeze(B0.X(:,nx,:));
YZ_Y     = squeeze(B0.Y(:,nx,:));
YZ_Z     = squeeze(B0.Z(:,nx,:));
Z        = zeros(Ny,Nz);
YZ_BX    = squeeze(B0.BX(:,nx,:));
YZ_BY    = squeeze(B0.BY(:,nx,:));
YZ_BZ    = squeeze(B0.BZ(:,nx,:));
YZ_normB = squeeze(normB(:,nx,:));  

%
hold all;
%figure(3)
% ----------- antenna -------------% 
%
H=plot3(Sx,Sy,Sz,'-');
direction = [0 0 1];
rotate(H,direction,180)
direction = [1 0 0];
rotate(H,direction,90)
lw = 1;
set(H,'color','r'); set(H,'linewidth',lw);

% ----------- magnitude -----------% 
[M0_YZ,c_YZ]=contourf(YZ_Y,YZ_Z,YZ_normB);
c_YZ.ContourZLevel = YZ_X(1,1);
%c_YZ.ContourZLevel = 0;
contourcbar;
% ----------- quiver --------------%
%Q=quiver3(XZ_X,XZ_Z,XZ_Y, XZ_BX,XZ_BY,XZ_BZ); %XZ
Q=quiver3(YZ_Y,YZ_Z,YZ_X, YZ_BX,YZ_BY,YZ_BZ);
Q.MaxHeadSize = 10;
Q.AutoScaleFactor = 10;
set(Q,'color','w');
% ----------- plot props -----------%
xlabel('y[m]','FontWeight','bold','FontSize', fontSize); 
ylabel('z[m]','FontWeight','bold','FontSize', fontSize);
title(['YZ-Plane (nx/Nx):',num2str((nx)),'/',num2str(Nx)],'FontWeight',...
    'bold','FontSize', fontSize);
view(0,90); grid on; axis tight;
saveas(gcf,'MagBFields_YZPlane.png')
hold off;
%}