
clc

[x y] = (ginput(2));
x = round(x);
y = round(y);

[x2 y2] = slope2line(x(1),y(1),x(2),y(2),100,100);
ind = sub2ind(size(dem),y2,x2);
elev = dem(ind);

hold on
plot(x,y,'or')

figure
plot(dem(ind),'-k')

