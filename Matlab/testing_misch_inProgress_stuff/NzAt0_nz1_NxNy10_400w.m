clear all; 
close all; 
clc;
%-------------------------------------------------------------------------%
wT = 0.2546e-3;  % 30AWG 
ri = 10e-3;
ra = 10e-3;
%G  = 'r';
G = 'c';
N  = 1;
global I0; I0 = struct('I',1);
h       = wT*0.35;  
zEnd    = h*N*2*pi;
W0      = ra;       
L0      = ri;  
%O      = 1;
O       = 0;
Nxy     = 1;

NS = 300;
nm = 1;
for nums=200:7:NS
    % numSeg = 16; % rect
    %numSeg = 200; % circ
    numSeg = nums;
    phi = numSeg;
    %phi = ns;
    %%[Sx,Sy,Sz] = singleLoop(ra,ri,phi,O,wT);
    %[Sx,Sy,Sz] = singleRectLoop(ra,ri,numSeg,wT,O);
    [Sx,Sy,Sz] = singleEllipticalLoop(ra,ri,numSeg,wT,O);
    %[Sx,Sy,Sz] = constrCircWire(zEnd,ra,ri,phi,N,O,wT,Nxy);
    H=plot3(Sx,Sy,Sz);
    xlabel('x'); ylabel('y'); zlabel('z');
    grid on;
    view(90,90)
    %%
    %-------------------------------------------------------------------------%
    %BSN = 5;

    if (ri>=ra)
        xyz = ri;
    %xyz = bs*ri;
    elseif (ra>=ri)
        xyz = ra;
    %xyz = bs*ra;
    end
    xminb = -xyz; 
    xmaxb =  xyz;
    yminb = -xyz; 
    ymaxb =  xyz;
    
%     xminb = 0; 
%     xmaxb = 0;
%     yminb = 0; 
%     ymaxb = 0;
%    
    zminb = 0;
    zmaxb = 0; 
    %zminb = 0;
    %zmaxb = wT*.1; 
    bBox  = [xminb,yminb,zminb; xmaxb,ymaxb,zmaxb];

    % iterate though Nx and Ny
    ind = 1;
    %NXY = 400; 
    % segN 320,319,318 
    NN  = 219:224;
    nn = 1;
%    for ns=19:220
    for ns = 219:224
        Nx = ns; Ny = ns; 
        %Ny = 100; 
        Nz = 1;
        Ns = [Nx,Ny,Nz];
        [bX,bY,bZ,BX,BY,BZ,normB,R,dBx,dBy,dBz] =... 
            CalcB_FAST(I0.I,Sx,Sy,Sz,bBox,Ns);    
        %[bX,bY,bZ,BX,BY,BZ,normB,R0] = CalcB_SLOW(I0.I,Sx,Sy,Sz,bBox,Ns);
        
        B0 = struct('BX',BX,'BY',BY,'BZ',BZ,'X',bX,'Y',bY,'Z',bZ);
        %{
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
        %}
        nz    = 1;
        X     = squeeze(B0.X(:,:,nz));
        Y     = squeeze(B0.Y(:,:,nz));
        Z     = squeeze(B0.Z(:,:,nz));
        BX    = squeeze(B0.BX(:,:,nz));
        BY    = squeeze(B0.BY(:,:,nz));
        BZ    = squeeze(B0.BZ(:,:,nz));    

        [Matlab_L11(nn, nm)] = ...
            selfInductance_BFields(ri,ra,I0.I,X,Y,BZ,N,G);
        nn = nn+1;
        indx(nn, nm) = ceil(Nx/2);
        B__Z(nn, nm)= B0.BZ(ceil(Nx/2),ceil(Nx/2));
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
    disp(strcat("in-loop:",num2str(ns),"/",num2str(224)));
    end
    disp(strcat("overall:",num2str(nm),"/",num2str(NS)));
    nm = nm + 1;
end
%%   
% plots
fs = 12; 

figure(1)
H=plot(NN,Matlab_L11(:)/1e-9,'.-');
xlabel('Resolution X/Y','FontWeight','bold','FontSize', fs);  
ylabel('L11[nH]','FontWeight','bold','FontSize', fs);
title('ALEX Matlab Model','FontWeight','bold','FontSize', fs);

figure(2)
H=plot(NN(2:end),B__Z(2:numel(NN))/1e-9,'.-');
xlabel('Resolution X/Y','FontWeight','bold','FontSize', fs);  
ylabel('BZ','FontWeight','bold','FontSize', fs);
title('ALEX Matlab Model @approx(0,0,0)','FontWeight','bold','FontSize', fs);

disp('DONE')
%%
fs= 12;
NS = 300;
NN = 200:7:300;
%%
figure(3)
H=plot(NN,Matlab_L11(1,:)/1e-9,'.-',...
    NN,Matlab_L11(2,:)/1e-9,...
    NN,Matlab_L11(3,:)/1e-9,...
    NN,Matlab_L11(4,:)/1e-9,...
    NN,Matlab_L11(5,:)/1e-9,...
    NN,Matlab_L11(6,:)/1e-9);
set(H(1),'color','r'); set(H(2),'color','b'); set(H(3),'color','g');
set(H(4),'color','c'); set(H(5),'color','k'); set(H(6),'color','y');
xlabel('Resolution X/Y','FontWeight','bold','FontSize', fs);  
ylabel('L11[nH]','FontWeight','bold','FontSize', fs);
title('ALEX Matlab Model','FontWeight','bold','FontSize', fs);
%%
figure(4)
H=plot(B__Z(1,:)/1e-5,'.-');
xlabel('Resolution X/Y','FontWeight','bold','FontSize', fs);  
ylabel('BZ','FontWeight','bold','FontSize', fs);
title('ALEX Matlab Model @approx(0,0,0)','FontWeight','bold','FontSize', fs);
%}
%end
