clear all; close all; clc;

% X, Y, and Z MESH (this specefies the drawing box
% x_inst is number of points from x_start to x_stop to calculate mag field.

%=========================================================================%
%{
nn = 1;
ns = 2e3;
NN = 19:220;
    wT= 0.2546e-3;  % 30AWG 
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
    % numSeg = 16; % rect
    numSeg = 200; % circ
    phi = numSeg;
    %phi = ns;
    %%[Sx,Sy,Sz] = singleLoop(ra,ri,phi,O,wT);
    %[Sx,Sy,Sz] = singleRectLoop(W0,L0,numSeg,wT,O);
    [Sx,Sy,Sz] = singleEllipticalLoop(ra,ri,numSeg,wT,O);
    r = [Sx,Sy,Sz]';
    plot3(Sx,Sy,Sz)
    %}
%%

for ns=19:220
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
    
%    xminb = 0; 
%     xmaxb = 0;
%     yminb = 0; 
%     ymaxb = 0;
    
    zminb = 0;
    zmaxb = 0; 
    %zminb = 0;
    %zmaxb = wT*.1; 
     Nx    = ns;
     Ny    = Nx;
%     Nz    = 2;
%    Nx = 105;
%    Ny = 105;
    Nz = 1;
    %=========================================================================%
    x_start =  xminb;
    x_stop  =  xmaxb;
    x_inst  =  Nx;
    y_start =  yminb;
    y_stop  =  ymaxb;
    y_inst  =  Ny;
    z_start =  xminb;
    z_stop  =  zmaxb;
    z_inst  =  Nz;
    % PARAMETRIZATION VARIABLE
    x = linspace(x_start, x_stop, x_inst);
    y = linspace(y_start, y_stop, y_inst);
    z = linspace(z_start, z_stop, z_inst);

    % This functions calculates points on a coil curve
    %line = define_coil([0, 0, -4]', 0.5, 5, 7, 1000);
    line = define_coil([0, 0, -4]', ri, 5, zEnd, 1000);
    
    % This function calculates dl vectors
    [curve, dl] = define_curve(r);
    %
    % This function calculates magnetic field with Bivot-Savart Law.
    [B_abs, B_x, B_y, B_z] = b_calc(x, y, z, curve, dl);

    % This is the same function as above but uses paralel for loop for speedup.
    % [B_abs, B_x, B_y, B_z] = b_calc_par(x, y, z, curve, dl);
    %=========================================================================%
    [X,Y,Z]=meshgrid(x,y,z);
    BZ = B_z;
    N  = 1;
    G  = 'r';
    I  = 1;
    [Matlab_L11(nn)] = selfInductance_BFields(ri,ra,I,X,Y,BZ,N,G);
    B__Z(nn)= B_z(ceil(Nx/2),ceil(Nx/2));
    nn = nn+1;
end

%%
% plots
fs = 12;

figure(1)
H=plot(NN,Matlab_L11(:)/1e-9,'.-');
xlabel('Resolution X/Y','FontWeight','bold','FontSize', fs);  
ylabel('L11[nH]','FontWeight','bold','FontSize', fs);
title('Other Matlab Model','FontWeight','bold','FontSize', fs);

figure(2)
H=plot(NN,B__Z(:)/1e-9,'.-');
xlabel('Resolution X/Y','FontWeight','bold','FontSize', fs);  
ylabel('BZ','FontWeight','bold','FontSize', fs);
title('Other Matlab Model @approx(0,0,0)','FontWeight','bold','FontSize',fs);

disp('DONE');
%%
%{
%============================== DRAWING ===================================
% Draw magnetic field
slice(x, y, z, log(B_abs), [0], [0], []);
shading interp

% Draw coil
hold on
plot3(line(1, :), line(2, :), line(3, :), 'Color', 'r', 'LineWidth', 2);
%}