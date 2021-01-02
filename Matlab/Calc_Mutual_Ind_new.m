% <DELETE THIS FILE>
% Alexander Moreno
% DATE: 12-12-2020
%
%------------------------------[DESCRIPTION]------------------------------%
% Computes the mutual indtuance between solenoid with a  
% ferromagnetic core and B-Fields. 
%--------------------------[END: DESCRIPTION]-----------------------------%

%=========================================================================%
%=========================================================================%

%---------------------------[INPUT PARAMETERS]----------------------------%
%   I0
%   Description: Current through the wire 
%   Units: [A] <scalar>
%---------------------------------[B0]------------------------------------%
%   BX
%   Description: x-directed B-Fields 
%   Units: [T]
%   DIM: [Ny by Nx by Nz]
%   
%   BY
%   Description: y-directed B-Fields 
%   Units: [T]
%   DIM: [Ny by Nx by Nz]
%     
%   BZ
%   Description: z-directed B-Fields 
%   Units: [T]
%   DIM: [Ny by Nx by Nz]
%     
%   X
%   Description: spatial points of the B-Fields along the x-coordinates 
%   Units: [m]
%   DIM: [Ny by Nx by Nz]
%
%   Y
%   Description: spatial points of the B-Fields along the y-coordinates 
%   Units: [m]
%   DIM: [Ny by Nx by Nz]     
%
%   Z
%   Description: spatial points of the B-Fields along the z-coordinates 
%   Units: [m]
%   DIM: [Ny by Nx by Nz]
%   
%---------------------------------[tag]-----------------------------------%
%   N
%   Description: Number of turns for the solenoid 
%   UNITS: N/A <scalar>
%   
%   L 
%   Description: Length of the solenoid
%   UNITS: [m] <scalar>
% 
%   r
%   Description: radius of the solenoid
%   UNITS: [m] <scalar>
% 
%   ur
%   Description: dieletric constant of the ferromagnetic core
%   UNITS:  <scalar>
% 
%   az 
%   Description: solenoid positon in the azimuthal (phi-direction)
%   UNITS: [deg]  <scalar>
%
%   el 
%   Description: solenoid positon in the elevation (theta-direction)
%   UNITS: [deg] <scalar>
%
%   xpos
%   Description: solenoid positon in the x-direction
%   UNITS: [m] <scalar>
%
%   ypos
%   Description: solenoid positon in the y-direction
%   UNITS: [m] <scalar>
%
%   zpos
%   Description: solenoid positon in the z-direction
%   UNITS: [m] <scalar>
%
%-------------------------[END: INPUT PARAMETERS]-------------------------%

%=========================================================================%
%=========================================================================%


%---------------------------[OUTPUT PARAMETERS]---------------------------%
% M12
% DESCRIPTION: Mutual indutance between multi-coiled wire and solenoid with
% a ferromagnetic core. 
% UNITS: <N by N matrix>
%-------------------------[END: OUTPUT PARAMETERS]------------------------%

%=========================================================================%
%=========================================================================%

%function [M12] = Calc_Mutual_Ind_new(BX,BY,BZ,X,Y,Nxy,N,I,tag)
function [M12] = Calc_Mutual_Ind_new(B0,tag,I)
%tag = struct('r',r,'l',l,'N',N,'AZ',AZ,'EL',EL,'Z',Z,...
%             'xpos',xpos,'ypos',ypos);
%tag = struct('r',r,'l',l,'N',N,'AZ',AZ,'EL',EL,'Z',Z,...
%             'xpos',xpos,'ypos',ypos);

%-----------------------initialize variables------------------------------%
    mu0  = 4*pi*1e-7;   % free space permeability <scalar> [H/m]
    %BX   = B0.BX;       % x-directed b-fields from loop 1
    %BY   = B0.BY;       % y-directed b-fields from loop 1
    BZ   = B0.BZ;       % z-directed b-fields from loop 1
    X    = B0.X;        % b-fields' spatial location (x-direction)(loop 1)
    Y    = B0.Y;        % b-fields' spatial location (y-direction)(loop 1) 
    Z    = B0.Z;        % b-fields' spatial location (z-direction)(loop 1)
    Nxy1 = Nxy;         % Number turns from loop 1
    N1   = N;           % Number of coils from loop 1
    xdel  = abs(X(1,1) - X(1,2));   % del x from loop 1
    ydel  = abs(Y(1,1) - Y(2,1));   % del y from loop 1
    A     = xdel*ydel;              % Area (ds) from loop 1  
    % orientation of tag
    [ox,oy,oz] = pol2cart(tag.AZ,tag.EL,tag.Z);
    tagO = [ox,oy,oz];
%-------------------locate bfields within location of tag-----------------%
    % E is matrix compose of 0s and 1s. The 1s indicate the tag's location
    % and 0s indicated tag's is not located. 
    E = ( ((X+tag.xpos)./tag.rx)^.2 + ((Y+tag.ypos)./tag.ry)^.2 ) <=1;
    [idx] = find(E);    % finds the indices of tag's spatial location
    % Find b-fields related to tag's spatial location
    %BFx = BX(idx)';
    %BFy = BY(idx)'; 
    BFz = BZ(idx)';
%-------------------------compute mutual inductance-----------------------% 
    %bx = BFx.*A;
    %by = BFy.*A;
    bz = BFz.*A;
    %sumBx = sum(sum(sum(bx,1),2),3);   % sum of Bx
    %sumBy = sum(sum(sum(by,1),2),3);   % sum of By
    sumBz = sum(sum(sum(bz,1),2),3);   % sum of Bz
    %sumB  = [sumBx,sumBy,sumBz];
    sumB = [0,0,sumBz];
    phi12 = dot(sumB,tag0);
    M12   = abs((phi12/I)*N1*Nxy1*tag.N*tag.Nxy*tag.ur);
end
