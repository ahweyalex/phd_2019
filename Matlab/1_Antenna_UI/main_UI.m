% Alexander Moreno
% 12-19-2019
%
% Description: 
% The main function that runs the math/physics code to compute the B-Fields
% via user input. 
%
% =========================================================================
% =========================================================================
% Input Parameters:
%
% [[Units]]
% Description: Contains the units for the Antenna Dimnesions to construct 
% (i.e. elliptical/circular, rectangular, or custom. The information is 
%  being pulled from the droplist menu from the GUI.
% TYPE:[array of strings],<structure array>
% Units.h     : [m,cm,mm,in]
% Units.W     : [m,cm,mm,in]
% Units.L     : [m,cm,mm,in]
% Units.wT    : [AWG,m,cm,mm,in]
% Units.phi   : [deg,rad]
% Units.dimx  : [m,cm,mm,in]
% Units.dimy  : [m,cm,mm,in]
% Units.dimz  : [m,cm,mm,in]
% Units.dimI  : [A,mA,uA,nA]
% Units.dimBF : [FAST, SLOW]
% 
% [[AntDim]]
% Description: Contains the dimensions for the elliptical/circular or
% rectangular wire antenna. The information is obtained via the GUI. 
% TYPE: [array of doubles,strings],<structure array>
% AntDim.h   : 
% AntDim.W   :
% AntDim.L   :
% AntDim.wT  :
% AntDim.N   :
% AntDim.O   :
% AntDim.Nxy :
% AntDim.phi :
% AntDim.ra  :
% AntDim.ri  :
% AntDim.v   : ['e','r','k']
% AntDim.BF
%
% [[Bdim]]
% Description: Contains the max, min, and resolution of space that the user 
% wants to compute the B-Fields for the structure. Contains the current
% that the user is using.
% TYPE: [array of doubles,strings],<structure array>
% Bdim.Nx
% Bdim.Ny
% Bdim.Nz
% Bdim.xmin
% Bdim.ymin
% Bdim.zmin
% Bdim.xmax
% Bdim.ymax
% Bdim.zmax
% Bdim.I
% Bdim.v
%
% =========================================================================
% =========================================================================
% Output Parameters:
% [[S]]
% Description:
% TYPE: <structure array>
% S.x
% S.y
% S.z 
%
% [[B]]
% Description:
% TYPE: <structure array>
% B.BX
% B.BY
% B.BZ
% B.X
% B.Y
% B.Z
%
% removed for now
% [[IN]]
% Description: Input impedance of the antenna wire structure
% TYPE: <structure array>
% IN.r (resistance/real impedance)
% IN.i (imaginary impedance)
% IN.type
%
% =========================================================================
% =========================================================================

function [A,B,M,RR] =  main_UI(Units,AntDim,Bdim,Tag)
%% Conversion
%  Description:
%  Checks the user's input droplist. The units will convert into meters.
% Units.h     : [m,cm,mm,in]
% Units.W     : [m,cm,mm,in] % Units.ra
% Units.L     : [m,cm,mm,in] % Units.ri
% Units.wT    : [AWG,m,cm,mm,in]
% Units.phi   : [deg,rad]
% Units.I     : [A,mA,uA,nA]
% Units.dimBF : [m,cm,mm,in]

% conversion height (h)
switch Units.h
    case 'm'
        AntDim.h;
    case 'cm'
        AntDim.h = AntDim.h*1e-2;   % converting 'cm' into 'm'
    case 'mm'
        AntDim.h = AntDim.h*1e-3;   % converting 'mm' into 'm'
    case 'in'
        AntDim.h = AntDim.h*0.0254; % converting 'in' into 'm'
    case 'mil'
        AntDim.h = AntDim.h*2.54e-5;% converting 'mil' into 'm' 
end
% conversion for width(W)/(ra)
switch Units.W
    case 'm'
        AntDim.W;
        AntDim.ra;
    case 'cm'
        % converting 'cm' into 'm'
        AntDim.W = AntDim.W*1e-2; 
        AntDim.ra = AntDim.ra*1e-2; 
    case 'mm'
        % converting 'mm' into 'm'
        AntDim.W = AntDim.W*1e-3;
        AntDim.ra = AntDim.ra*1e-3;
    case 'in'
        % converting 'in' into 'm'
        AntDim.W = AntDim.W*0.0254;
        AntDim.ra = AntDim.ra*0.0254;
end
% conversion for length(L)/ri
switch Units.L
    case 'm'
        AntDim.L;
        AntDim.ri;
    case 'cm'
        % converting 'cm' into 'm'
        AntDim.L = AntDim.L*1e-2; 
        AntDim.ri = AntDim.ri*1e-2; 
    case 'mm'
        % converting 'mm' into 'm'
        AntDim.L = AntDim.L*1e-3;
        AntDim.ri = AntDim.ri*1e-3;
    case 'in'
        % converting 'in' into 'm'
        AntDim.L = AntDim.L*0.0254;
        AntDim.ri = AntDim.ri*0.0254;
end
% conversion for width thickness (wT) of wire 
switch Units.wT
    case 'm'
        AntDim.wT;
    case 'cm'
        AntDim.wT = AntDim.wT*1e-2;   % converting 'cm' into 'm'
    case 'mm'
        AntDim.wT = AntDim.wT*1e-3;   % converting 'mm' into 'm'
    case 'in'
        AntDim.wT = AntDim.wT*0.0254; % converting 'in' into 'm'
    case 'AWG'
        % converting 'AWG' into 'm'
        AntDim.wT = (0.127e-3)*92^((36-AntDim.wT)/39); 
end
% conversion for angle phi of wire 
switch Units.phi
    case 'deg'
        AntDim.phi;
    case 'rad'
        % convert 'deg' into 'rad'
        AntDim.phi = AntDim.phi*(180/pi);
end
% conversion for current (I)
switch Units.dimI
    case 'A'
        AntDim.I;
    case 'mA'
        AntDim.I = AntDim.I*1e-3; 
    case 'uA'
        AntDim.I = AntDim.I*1e-6;
    case 'nA'
        AntDim.I = AntDim.I*1e-9;
end
% conversion for x-dim (B-Fields calc)
switch Units.dimx
    case 'm'
        Bdim.xmin;
        Bdim.xmax;
    case 'cm' % converting 'cm' to 'm'
        Bdim.xmin = Bdim.xmin*1e-2;
        Bdim.xmax = Bdim.xmax*1e-2;
    case 'mm' % converting 'mm' to 'm'
        Bdim.xmin = Bdim.xmin*1e-3;
        Bdim.xmax = Bdim.xmax*1e-3;
    case 'in' % converting 'in' to 'm' 
        Bdim.xmin = Bdim.xmin*0.0254;
        Bdim.xmax = Bdim.xmax*0.0254;
end
% conversion for y-dim (B-Fields calc)
switch Units.dimy
    case 'm'
        Bdim.ymin;
        Bdim.ymax;
    case 'cm' % converting 'cm' to 'm'
        Bdim.ymin = Bdim.ymin*1e-2;
        Bdim.ymax = Bdim.ymax*1e-2;
    case 'mm' % converting 'mm' to 'm'
        Bdim.ymin = Bdim.ymin*1e-3;
        Bdim.ymax = Bdim.ymax*1e-3;
    case 'in' % converting 'in' to 'm' 
        Bdim.ymin = Bdim.ymin*0.0254;
        Bdim.ymax = Bdim.ymax*0.0254;
end
% conversion for z-dim (B-Fields calc)
switch Units.dimz
    case 'm'
        Bdim.zmin;
        Bdim.zmax;
    case 'cm' % converting 'cm' to 'm'
        Bdim.zmin = Bdim.zmin*1e-2;
        Bdim.zmax = Bdim.zmax*1e-2;
    case 'mm' % converting 'mm' to 'm'
        Bdim.zmin = Bdim.zmin*1e-3;
        Bdim.zmax = Bdim.zmax*1e-3;
    case 'in' % converting 'in' to 'm' 
        Bdim.zmin = Bdim.zmin*0.0254;
        Bdim.zmax = Bdim.zmax*0.0254;
end
% conversion for  tag (solenoid)'s radius
switch Units.tagR
    case 'm'
        Tag.r;
    case 'cm' % converting 'cm' to 'm'
        Tag.r = Tag.r*1e-2;
    case 'mm' % converting 'mm' to 'm'
        Tag.r = Tag.r*1e-3;
    case 'in' % converting 'in' to 'm' 
        Tag.r = Tag.r*0.0254;
end
% conversion for tag (solenoid)'s length(height)
switch Units.tagL
    case 'm'
        Tag.L;
    case 'cm' % converting 'cm' to 'm'
        Tag.L = Tag.r*1e-2;
    case 'mm' % converting 'mm' to 'm'
        Tag.L = Tag.r*1e-3;
    case 'in' % converting 'in' to 'm' 
        Tag.L = Tag.r*0.0254;
end
% conversion for tag (solenoid)'s az
switch Tag.AZ
    % convert deg into rad
    case 'deg'
        Tag.AZ = Tag.AZ(180/pi);
    case 'rad'
        % convert 'deg' into 'rad'
        Tag.AZ = Tag.AZ;
end
% conversion for tag (solenoid)'s el
switch Tag.EL
    % convert deg into rad
    case 'deg'
        Tag.EL = Tag.EL(180/pi);
    case 'rad'
        % convert 'deg' into 'rad'
        Tag.EL = Tag.EL;
end
%% Initialize variables 
bBox = [Bdim.xmin,Bdim.ymin,Bdim.zmin;Bdim.xmax,Bdim.ymax,Bdim.zmax];
Ns   = [Bdim.Nx;Bdim.Ny;Bdim.Nz];
% END: Conversion 

%% Construction
%  Description:
%  Constructs:
%  1) multi-coiled elliptical/circular wire antenna from GUI parameters
%  2) multi-coiled rectangular wire antenna from GUI parameters
%  3) import (user custom) x,y,z points of user's wire antenna 
%  Returns 1D arrays
    % AntDim.v
    if(AntDim.v == 2) % elliptical/circular 
        [Sx,Sy,Sz] = constrCircWire(AntDim.h,AntDim.ra,AntDim.ri,...
        AntDim.phi,AntDim.N,AntDim.O,AntDim.wT,AntDim.Nxy);
    elseif(AntDim.v == 1) % rectangularW
        [Sx,Sy,Sz] = constrRectWire(AntDim.h,AntDim.W,AntDim.L,...
            AntDim.phi,AntDim.N,AntDim.O,AntDim.wT,AntDim.Nxy);
    else(AntDim.v == 3) % custom
        % custom stuff
    end
    A = struct('X',Sx,'Y',Sy,'Z',Sz);
   % test = t;
% END: Construction
%% Calculate B-Fields
%  Description: Calculate B-Fields based on the space defined by the user 
%  in the GUI. 
    if(Bdim.v=='F')
        [bX,bY,bZ, BX,BY,BZ, normB,R] = ...
            CalcB_FAST(AntDim.I,Sx,Sy,Sz,bBox,Ns);
    elseif(Bdim.v=='S')
        [bX,bY,bZ, BX,BY,BZ, normB,R] = ...
            CalcB_SLOW(AntDim.I,Sx,Sy,Sz,bBox,Ns);
    end
    B = struct('BX',BX,'BY',BY,'BZ',BZ,'X',bX,'Y',bY,'Z',bZ);
% END: Calculate B-Fields
%% Mutual Inductance
%  Description:
    [M] = Calc_Mutual_Ind(B,AntDim,Tag);
%% Read-Range
%  Description:
    f = 125e3;
    [tagV,tagRes,tag_selfL] = induced_tagV(M,AntDim,f,Tag);
    RR = struct('ReadRange',tagV,'X',bX,'Y',bY,'Z',bZ);
end