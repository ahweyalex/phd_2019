% plotting to see point values
[Ny Nx Nz] = size(X0);
nx = 1;
ny = 1;
nz = 1;

nx = Nx;
%ny = Ny;
%nz = Nz;

% Z
% XY_X     = squeeze(X0(:,:,nz));
% XY_Y     = squeeze(Y0(:,:,nz));
% XY_Z     = squeeze(Z0(:,:,nz));
% X
XY_X     = squeeze(X0(:,nx,:));
XY_Y     = squeeze(Y0(:,nx,:));
XY_Z     = squeeze(Z0(:,nx,:));
% Y
% XY_X     = squeeze(X0(ny,:,:));
% XY_Y     = squeeze(Y0(ny,:,:));
% XY_Z     = squeeze(Z0(ny,:,:));

XY_BX    = squeeze(BX0(:,:,nz)); % BX (vector)
XY_BY    = squeeze(BY0(:,:,nz)); % BY (vector)
XY_BZ    = squeeze(BZ0(:,:,nz)); % BZ (vector)
normB = sqrt(BX0.^2+BY0.^2+BZ0.^2);
XY_normB = squeeze(normB(:,:,nz)); % B  (magnitude)  
FS = 12;
%%

figure
[M0_XY,c_XY]=contour(XY_X,XY_Y,XY_normB);
xlabel('x[m]','FontWeight','bold','FontSize', FS); 
ylabel('y[m]','FontWeight','bold','FontSize', FS);
title(['XY-Plane (nz/Nz):',num2str((nz)),'/',num2str(Nz)],'FontWeight',...
    'bold','FontSize', FS);
grid on; 
axis tight;
view(0,90);
colorbar;

%%
hold all
figure(1) 
H = plot3(XY_X,XY_Y,XY_Z);
xlabel('x[m]','FontWeight','bold','FontSize', FS); 
ylabel('y[m]','FontWeight','bold','FontSize', FS);
title(['XY-Plane (nz/Nz):',num2str((nz)),'/',num2str(Nz)],'FontWeight',...
    'bold','FontSize', FS);
grid on; 
axis tight;
view(45,45);
zlim([-0.0015 Z0(1,1,Nz)]);
xlim([X0(1,1,1) X0(1,Nx,1)]);
ylim([Y0(1,1,1) Y0(Ny,1,1)]);