function [a b r]=opposit_point(r1,c1,r2,c2)

% [r1 c1] = find(cdata == 0);

% c1 = evalin('base','xr');
% r1 = evalin('base','yr');

res1=sqrt(power((r1 - r2),2) + power((c1 - c2),2));
[r ind] = max(res1);

a = c1(ind(1));
b = r1(ind(1));