% Alexander Moreno
% DATE: 08-20-2020
% DESCRIPTION: Exports
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
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
% BZ
% Description: 
% UNITS: [m] ARRAY: Ny by Nx by Nz
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
% ALL
% Description: 
% UNITS: N/A ARRAY: 1x1 VALUES: 1 or not 1
%
function [] = export_BF_Ant(Sx,Sy,Sz,X,Y,Z,BX,BY,BZ,nx,ny,nz,ALL)
% -------- WRITE: antenna points (in cartesian coordinates) --------------% 
    %process = 'start export antenna'
    XYZc  = {'x[m]','y[m]','z[m]'}; % strings to indicate in the output/csv 
    % file that it is in [m]
    aXYZ = num2cell([Sx,Sy,Sz]);
    ANT  = [XYZc;aXYZ];
    writecell(ANT,'wire_antenna.csv');
    %process = 'done export antenna'
% ------------------- WRITE: BFIELDS (ALL POINTS)------------------------ %
    if(ALL==1)
        %process = 'start export BF ALL'
        [Ny,Nx,Nz] = size(X);
        bSize = Nx*Ny*Nz;
        BFC   = {'x[m]','y[m]','z[m]','BX','BY','BZ'};
        % X,Y,Z,BX,BY,BZ's dim size is (Ny by Nx by Nz), therefore each needs to 
        % become 1D array (size: Ny*Nx*Nz by 1)
        % SPATIAL LOCATION OF BFIELDS 
        Xcsv  = reshape(X,bSize,1);
        Ycsv  = reshape(Y,bSize,1);
        Zcsv  = reshape(Z,bSize,1);
        % BFIELD VECTORS
        BXcsv = reshape(BX,bSize,1);
        BYcsv = reshape(BY,bSize,1);
        BZcsv = reshape(BZ,bSize,1);
        % convert the values into cell array
        BFA   = num2cell([Xcsv,Ycsv,Zcsv,BXcsv,BYcsv,BZcsv]);
        % combine cell arrays into one
        BF    = [BFC;BFA];
        % print/write the cell onto a csv file named, BFIELDS_ALLPOINTS
        writecell(BF,'BFIELDS_ALLPOINTS.csv');
        %process = 'end export BF ALL'
    end
% ------------------- WRITE: BFIELDS (XY-PLANE) ------------------------- %
    %process = 'start export BF_XY'
    
    XYN  = Nx*Ny;   
    BFC   = {'x[m]','y[m]','z[m]','BX','BY','BZ'};
    % Obtain the desirable XY cut-plane
    % reshape --> X,Y,Z,BX,BY,BZ's dim size is (Ny by Nx by Nz), therefore 
    %each needs to become 1D array (size: Ny*Nx*Nz by 1)
    % SPATIAL LOCATION OF BFIELDS  
    XY_X = reshape(squeeze(X(:,:,nz)),XYN,1);
    XY_Y = reshape(squeeze(Y(:,:,nz)),XYN,1);
    XY_Z = reshape(squeeze(Z(:,:,nz)),XYN,1);
    % BFIELD VECTORS
    XY_BX = reshape(squeeze(BX(:,:,nz)),XYN,1);
    XY_BY = reshape(squeeze(BY(:,:,nz)),XYN,1);
    XY_BZ = reshape(squeeze(BZ(:,:,nz)),XYN,1);
    % convert the values into cell array
    XYBF  = num2cell([XY_X,XY_Y,XY_Z, XY_BX,XY_BY,XY_BZ]);
    % combine cell arrays into one
    BF    = [BFC;XYBF];
    % print/write the cell onto a csv file named, BFIELDS_XY
    writecell(BF,'BFIELDS_XY.csv');
    
    %process = 'end export BF_XY'
    % ------------------- WRITE: BFIELDS (XZ-PLANE) ------------------------- %
    %process = 'end export BF_XZ'
    %tic;
    
    XZN  = Nx*Nz;   
    BFC   = {'x[m]','y[m]','z[m]','BX','BY','BZ'};
    % Obtain the desirable XZ cut-plane
    % reshape --> X,Y,Z,BX,BY,BZ's dim size is (Ny by Nx by Nz), therefore 
    %each needs to become 1D array (size: Ny*Nx*Nz by 1)
    % SPATIAL LOCATION OF BFIELDS  
    XZ_X = reshape(squeeze(X(ny,:,:)),XZN,1);
    XZ_Y = reshape(squeeze(Y(ny,:,:)),XZN,1);
    XZ_Z = reshape(squeeze(Z(ny,:,:)),XZN,1);
    % BFIELD VECTORS
    XZ_BX = reshape(squeeze(BX(ny,:,:)),XZN,1);
    XZ_BY = reshape(squeeze(BY(ny,:,:)),XZN,1);
    XZ_BZ = reshape(squeeze(BZ(ny,:,:)),XZN,1);
    % convert the values into cell array
    XZBF  = num2cell([XZ_X,XZ_Y,XZ_Z, XZ_BX,XZ_BY,XZ_BZ]);
    % combine cell arrays into one
    BF    = [BFC;XZBF];
    % print/write the cell onto a csv file named, BFIELDS_XZ
    writecell(BF,'BFIELDS_XZ.csv');
    
    %toc;
    %process = 'end export BF_XZ'
% ------------------- WRITE: BFIELDS (YZ-PLANE) ------------------------- %
    %process = 'end export BF_YZ'
    
    YZN  = Ny*Nz;   
    BFC   = {'x[m]','y[m]','z[m]','BX','BY','BZ'};
    % Obtain the desirable YZ cut-plane
    % reshape --> X,Y,Z,BX,BY,BZ's dim size is (Ny by Nx by Nz), therefore 
    %each needs to become 1D array (size: Ny*Nx*Nz by 1)
    % SPATIAL LOCATION OF BFIELDS  
    YZ_X = reshape(squeeze(X(:,nx,:)),YZN,1);
    YZ_Y = reshape(squeeze(Y(:,nx,:)),YZN,1);
    YZ_Z = reshape(squeeze(Z(:,nx,:)),YZN,1);
    % BFIELD VECTORS
    YZ_BX = reshape(squeeze(BX(:,nx,:)),YZN,1);
    YZ_BY = reshape(squeeze(BY(:,nx,:)),YZN,1);
    YZ_BZ = reshape(squeeze(BZ(:,nx,:)),YZN,1);
    % convert the values into cell array
    YZBF  = num2cell([YZ_X,YZ_Y,YZ_Z, YZ_BX,YZ_BY,YZ_BZ]);
    % combine cell arrays into one
    BF    = [BFC;YZBF];
    % print/write the cell onto a csv file named, BFIELDS_YZ
    writecell(BF,'BFIELDS_YZ.csv');
    
    %process = 'end export BF_YZ'
end



