
xS0 = [x0;
      xc; -x; -xc;   x;     %+z 
      xc; -x; -xc;   x;     %-z 
      xc+(wT/2)*Nz;-x-(wT/2)*Nz;-xc-(wT/2)*Nz;x+(wT/2)*Nz;%+xy 
      xc-(wT/2)*Nz;-x+(wT/2)*Nz;-xc+(wT/2)*Nz;x-(wT/2)*Nz;%-xy     

      % new addtions
      %-(xy)/2,+z
      xc-(wT/2)*Nz;-x+(wT/2)*Nz;-xc+(wT/2)*Nz;x-(wT/2)*Nz;
      %+(xy)/2,+z
      xc+(wT/2)*Nz;-x-(wT/2)*Nz;-xc-(wT/2)*Nz;x+(wT/2)*Nz;
      %-(xy)/2,+z
      xc-(wT/2)*Nz;-x+(wT/2)*Nz;-xc+(wT/2)*Nz;x-(wT/2)*Nz;
      %+(xy)/2,+z
      xc+(wT/2)*Nz;-x-(wT/2)*Nz;-xc-(wT/2)*Nz;x+(wT/2)*Nz;    

      % new addtions
      %-(xy)/4,+z
      xc-(wT/4)*Nz;-x+(wT/4)*Nz;-xc+(wT/4)*Nz;x-(wT/4)*Nz;
      %+(xy)/4,+z
      xc+(wT/4)*Nz;-x-(wT/4)*Nz;-xc-(wT/4)*Nz;x+(wT/4)*Nz;
      %-(xy)/4,+z
      xc-(wT/4)*Nz;-x+(wT/4)*Nz;-xc+(wT/4)*Nz;x-(wT/4)*Nz;
      %+(xy)/4,+z
      xc+(wT/4)*Nz;-x-(wT/4)*Nz;-xc-(wT/4)*Nz;x+(wT/4)*Nz;   
];

y0 = [y0;
      y; yc;  -y; -yc;  %+z 
      y; yc;  -y; -yc;  %-z 
      y+(wT/2)*Nz;yc+(wT/2)*Nz;-y-(wT/2)*Nz;-yc-(wT/2)*Nz;%+xy 
      y-(wT/2)*Nz;yc-(wT/2)*Nz;-y+(wT/2)*Nz;-yc+(wT/2)*Nz;%-xy 

      % new addtions
      %-(xy)/2,+z
      y-(wT/2)*Nz;yc-(wT/2)*Nz;-y+(wT/2)*Nz;-yc+(wT/2)*Nz;
      %-(xy)/2,-z
      y-(wT/2)*Nz;yc-(wT/2)*Nz;-y+(wT/2)*Nz;-yc+(wT/2)*Nz;
      %+(xy)/2,+z
      y+(wT/2)*Nz;yc+(wT/2)*Nz;-y-(wT/2)*Nz;-yc-(wT/2)*Nz;
      %+(xy)/2,-z
      y+(wT/2)*Nz;yc+(wT/2)*Nz;-y-(wT/2)*Nz;-yc-(wT/2)*Nz;

      % new-er addtions
      %-(xy)/4,+z
      y-(wT/4)*Nz;yc-(wT/4)*Nz;-y+(wT/4)*Nz;-yc+(wT/4)*Nz;
      %-(xy)/4,-z
      y-(wT/4)*Nz;yc-(wT/4)*Nz;-y+(wT/4)*Nz;-yc+(wT/4)*Nz;
      %+(xy)/4,+z
      y+(wT/4)*Nz;yc+(wT/4)*Nz;-y-(wT/4)*Nz;-yc-(wT/4)*Nz;
      %+(xy)/4,-z
      y+(wT/4)*Nz;yc+(wT/4)*Nz;-y-(wT/4)*Nz;-yc-(wT/4)*Nz;                            
   ];