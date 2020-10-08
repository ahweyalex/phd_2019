clear all; close all; clc;

figure;
axis equal
hold on
X = [300, 600];
Y = [100, 200];
radius = 0.05;
edge_color = 'k';
% compute the dx
dx = X(1,2) - X(1,1);
% compute the dy
dy = Y(1,2) - Y(1,1);
% reduce X and Y by radius
X_reduced = [X(1,1) + (radius .* dx), ...
    X(1,2) - (radius .* dx)];
Y_reduced = [Y(1,1) + (radius .* dx), ...
    Y(1,2) - (radius .* dx)];
d_theta = pi/50;
theta = 0:d_theta:pi/2;
% initialize the complete series
x_rect = [];
y_rect = [];
% for each corner solve the circle equation
for vertex=1:4
    % start at top right vertex, the arc that we want to first will run
    % from 0 to pi/2 radians
    
    % we cycle through the vertices in a counter-clockwise sense so that
    % as we increment theta by pi/2, we arrive at the arc corresponding
    % to the rounded corner
    if (vertex == 1)
        % top right
        x = max(X_reduced); y = max(Y_reduced);
    elseif (vertex == 2)
        % top left
        x = min(X_reduced); y = max(Y_reduced);
    elseif (vertex == 3)
        % bottom left
        x = min(X_reduced); y = min(Y_reduced);
    elseif (vertex == 4)
        % bottom right
        x = max(X_reduced); y = min(Y_reduced);
    end
    % plot circle arc
    xunit = (radius .* dx) * cos(theta) + x;
    yunit = (radius .* dx) * sin(theta) + y;
    % add current sector to series
    x_rect = cat(2, x_rect, xunit);
    y_rect = cat(2, y_rect, yunit);
    % increment theta
    theta = theta + pi/2;
end
% close the polygon
x_rect = cat(2, x_rect, x_rect(1,1));
y_rect = cat(2, y_rect, y_rect(1,1));
plot(x_rect, y_rect,'o', ...
    'Color', edge_color);
t='t';
