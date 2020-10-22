% OLD 
function [xS,yS,zS] = constrRectWire(h,W0,L0,numSeg,N,O,wT,Nxy)
    %deltaS    = 200;
    %helixSTEP = phi*(pi/180);
    start     = 0; 
    fin       = N*(2*pi); %+ helixSTEP/2;
    %cst_xxx   = start:helixSTEP:fin;
    cst_xxx = linspace(start,fin,numSeg);
    cstSize   = floor((numel(cst_xxx)/4)/N);
    hSize     = floor(cstSize);    % trying to fix it
    xS=[]; yS=[]; zS=[];
    
    if(O==1) %clock wise
        for nx=1:Nxy
            % even
            if(mod(nx,2)~=0)
                txy =(wT/2); 
                t0 = (3/2)*(wT)*(nx-1);
                % set up x-vectors
                xn = linspace((-W0/2)-(t0),0,hSize)'; 
                xn(end)=[];
                xp = linspace(0,(W0/2)+(t0),hSize)';
                xc = ((W0/2)+(t0))*ones(1,2*hSize-1)';  
                % set up y-vectors
                yn  = linspace( (-L0/2)-(t0),0,hSize)'; yn(end)=[];
                yp  = linspace(0,(L0/2)+(t0),hSize)';
                yc  = ((L0/2)+(t0))*ones(1,2*hSize-1)';
                yic = ((L0/2)+(t0))*ones(1,hSize)';
                % construction of x and y parts
                x0 = [-xc;  xn;xp; xc; flipud(xp);flipud(xn);];
                y0 = [yn;yp;   yc; flipud(yp); flipud(yn); -yc];          
                xS0 = repmat(x0,N,1);   xS0(end-hSize:end)=[]; 
                yS0 = repmat(y0,N,1);   yS0(end-hSize:end)=[];
                xS0 = [flipud(xn);xS0]; yS0 = [-yc(1:numel(xn));yS0]; 
                % z
                zSize = numel(xS0);
                zp = linspace(start,fin, zSize)';
                zS0 = (h*zp)./(2*pi*N);   
                % combine into arrays
                xS=[xS;xS0]; 
                yS=[yS;yS0]; 
                zS=[zS;zS0];
                % connetions between the coils along the xy-plane
                if(nx~=Nxy)
                    %c = 'c_odd'
                    %nx
                    t1 = (3/2)*(wT)*(nx);
                    LN = 4;
                    xC = linspace(0,0,LN)';
                    if(nx==1)
                        yC = -1*linspace(L0/2,L0/2+t1,LN)';
                    else
                        yC = -1*linspace(yc(1),yc(1)+t1,LN)';
                    end
                    zC = linspace(zS0(end),zS0(end),LN)';
                    xS = [xS;xC];
                    yS = [yS;yC];
                    zS = [zS;zC];
                end
                
            else
                txy =(wT/2); 
                t0 = (3/2)*(wT)*(nx-1);
                 % set up x-vectors
                xn = linspace((-W0/2)-(t0),0,hSize)'; xn(end)=[];
                xp = linspace(0,(W0/2)+(t0),hSize)';
                xc = ((W0/2)+(t0))*ones(1,2*hSize-1)';    
                % set up y-vectors
                yn  = linspace( (-L0/2)-(t0),0,hSize)'; yn(end)=[];
                yp  = linspace(0,(L0/2)+(t0),hSize)';
                yc  = ((L0/2)+(t0))*ones(1,2*hSize-1)';
                % construction of x and y parts
                x0 = flipud([-xc; xn;xp; xc; flipud(xp);flipud(xn);]);
                y0 = flipud([yn;yp;   yc; flipud(yp); flipud(yn); -yc]);  
                xS0 = repmat(x0,N,1); xS0(1:hSize)=[]; 
                yS0 = repmat(y0,N,1); yS0(1:hSize)=[];
                xS0 = [xS0;xn];       yS0=[yS0;-yc(1:numel(xn))]; 
                % z
                zSize = numel(xS0);
                zp = linspace(start,fin, zSize)';
                zS0 = (h*zp)./(2*pi*N);   
                % combine into arrays
                xS=[xS;xS0]; 
                yS=[yS;yS0]; 
                zS=[zS;zS0];
                if(nx~=Nxy)
                    %c = 'c_even'
                    %nx
                    t0 = (3/2)*(wT)*(nx);
                    LN = 4;
                    xC = linspace(0,0,LN)';
                    if(nx==1)
                        yC = -1*linspace(L0/2,L0/2+t1,LN)';
                    else
                        yC = -1*linspace(L0/2+t0,L0/2+t1,LN)';
                    end
                    zC = linspace(0,0,LN)';
                    xS = [xS;xC];
                    yS = [yS;yC];
                    zS = [zS;zC];
                end
            end
            %{
            % +z
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
            %}
        end
        % END: LOOP: NXY
    %counter clock wise
    else
        for nx=1:Nxy
            if(mod(nx,2)~=0)
                txy =(wT/2); 
                t0 = (3/2)*(wT)*(nx-1);
                 % set up x-vectors
                xn = linspace((-W0/2)-(t0),0,hSize)'; xn(end)=[];
                xp = linspace(0,(W0/2)+(t0),hSize)';
                xc = ((W0/2)+(t0))*ones(1,2*hSize-1)';    
                % set up y-vectors
                yn  = linspace( (-L0/2)-(t0),0,hSize)'; yn(end)=[];
                yp  = linspace(0,(L0/2)+(t0),hSize)';
                yc  = ((L0/2)+(t0))*ones(1,2*hSize-1)';
                % construction of x and y parts
                x0 = flipud([-xc; xn;xp; xc; flipud(xp);flipud(xn);]);
                y0 = flipud([yn;yp;   yc; flipud(yp); flipud(yn); -yc]);  
                xS0 = repmat(x0,N,1); xS0(1:hSize)=[]; 
                yS0 = repmat(y0,N,1); yS0(1:hSize)=[];
                xS0 = [xS0;xn];       yS0=[yS0;-yc(1:numel(xn))]; 
                % z
                zSize = numel(xS0);
                zp = linspace(start,fin, zSize)';
                zS0 = (h*zp)./(2*pi*N);   
                % combine into arrays
                xS=[xS;xS0]; 
                yS=[yS;yS0]; 
                zS=[zS;zS0];   
            else
                txy =(wT/2); 
                t0 = (3/2)*(wT)*(nx-1);
                % set up x-vectors
                xn = linspace((-W0/2)-(t0),0,hSize)'; xn(end)=[];
                xp = linspace(0,(W0/2)+(t0),hSize)';
                xc = ((W0/2)+(t0))*ones(1,2*hSize-1)';  
                % set up y-vectors
                yn  = linspace( (-L0/2)-(t0),0,hSize)'; yn(end)=[];
                yp  = linspace(0,(L0/2)+(t0),hSize)';
                yc  = ((L0/2)+(t0))*ones(1,2*hSize-1)';
                yic = ((L0/2)+(t0))*ones(1,hSize)';
                % construction of x and y parts
                x0 = [-xc;  xn;xp; xc; flipud(xp);flipud(xn);];
                y0 = [yn;yp;   yc; flipud(yp); flipud(yn); -yc];          
                xS0 = repmat(x0,N,1);   xS0(end-hSize:end)=[]; 
                yS0 = repmat(y0,N,1);   yS0(end-hSize:end)=[];
                xS0 = [flipud(xn);xS0]; yS0 = [-yc(1:numel(xn));yS0]; 
                % z
                zSize = numel(xS0);
                zp = linspace(start,fin, zSize)';
                zS0 = (h*zp)./(2*pi*N);   
                % combine into arrays
                xS=[xS;xS0]; 
                yS=[yS;yS0]; 
                zS=[zS;zS0];
            end
            %{
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
            %}
        end  % END: LOOP: NXY
    end %      
    
    % add feed lines, single coil
   if(Nxy==1 && O==1)
        LN = 20;
        t0 = (3/2)*wT;
        % top (last)
        xf_top = linspace(t0,t0,LN)';
        yf_top = linspace(-W0/2,-W0,LN)';
        zf_top = linspace(zS(end),zS(end),LN)';
        % bottom (first)
        xf_bot = linspace(0,0,LN)';
        yf_bot = linspace(-W0/2,-W0,LN)';
        zf_bot = linspace(0,0,LN)';
        % unit all
        xS=[xf_bot;xS;xf_top];
        yS=[yf_bot;yS;yf_top];
        zS=[zf_bot;zS;zf_top];   
   elseif(Nxy==1 && O==0)
        LN = 20;
        t0 = (3/2)*wT;
        % top (last)
        xf_bot = linspace(-t0,-t0,LN)';
        yf_bot = linspace(-W0/2,-W0,LN)';
        zf_bot = linspace(zS(end),zS(end),LN)';
        % bottom (first)
        xf_top = linspace(0,0,LN)';
        yf_top = linspace(-W0/2,-W0,LN)';
        zf_top = linspace(0,0,LN)';
        % unit all
        xS=[xf_bot;xS;xf_top];
        yS=[yf_bot;yS;yf_top];
        zS=[zf_bot;zS;zf_top];          
   end
    t='t';
end %% END: constrRectWire