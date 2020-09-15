load('Matlab_L11_Nxy20to800_numS100to1k_Zat0_nz1.mat')
NXY = 800;
nn = 20:NXY;    
Mx = 26*ones(1,numel(nn)); 
figure(2)
fontSize = 12;
%in=1;
%inc=3;
%BT = Matlab_L11(in:inc:end,1); %15 to 60nH

in=2;
inc=2;
MT = Matlab_L11(in:inc:end,1); % 18 to 36nH %closet to the correct answer

%in=1;
%inc=4;
%TT = Matlab_L11(in:inc:end,1);  % 36 to 56nH

%H=plot(nn,Matlab_L11(:,1)/1e-9,'.',...
%    nn,Matlab_L11(:,2)/1e-9,'.',...
H=plot(nn(in:inc:end),MT(:,1)'/1e-9,'.');
%    nn(2:4:end),Mx(2:4:end),'-');
set(H(1),'color','r');
%set(H(2),'color','k');
%set(H(3),'color','k'); set(H(3),'Linewidth',2);
xlabel('X/Y resolution','FontWeight','bold','FontSize', fontSize); 
ylabel('L11[nH]','FontWeight','bold','FontSize', fontSize); 
title('L11(Matlab vs Maxwell) NZ=1 at zero','FontWeight','bold','FontSize', fontSize); 
xlim([15 820]);
%legend('Matlab Model','Maxwell','Location','SouthEast');
grid on; %grid minor;

%%
    %nn,Matlab_L11(:,3)/1e-9,'-',...
    %nn,Matlab_L11(:,4)/1e-9,'-',...
    %nn,Matlab_L11(:,5)/1e-9,'-',...
    %nn,Matlab_L11(:,6)/1e-9,'-',...
    %nn,Matlab_L11(:,7)/1e-9,'-',...
    %nn,Matlab_L11(:,8)/1e-9,'-',...
    %nn,Matlab_L11(:,9)/1e-9,'-',...
    %nn,Matlab_L11(:,10)/1e-9,'-',...