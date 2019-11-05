clear all; close all; clc;

W0=0.3; L0=0.3; phi=2; N=1; O=1; wT=0.1; h=(1.1)*(2*wT*N); Nz=1;    

    deltaS = 200;
    helixSTEP = phi*(pi/180);
    start=0; fin = N*(2*pi) + helixSTEP/2;
    cst_xxx = start:helixSTEP:fin;
    cstSize = floor((numel(cst_xxx)/4)/N);
    hSize   = floor(cstSize/2);

    %x  = linspace(-W0/2,W0/2,cstSize)';  
    xn = linspace(-W0/2,0,hSize)'; xn(end)=[];
    xp = linspace(0,W0/2,hSize)';
    xc = (W0/2)*ones(1,2*hSize-1)'; 
   
    % y   = linspace(-L0/2,L0/2,cstSize)';  
    yn  = linspace(-L0/2,0,hSize)'; yn(end)=[];
    yp  = linspace(0,L0/2,hSize)';
    yc  = (L0/2)*ones(1,2*hSize-1)';
    yic = (L0/2)*ones(1,hSize)';
    
    nx=1;
    t2  = (wT/2)*nx;
    t4  = (wT/4)*nx;
    
    xS=[]; yS=[]; zS=[];
    %if(O==1) %clock wise
    hold all;
        %
        x0 = [-xc;  xn;xp; xc; flipud(xp);flipud(xn);];
        y0 = [yn;yp;   yc; flipud(yp); flipud(yn); -yc];  
        xS0 = repmat(x0,N,1);   xS0(end-hSize:end)=[]; 
        yS0 = repmat(y0,N,1);   yS0(end-hSize:end)=[];
        xS0 = [flipud(xn);xS0]; yS0 = [-yc(1:numel(xn));yS0]; 
        zSize = numel(xS0);
        zp = linspace(start,fin, zSize)';
        zS0 = (h*zp)./(2*pi*N);   

        xS=[xS;xS0]; yS=[yS;yS0]; zS=[zS;zS0]; 
        plot3(xS,yS,zS,'r-','LineWidth',3);
        %}
        %
        % +z
        x0 = [-xc;  xn;xp; xc; flipud(xp);flipud(xn);];
        y0 = [yn;yp;   yc; flipud(yp); flipud(yn); -yc];  
        xS0 = repmat(x0,N,1);   xS0(end-hSize:end)=[]; 
        yS0 = repmat(y0,N,1);   yS0(end-hSize:end)=[];
        xS0 = [flipud(xn);xS0]; yS0 = [-yc(1:numel(xn));yS0]; 
        zSize = numel(xS0);
        zp = linspace(start,fin, zSize)';
        zS0 = (h*zp)./(2*pi*N);  
        
        xS1=[xS;xS0]; yS1=[yS;yS0]; zS1=[zS;zS0];
        zS1 = zS1+t2;
        plot3(xS1,yS1,zS1,'bo');
        
        % -z
        x0 = [-xc;  xn;xp; xc; flipud(xp);flipud(xn);];
        y0 = [yn;yp;   yc; flipud(yp); flipud(yn); -yc];    
        xS0 = repmat(x0,N,1);   xS0(end-hSize:end)=[]; 
        yS0 = repmat(y0,N,1);   yS0(end-hSize:end)=[];
        xS0 = [flipud(xn);xS0]; yS0 = [-yc(1:numel(xn));yS0]; 
        zSize = numel(xS0);
        zp = linspace(start,fin, zSize)';
        zS0 = (h*zp)./(2*pi*N);
        xS2=[xS;xS0]; yS2=[yS;yS0]; zS2=[zS;zS0];  
        zS2 = zS2-t2;
        plot3(xS2,yS2,zS2,'g-');
        %}
        %
        % +xy  
        xn = linspace(-(W0/2) -t2,0,hSize)'; xn(end)=[];
        xp = linspace(0,(W0/2)+t2,hSize)';
        xc = ((W0/2)+t2)*ones(1,2*hSize-1)'; 
        
        yn  = linspace(-(L0/2)-t2,0,hSize)'; yn(end)=[];
        yp  = linspace(0,(L0/2)+t2,hSize)';
        yc  = ((L0/2) + t2)*ones(1,2*hSize-1)';
        yic = ((L0/2) + t2)*ones(1,hSize)';
        
        x0 = [-xc;  xn;xp; xc; flipud(xp);flipud(xn);];
        y0 = [yn;yp;   yc; flipud(yp); flipud(yn); -yc];    
        xS0 = repmat(x0,N,1);   xS0(end-hSize:end)=[]; 
        yS0 = repmat(y0,N,1);   yS0(end-hSize:end)=[];
        xS0 = [flipud(xn);xS0]; yS0 = [-yc(1:numel(xn));yS0]; 
        zSize = numel(xS0);
        zp = linspace(start,fin, zSize)';
        zS0 = (h*zp)./(2*pi*N);
        xS3=[xS;xS0]; yS3=[yS;yS0]; zS3=[zS;zS0];  
        
        plot3(xS3,yS3,zS3,'b--');

        % -xy  
        xn = linspace(-(W0/2) +t2,0,hSize)'; xn(end)=[];
        xp = linspace(0,(W0/2)-t2,hSize)';
        xc = ((W0/2)-t2)*ones(1,2*hSize-1)'; 
        
        yn  = linspace(-(L0/2)+t2,0,hSize)'; yn(end)=[];
        yp  = linspace(0,(L0/2)-t2,hSize)';
        yc  = ((L0/2) - t2)*ones(1,2*hSize-1)';
        yic = ((L0/2) - t2)*ones(1,hSize)';
        
        x0 = [-xc;  xn;xp; xc; flipud(xp);flipud(xn);];
        y0 = [yn;yp;   yc; flipud(yp); flipud(yn); -yc];    
        xS0 = repmat(x0,N,1);   xS0(end-hSize:end)=[]; 
        yS0 = repmat(y0,N,1);   yS0(end-hSize:end)=[];
        xS0 = [flipud(xn);xS0]; yS0 = [-yc(1:numel(xn));yS0]; 
        zSize = numel(xS0);
        zp = linspace(start,fin, zSize)';
        zS0 = (h*zp)./(2*pi*N);
        xS3=[xS;xS0]; yS3=[yS;yS0]; zS3=[zS;zS0];  
        
        plot3(xS3,yS3,zS3,'mo');
        
        xS=[xS;xS0]; yS=[yS;yS0]; zS=[zS;zS0];  
        
        
    %else %counter clock wise

   % end     
    %
    S0 = [xS0;yS0;zS0+wT/2];
    %xS = S0(:,1); yS = S0(:,2); zS = S0(:,3);
    
%% 

%H=plot3(xS(1:172),yS(1:172),zS(1:172),xS(173:172*2),yS(173:172*2),zS(173:172*2));
H=plot3(xS(1:172),yS(1:172),zS(1:172),xS(173:172*2),yS(173:172*2),zS(173:172*2),xS(172*+1:172*3),yS(172*+1:172*3),zS(172*+1:172*3));
set(H(1),'color','r');  set(H(1),'LineWidth',3);  set(H(1),'LineStyle','--'); 
set(H(2),'color','b');  set(H(2),'LineWidth',3);  set(H(2),'Marker','o'); 
set(H(3),'color','g');  set(H(3),'LineWidth',0.25);  set(H(3),'Marker','o'); 

xlabel('x'); ylabel('y'); zlabel('z'); 
view(0,90)
