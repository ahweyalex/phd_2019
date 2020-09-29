function r = define_cicrle(c_point, dir, R, inst)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
dir = dir ./ norm(dir);

t = linspace(0, 2*pi, inst);

x = R*cos(t);
y = R*sin(t);
z = zeros(1, inst);

r = [x; y; z];

alpha = vect_angle([0, 0, 1]', dir);
beta  = vect_angle([0, 1, 0]', dir);
gamma = vect_angle([1, 0, 0]', dir);

r = vect_rot_zxy(r, alpha, beta, gamma) + c_point;
end

function angle = vect_angle(vect1, vect2)
angle = acos(dot(vect1, vect2)/(norm(vect1)*norm(vect2)));
end


