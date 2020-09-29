%%
%{
x19 = bXc{1,1};
x20 = bXc{1,2};
x21 = bXc{1,3};
x22 = bXc{1,4};
x23 = bXc{1,5};
x24 = bXc{1,6};
y19 = bYc{1,1};
y20 = bYc{1,2};
y21 = bYc{1,3};
y22 = bYc{1,4};
y23 = bYc{1,5};
y24 = bYc{1,6};
BZ19 = BZc{1,1};
BZ20 = BZc{1,2};
BZ21 = BZc{1,3};
BZ22 = BZc{1,4};
BZ23 = BZc{1,5};
BZ24 = BZc{1,6};
%}
r50 = Rc{1,32};
DBX50 = dBx_c{1,32};
DBY50 = dBy_c{1,32};
DBZ50 = dBz_c{1,32};
x50 = bXc{1,32};
x49 = bXc{1,31};
x48 = bXc{1,30};
x47 = bXc{1,29};
y50 = bYc{1,32};
y49 = bYc{1,31};
y48 = bYc{1,30};
y47 = bYc{1,29};
BZ50 = BZc{1,32};
BZ49 = BZc{1,31};
BZ48 = BZc{1,30};
BZ47 = BZc{1,29};

x100 = bXc{1,82};
x99 = bXc{1,81};
x98 = bXc{1,80};
x97 = bXc{1,79};
y100 = bYc{1,82};
y99 = bYc{1,81};
y98 = bYc{1,80};
y97 = bYc{1,79};
BZ100 = BZc{1,82};
BZ99 = BZc{1,81};
BZ98 = BZc{1,80};
BZ97 = BZc{1,79};

x200 = bXc{1,182};
x199 = bXc{1,181};
x198 = bXc{1,180};
x197 = bXc{1,179};
y200 = bYc{1,182};
y199 = bYc{1,181};
y198 = bYc{1,180};
y197 = bYc{1,179};
BZ200 = BZc{1,182};
BZ199 = BZc{1,181};
BZ198 = BZc{1,180};
BZ197 = BZc{1,179};

x300 = bXc{1,282};
x299 = bXc{1,281};
x298 = bXc{1,280};
x297 = bXc{1,279};
y300 = bYc{1,282};
y299 = bYc{1,281};
y298 = bYc{1,280};
y297 = bYc{1,279};
BZ300 = BZc{1,282};
BZ299 = BZc{1,281};
BZ298 = BZc{1,280};
BZ297 = BZc{1,279};

%% L11
ri = 10e-3;
ra = 10e-3;
N  = 1;
G  = 'r';
I  = 1;

[L11_19] = ...
    selfInductance_BFields(ri,ra,I,x19,y19,BZ19,N,G);
[L11_20] = ...
    selfInductance_BFields(ri,ra,I,x20,y20,BZ20,N,G);
[L11_21] = ...
    selfInductance_BFields(ri,ra,I,x21,y21,BZ21,N,G);
[L11_22] = ...
    selfInductance_BFields(ri,ra,I,x22,y22,BZ22,N,G);
[L11_23] = ...
    selfInductance_BFields(ri,ra,I,x23,y23,BZ23,N,G);
[L11_24] = ...
    selfInductance_BFields(ri,ra,I,x24,y24,BZ24,N,G);
L11_a = [L11_19,L11_20,L11_21,L11_22,L11_23,L11_24];

[L11_297] = ...
    selfInductance_BFields(ri,ra,I,x297,y297,BZ297,N,G);
[L11_298] = ...
    selfInductance_BFields(ri,ra,I,x298,y298,BZ298,N,G);
[L11_299] = ...
    selfInductance_BFields(ri,ra,I,x299,y299,BZ299,N,G);
[L11_300] = ...
    selfInductance_BFields(ri,ra,I,x300,y300,BZ300,N,G);
L11_b = [L11_300,L11_299,L11_298,L11_297];

%% check intverals
%
for n=1:19-1
    x19d(n) = x19(1,n)-x19(1,n+1);
    y19d(n) = y19(n,1)-y19(n+1,1);
end
for n=1:20-1
    x20d(n) = x20(1,n)-x20(1,n+1);
    y20d(n) = y20(n,1)-y20(n+1,1);
end
for n=1:21-1
    x21d(n) = x21(1,n)-x21(1,n+1);
    y21d(n) = y21(n,1)-y21(n+1,1);
end
for n=1:22-1
    x22d(n) = x22(1,n)-x22(1,n+1);
    y22d(n) = y22(n,1)-y22(n+1,1);
end
for n=1:23-1
    x23d(n) = x23(1,n)-x23(1,n+1);
    y23d(n) = y23(n,1)-y23(n+1,1);
end
for n=1:24-1
    x24d(n) = x24(1,n)-x24(1,n+1);
    y24d(n) = y24(n,1)-y24(n+1,1);
end
xd = [x19d(1),x20d(1),x21d(1),x22d(1),x23d(1),x24d(1)];
yd = [y19d(1),y20d(1),y21d(1),y22d(1),y23d(1),y24d(1)];
%}

for n=1:297-1
    x297d(n) = x297(1,n)-x297(1,n+1);
    y297d(n) = y297(n,1)-y297(n+1,1);
end
for n=1:298-1
    x298d(n) = x298(1,n)-x298(1,n+1);
    y298d(n) = y298(n,1)-y298(n+1,1);
end
for n=1:299-1
    x299d(n) = x299(1,n)-x299(1,n+1);
    y299d(n) = y299(n,1)-y299(n+1,1);
end
for n=1:300-1
    x300d(n) = x300(1,n)-x300(1,n+1);
    y300d(n) = y300(n,1)-y300(n+1,1);
end
xd_ = [x297d(1),x298d(1),x299d(1),x300d(1)];
yd_ = [y297d(1),y298d(1),y299d(1),y300d(1)];
%%

figure(1)
H=surfc(x20,y20,BZ20);
title('BZ Res:20');
xlabel('x'); ylabel('y'); zlabel('BZ');

figure(1)
H=surfc(x50,y50,BZ50);
title('BZ Res:50');
xlabel('x'); ylabel('y'); zlabel('BZ');

figure(3)
H=surfc(x100,y100,BZ100);
title('BZ Res:100');
xlabel('x'); ylabel('y'); zlabel('BZ');

figure(4)
H=surfc(x200,y200,BZ200);
title('BZ Res:200');
xlabel('x'); ylabel('y'); zlabel('BZ');