function [x2 y2] = slope2line(x1,y1,x2,y2,dr,dl)

x = [x1 x2];
y = [y1,y2];

mx = round(mean(x));
my = round(mean(y));

dx = x(2)-x(1);
dy = y(2)-y(1);

theta = pi/2 + atan(dy./dx);
ptheta = pi + theta;

dr = [1:dr];
dl = [1:dl];

if dx >= 0
    xa = mx + dr .* cos(theta);
    ya = my + dr .* sin(theta);
    xb = mx + dl .* cos(ptheta);
    yb = my + dl .* sin(ptheta);
else
    xb = mx - dr .* cos(ptheta);
    yb = my - dr .* sin(ptheta);
    xa = mx - dl .* cos(theta);
    ya = my - dl .* sin(theta);
end

x2 = round([xa xb]);
y2 = round([ya yb]);
