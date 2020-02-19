% Alexander Moreno
% 12-17-2019
%
% Exports the spatial location(in cartesian coordinate) and B-Fields 
% (Bx,By,Bz). The spatial location was specified by user in the GUI when 
% choosing the resolution in x, y, and z directions.  
%
% [[Input Parameters]]
% dx 
% Description: spatial segments(steps) along the x-direction
% Units: [] <3D matrix>
%
% dy:
% Description: spatial segments(steps) along the y-direction 
% Units: [] <3D matrix>
%
% dz:
% Description: spatial segments(steps) along the z-direction
% Units: [] <3D matrix>
%
% BX:
% Description: x-component of the calculated B-fields
% Units: <3D matrix>
%
% BY:
% Description: y-component of the calculated B-fields
% Units: <3D matrix>
%
% BZ:
% Description: z-component of the calculated B-fields
% Units: <3D matrix>
%
% Nx:
% Description: resolution along the x-direction. will aid reshaping dx into 
% a 1-D array  
% Units: [unitless] <scalar>
%
% Ny:
% Description: resolution along the y-direction. will aid reshaping dy into 
% a 1-D array 
% Units: [unitless] <scalar>
%
% Nz:
% Description: resolution along the z-direction. will aid reshaping dz into 
% a 1-D array 
% Units: [unitless] <scalar>
%
% fileName:
% Description: file name of the csv via user input 
% Units: [unitless] <scalar>
%
% =========================================================================
% =========================================================================
% =========================================================================
% [[Output Parameters]]
% csv file of the input parameter data
%

function []=exportAntData(dx,dy,dz,bx,by,bz,Nx,Ny,Nz,fileName)
    DX = reshape(dx,[Nx*Ny*Nz,1]);
    DY = reshape(dy,[Nx*Ny*Nz,1]);
    DZ = reshape(dz,[Nx*Ny*Nz,1]);
    BX = reshape(bx,[Nx*Ny*Nz,1]);
    BY = reshape(by,[Nx*Ny*Nz,1]);
    BZ = reshape(bz,[Nx*Ny*Nz,1]);
    
    dataM = [DX,DY,DZ,BX,BY,BZ];
    T = array2table(dataM);
    T.Properties.VariableNames(1,1:6) = {'x','y','z','Bx','By','Bz'};
    writetable(T,fileName)
end