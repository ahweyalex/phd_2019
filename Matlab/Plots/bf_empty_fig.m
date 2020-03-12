figure
view(50,30)
grid on;
H=plot3([],[],[]);
tcks = [-1, -.75, -.5, -.25, 0, .25, 0.5, 0.75, 1];
xticks(tcks); yticks(tcks); zticks(tcks);
xlabel('x','fontSize',12,'fontweight','bold');
ylabel('y','fontSize',12,'fontweight','bold');
zlabel('z','fontSize',12,'fontweight','bold');
title('B-Fields Spatial Locations');