dx=xS(1)-xS(end);
dy=yS(1)-yS(end);
dz=zS(1)-zS(end);

az=90;
el=0;
[rx,ry,rz]=sph2cart(az,el,dz);

p=[xS',yS',zS']*vrrotvec2mat(vrrotvec([dx dy dz],[rx ry rz]));
sx=p(:,1)+xS(1);
sy=p(:,2)+yS(1);
sz=p(:,3)+zS(1);

H=plot3(sx,sy,sz);