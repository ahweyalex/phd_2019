%
% DATE: 06-30-2021
% 
% plot b-fields

FS = 14; % font size
BX = SELF_IND.BX;
BY = SELF_IND.BY;
BZ = SELF_IND.BZ;
X = SELF_IND.X;
Y = SELF_IND.Y;
Z = SELF_IND.Z;
[Ny,Nx,Nz] = size(X); 
normB = sqrt(BX.^2+BY.^2+BZ.^2);
nx=1; ny=1; 
%nz=1;
%nz=5;
%nz=10;
%nz=25;
%nz=50;
%nz=75;
%nz=90;
%nz=95;
nz=100;

%nz=1*2;
%nz=5*2;
%nz=10*2;
%nz=25*2;
%nz=50*2;
%nz=75*2;
%nz=90*2;
%nz=95*2;
%nz=100*2;

% XY PLANE
XY_X     = squeeze(X(:,:,nz));
XY_Y     = squeeze(Y(:,:,nz));
XY_Z     = squeeze(Z(:,:,nz));
XY_BX    = squeeze(BX(:,:,nz)); % BX (vector)
XY_BY    = squeeze(BY(:,:,nz)); % BY (vector)
XY_BZ    = squeeze(BZ(:,:,nz)); % BZ (vector)
XY_normB = squeeze(normB(:,:,nz)); % B  (magnitude)  

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
