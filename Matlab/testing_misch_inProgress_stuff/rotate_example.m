syms u v
x = cos(u)*sin(v);
y = sin(u)*sin(v);
z = cos(v)*sin(v);

fsurf(x,y,z)
axis equal

syms t
Rx = [1 0 0; 0 cos(t) -sin(t); 0 sin(t) cos(t)];
Ry = [cos(t) 0 sin(t); 0 1 0; -sin(t) 0 cos(t)];
Rz = [cos(t) -sin(t) 0; sin(t) cos(t) 0; 0 0 1];

%First, rotate the surface about the x-axis by 45 degrees counterclockwise
xyzRx = Rx*[x;y;z];
Rx45 = subs(xyzRx, t, pi/4);
figure
fsurf(Rx45(1), Rx45(2), Rx45(3))
title('Rotating by \pi/4 about x, counterclockwise')
axis equal

%Rotate about the z-axis by 90 degrees clockwise.
xyzRz = Rz*Rx45;
Rx45Rz90 = subs(xyzRz, t, -pi/2);
figure
fsurf(Rx45Rz90(1), Rx45Rz90(2), Rx45Rz90(3))
title('Rotating by \pi/2 about z, clockwise')
axis equal

%Rotate about the y-axis by 45 degrees clockwise.
xyzRy = Ry*Rx45Rz90;
Rx45Rz90Ry45 = subs(xyzRy, t, -pi/4);
figure
fsurf(Rx45Rz90Ry45(1), Rx45Rz90Ry45(2), Rx45Rz90Ry45(3))
title('Rotating by \pi/4 about y, clockwise')
axis equal

%% scale and rotate
S = [1 0 0; 0 1 0; 0 0 3];
xyzScaled = S*[x; y; z];
figure
fsurf(xyzScaled(1), xyzScaled(2), xyzScaled(3))
title('Scaling by 3 along z')
axis equal
%Rotate the scaled surface about the x-, y-, and z-axis by 45 degrees 
%clockwise, in order z, then y, then x. The rotation matrix for 
% this transformation is as follows.
R = Rx*Ry*Rz;
xyzScaledRotated = R*xyzScaled;
xyzSR45 = subs(xyzScaledRotated, t, -pi/4);
% plot
fsurf(xyzSR45(1), xyzSR45(2), xyzSR45(3))
title('Rotating by \pi/4 about x, y, and z, clockwise')
axis equal
