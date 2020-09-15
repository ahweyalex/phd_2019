clear all; 
close all; 
clc;
%-------------------------------------------------------------------------%
wT = 0.2546e-3;  % 30AWG 
ri = 10e-3;
ra = 10e-3;
G  = 'r';
N  = 3;
global I0; I0 = struct('I',1);
h       = wT*0.35;  
zEnd    = h*N*2*pi;
W0      = ra;       
L0      = ri;  
%O      = 1;
O       = 0;
Nxy     = 1;

numSeg = 100;
phi = numSeg;
%phi = ns;
%%[Sx,Sy,Sz] = singleLoop(ra,ri,phi,O,wT);
[Sx,Sy,Sz] = singleRectLoop(W0,L0,numSeg,wT,O);
%[Sx,Sy,Sz] = constrCircWire(zEnd,ra,ri,phi,N,O,wT,Nxy);
plot3(Sx,Sy,Sz);
%-------------------------------------------------------------------------%
%BSN = 5;
%for bs=1:BSN
    if (ri>=ra)
        xyz = ri/2;
    %xyz = bs*ri;
    elseif (ra>=ri)
        xyz = ra/2;
    %xyz = bs*ra;
    end
    xminb = -xyz; 
    xmaxb =  xyz;
    yminb = -xyz; 
    ymaxb =  xyz;
    %zminb = 0;
    %zmaxb = 0; 
    zminb = 0;
    zmaxb = 0; 
    bBox  = [xminb,yminb,zminb; xmaxb,ymaxb,zmaxb];

    % iterate though Nx and Ny
    ind = 1;
    %NXY = 400; 
    % segN 320,319,318 
    segN = 220:225;
    nn = 1;
    for ns=20:400
        Nx = ns; Ny = ns; 
        %Ny = 100; 
        Nz = 1;
        Ns = [Nx,Ny,Nz];
        [bX,bY,bZ,BX,BY,BZ,normB,R,dBx,dBy,dBz] =... 
            CalcB_FAST(I0.I,Sx,Sy,Sz,bBox,Ns);    
        %[bX,bY,bZ,BX,BY,BZ,normB,R0] = CalcB_SLOW(I0.I,Sx,Sy,Sz,bBox,Ns);
        
        B0 = struct('BX',BX,'BY',BY,'BZ',BZ,'X',bX,'Y',bY,'Z',bZ);
        bXc{nn} = bX;
        bYc{nn} = bY;
        bZc{nn} = bZ;
        BXc{nn} = BX;
        BYc{nn} = BY;
        BZc{nn} = BZ;
        Rc{nn}  = R;
        dBx_c{nn} = dBx;
        dBy_c{nn} = dBy;
        dBz_c{nn} = dBz;
        
        nz    = 1;
        X     = squeeze(B0.X(:,:,nz));
        Y     = squeeze(B0.Y(:,:,nz));
        Z     = squeeze(B0.Z(:,:,nz));
        BX    = squeeze(B0.BX(:,:,nz));
        BY    = squeeze(B0.BY(:,:,nz));
        BZ    = squeeze(B0.BZ(:,:,nz));    

        [Matlab_L11(nn)] = ...
            selfInductance_BFields(ri,ra,I0.I,X,Y,BZ,N,G);
        nn = nn+1;
        
%         % start of new
%         x1    = ri/10 - abs(X(1,1)-X(1,2)); 
%         x2    = ri/10 + abs(X(1,1)-X(1,2));
%         y1    = ri/10 - abs(Y(1,1)-Y(2,1));
%         y2    = ri/10 + abs(Y(1,1)-Y(2,1));
%         BF_O  = (X>=x1 & X<=x2 & Y>=y1 & Y<=y2);
%         [r,c] = find(BF_O);
%         for ni=1:numel(r)
%             BX_O{nn,ni} = BX(r,c);
%             BY_O{nn,ni} = BY(r,c);
%             BZ_O{nn,ni} = BZ(r,c);
%             X_O{nn,ni}  = X(r,c);
%             Y_O{nn,ni}  = Y(r,c);
%         end
%         % end of new  
        
        %if(mod(ns,100)==0)
        %    disp(ns)
        %end
        %X=[]; Y=[]; Z=[]; BX=[]; BY=[]; BZ=[];
    end
    disp('DONE')
%end
