% Alexander Moreno
% DATE: 08-20-2020
% DESCRIPTION: Exports
%
aSize = numel(Sx); 
aXYZ = {'x[m]','y[m]','z[m]'};
for n=1:aSize
    aXYZ{n+1,1} = Sx(n);
    aXYZ{n+1,2} = Sy(n);
    aXYZ{n+1,3} = Sz(n);
end
writecell(aXYZ,'antenna.csv');
%  B-Fields
bSize = Nx*Ny*Nz;
Xcsv = reshape(B0.X,bSize,1);
Ycsv = reshape(B0.Y,bSize,1);
Zcsv = reshape(B0.Z,bSize,1);
BXcsv = reshape(B0.BX,bSize,1);
BYcsv = reshape(B0.BY,bSize,1);
BZcsv = reshape(B0.BZ,bSize,1);
BFC   = {'x[m]','y[m]','z[m]','BX','BY','BZ'};
BFA   = num2cell([Xcsv,Ycsv,Zcsv,BXcsv,BYcsv,BZcsv]);
BF    = [BFC;BFA];
writecell(aXYZ,'BFields_AllPoints.csv');
%
% XY
XYN       = Nx*Ny;
XY_Xr     = reshape(XY_X,XYN,1);
XY_Yr     = reshape(XY_Y,XYN,1);
XY_Zr     = reshape(XY_Z,XYN,1);
XY_normBr = reshape(XY_normB,XYN,1); 
XYC       = {'x[m]','y[m]','|B|'};
XYBF      = num2cell([XY_Xr,XY_Zr,XY_normBr]);
BF        = [XYC;XYBF];
writecell(BF,'Magnitude_BFields_XY.csv');
% XZ
XZN       = Nx*Nz;
XZ_Xr     = reshape(XZ_X,XZN,1);
XZ_Yr     = reshape(XZ_Y,XZN,1);
XZ_Zr     = reshape(XZ_Z,XZN,1);
XZ_normBr = reshape(XZ_normB,XZN,1); 
XZC       = {'x[m]','z[m]','|B|'};
XZBF      = num2cell([XZ_Xr,XZ_Zr,XZ_normBr]);
BF        = [XZC;XZBF];
writecell(BF,'Magnitude_BFields_XZ.csv');
% YZ
YZN       = Nx*Nz;
YZ_Xr     = reshape(YZ_X,YZN,1);
YZ_Yr     = reshape(YZ_Y,YZN,1);
YZ_Zr     = reshape(YZ_Z,YZN,1);
YZ_normBr = reshape(YZ_normB,YZN,1); 
YZC       = {'y[m]','z[m]','|B|'};
YZBF      = num2cell([YZ_Xr,YZ_Zr,YZ_normBr]);
BF        = [YZC;YZBF];
writecell(BF,'Magnitude_BFields_YZ.csv');