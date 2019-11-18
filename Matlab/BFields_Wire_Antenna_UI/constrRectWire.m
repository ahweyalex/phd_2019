function [xS,yS,zS] = constrRectWire(h,W0,L0,phi,N,O,wT,Nxy)
    deltaS = 200;
    helixSTEP = phi*(pi/180);
    start=0; fin = N*(2*pi) + helixSTEP/2;
    cst_xxx = start:helixSTEP:fin;
    cstSize = floor((numel(cst_xxx)/4)/N);
    hSize   = floor(cstSize/2);
    xS=[]; yS=[]; zS=[];
    
    if(O==1) %clock wise
        for nx=1:Nxy
            txy =(wT/2); 
            t0 = (3/2)*(wT)*(nx-1);
            % +z
            xn = linspace((-W0/2)-(t0),0,hSize)'; xn(end)=[];
            xp = linspace(0,(W0/2)+(t0),hSize)';
            xc = ((W0/2)+(t0))*ones(1,2*hSize-1)';    
            % y   = linspace(-L0/2,L0/2,cstSize)';  
            yn  = linspace( (-L0/2)-(t0),0,hSize)'; yn(end)=[];
            yp  = linspace(0,(L0/2)+(t0),hSize)';
            yc  = ((L0/2)+(t0))*ones(1,2*hSize-1)';
            yic = ((L0/2)+(t0))*ones(1,hSize)';
            x0 = [-xc;  xn;xp; xc; flipud(xp);flipud(xn);];
            y0 = [yn;yp;   yc; flipud(yp); flipud(yn); -yc];          
            xS0 = repmat(x0,N,1);   xS0(end-hSize:end)=[]; 
            yS0 = repmat(y0,N,1);   yS0(end-hSize:end)=[];
            xS0 = [flipud(xn);xS0]; yS0 = [-yc(1:numel(xn));yS0]; 
            zSize = numel(xS0);
            zp = linspace(start,fin, zSize)';
            zS0 = (h*zp)./(2*pi*N);   zS0 = zS0+(wT/2);
            xS=[xS;xS0]; yS=[yS;yS0]; zS=[zS;zS0];
            % -z
            xn = linspace((-W0/2)-(t0),0,hSize)'; xn(end)=[];
            xp = linspace(0,(W0/2)+(t0),hSize)';
            xc = ((W0/2)+(t0))*ones(1,2*hSize-1)';    
            yn  = linspace( (-L0/2)-(t0),0,hSize)'; yn(end)=[];
            yp  = linspace(0,(L0/2)+(t0),hSize)';
            yc  = ((L0/2)+(t0))*ones(1,2*hSize-1)';
            yic = ((L0/2)+(t0))*ones(1,hSize)';                        
            x0 = [-xc;  xn;xp; xc; flipud(xp);flipud(xn);];
            y0 = [yn;yp;   yc; flipud(yp); flipud(yn); -yc];    
            xS0 = repmat(x0,N,1);   xS0(end-hSize:end)=[]; 
            yS0 = repmat(y0,N,1);   yS0(end-hSize:end)=[];
            xS0 = [flipud(xn);xS0]; yS0 = [-yc(1:numel(xn));yS0]; 
            zSize = numel(xS0);
            zp = linspace(start,fin, zSize)';
            zS0 = (h*zp)./(2*pi*N);   zS0 = zS0-(wT/2);
            xS=[xS;xS0]; yS=[yS;yS0]; zS=[zS;zS0]; 
            % +xy  
            % set up x&y segments 
            xn = linspace(-(W0/2)-(t0+txy),0,hSize)'; xn(end)=[];
            xp = linspace(0,(W0/2)+(t0+txy),hSize)';
            xc = ((W0/2)+(t0+txy))*ones(1,2*hSize-1)'; 
            yn  = linspace(-(L0/2)-(t0+txy),0,hSize)'; yn(end)=[];
            yp  = linspace(0,(L0/2)+(t0+txy),hSize)';
            yc  = ((L0/2) + (t0+txy))*ones(1,2*hSize-1)';        
            % set points that will be repmat
            x0 = [-xc;  xn;xp; xc; flipud(xp);flipud(xn);];
            y0 = [yn;yp;   yc; flipud(yp); flipud(yn); -yc];    
            xS0 = repmat(x0,N,1);   xS0(end-hSize:end)=[]; 
            yS0 = repmat(y0,N,1);   yS0(end-hSize:end)=[];
            xS0 = [flipud(xn);xS0]; yS0 = [-yc(1:numel(xn));yS0]; 
            zSize = numel(xS0);
            zp = linspace(start,fin, zSize)';
            zS0 = (h*zp)./(2*pi*N);
            xS=[xS;xS0]; yS=[yS;yS0]; zS=[zS;zS0];  
            % -xy  
            % set up x&y segments 
            xn = linspace((-W0/2)-(t0)+txy,0,hSize)'; xn(end)=[];
            xp = linspace(0,(W0/2)+(t0)-txy,hSize)';
            xc = ((W0/2)+(t0)-txy)*ones(1,2*hSize-1)';    
            % y   = linspace(-L0/2,L0/2,cstSize)';  
            yn  = linspace( (-L0/2)-(t0)+txy,0,hSize)'; yn(end)=[];
            yp  = linspace(0,(L0/2)+(t0)-txy,hSize)';
            yc  = ((L0/2)+(t0)-txy)*ones(1,2*hSize-1)';    
            % set points that will be repmat
            x0 = [-xc;  xn;xp; xc; flipud(xp);flipud(xn);];
            y0 = [yn;yp;   yc; flipud(yp); flipud(yn); -yc]; 
            xS0 = repmat(x0,N,1);   xS0(end-hSize:end)=[]; 
            yS0 = repmat(y0,N,1);   yS0(end-hSize:end)=[];
            xS0 = [flipud(xn);xS0]; yS0=[-yc(1:numel(xn));yS0]; 
            zSize = numel(xS0);
            zp = linspace(start,fin, zSize)';
            zS0 = (h*zp)./(2*pi*N);
            xS=[xS;xS0]; yS=[yS;yS0]; zS=[zS;zS0];  
        end
        % END: LOOP: NXY
    else
        for nx=1:Nxy
            txy =(wT/2); 
            t0 = (3/2)*(wT)*(nx-1);
            % +z
            xn = linspace((-W0/2)-(t0),0,hSize)'; xn(end)=[];
            xp = linspace(0,(W0/2)+(t0),hSize)';
            xc = ((W0/2)+(t0))*ones(1,2*hSize-1)';    
            yn  = linspace( (-L0/2)-(t0),0,hSize)'; yn(end)=[];
            yp  = linspace(0,(L0/2)+(t0),hSize)';
            yc  = ((L0/2)+(t0))*ones(1,2*hSize-1)';
            x0 = flipud([-xc; xn;xp; xc; flipud(xp);flipud(xn);]);
            y0 = flipud([yn;yp;   yc; flipud(yp); flipud(yn); -yc]);  
            xS0 = repmat(x0,N,1); xS0(1:hSize)=[]; 
            yS0 = repmat(y0,N,1); yS0(1:hSize)=[];
            xS0 = [xS0;xn];       yS0=[yS0;-yc(1:numel(xn))]; 
            zSize = numel(xS0);
            zp = linspace(start,fin, zSize)';
            zS0 = (h*zp)./(2*pi*N);   zS0 = zS0+txy;
            xS=[xS;xS0]; yS=[yS;yS0]; zS=[zS;zS0]; 
            % -z
            xn = linspace((-W0/2)-(t0),0,hSize)'; xn(end)=[];
            xp = linspace(0,(W0/2)+(t0),hSize)';
            xc = ((W0/2)+(t0))*ones(1,2*hSize-1)';    
            % y   = linspace(-L0/2,L0/2,cstSize)';  
            yn  = linspace( (-L0/2)-(t0),0,hSize)'; yn(end)=[];
            yp  = linspace(0,(L0/2)+(t0),hSize)';
            yc  = ((L0/2)+(t0))*ones(1,2*hSize-1)';
            x0 = flipud([-xc;  xn;xp; xc; flipud(xp);flipud(xn);]);
            y0 = flipud([yn;yp;   yc; flipud(yp); flipud(yn); -yc]);  
            xS0 = repmat(x0,N,1); xS0(1:hSize)=[]; 
            yS0 = repmat(y0,N,1); yS0(1:hSize)=[];
            xS0 = [xS0;xn];       yS0=[yS0;-yc(1:numel(xn))]; 
            zSize = numel(xS0);
            zp = linspace(start,fin, zSize)';
            zS0 = (h*zp)./(2*pi*N);   zS0 = zS0-txy;
            xS=[xS;xS0]; yS=[yS;yS0]; zS=[zS;zS0];  
            % +xy 
            xn = linspace(-(W0/2)-(t0+txy),0,hSize)';
            xp = linspace(0,(W0/2)+(t0+txy),hSize)';
            xc = ((W0/2)+(t0+txy))*ones(1,2*hSize-1)'; 
            yn = linspace(-(L0/2)-(t0+txy),0,hSize)'; 
            yp = linspace(0,(L0/2)+(t0+txy),hSize)';
            yc = ((L0/2) + (t0+txy))*ones(1,2*hSize-1)';        
            % set points that will be repmat
            x0 = flipud([-xc; xn;xp; xc; flipud(xp);flipud(xn);]);
            y0 = flipud([yn;yp;   yc; flipud(yp); flipud(yn); -yc]); 
            xS0 = repmat(x0,N,1); xS0(1:hSize)=[]; 
            yS0 = repmat(y0,N,1); yS0(1:hSize)=[];
            xS0 = [xS0;xn];       yS0=[yS0;-yc(1:numel(xn))]; 
            zSize = numel(xS0);
            zp = linspace(start,fin, zSize)';
            zS0 = (h*zp)./(2*pi*N);   zS0 = zS0;
            xS=[xS;xS0]; yS=[yS;yS0]; zS=[zS;zS0]; 
            % -xy    
            xn = linspace((-W0/2)-(t0)+txy,0,hSize)'; xn(end)=[];
            xp = linspace(0,(W0/2)+(t0)-txy,hSize)';
            xc = ((W0/2)+(t0)-txy)*ones(1,2*hSize-1)';    
            yn  = linspace( (-L0/2)-(t0)+txy,0,hSize)'; yn(end)=[];
            yp  = linspace(0,(L0/2)+(t0)-txy,hSize)';
            yc  = ((L0/2)+(t0)-txy)*ones(1,2*hSize-1)';            
            % set points that will be repmat
            x0 = flipud([-xc; xn;xp; xc; flipud(xp);flipud(xn);]);
            y0 = flipud([yn;yp;    yc; flipud(yp); flipud(yn); -yc]); 
            xS0 = repmat(x0,N,1);  xS0(1:hSize)=[]; 
            yS0 = repmat(y0,N,1);  yS0(1:hSize)=[];
            xS0 = [xS0;xn];        yS0=[yS0;-yc(1:numel(xn))]; 
            zSize = numel(xS0);
            zp = linspace(start,fin, zSize)';
            zS0 = (h*zp)./(2*pi*N);   zS0 = zS0;
            xS=[xS;xS0]; yS=[yS;yS0]; zS=[zS;zS0];   
        end  
        % END: LOOP: NXY
    end      
end %% END: constrRectWire