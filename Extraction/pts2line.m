function [x2 y2] = pts2line(x1,y1,x2,y2)

x = [x1 x2];
y = [y1,y2];

dx = x(2)-x(1);
dy = y(2)-y(1);

theta = atan(dy./dx);

d = sqrt(power(diff(y),2) + power(diff(x),2));

nd = [1:1:d];

if dx >= 0
    x2 = x(1) + nd .* cos(theta);
    y2 = y(1) + nd .* sin(theta);
else
    x2 = x(1) - nd .* cos(theta);
    y2 = y(1) - nd .* sin(theta);
end
