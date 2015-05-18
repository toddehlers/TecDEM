function [COL, ROW] = map2pix(R,lon,lat)
% % FShahzad, geoquaidian@gmail.com
% % 11.09.2011
X = [lon lat]';

B = R(3,:)';

dx = X(1) -R(3,1);
dy = X(2) -R(3,2);

if dx >= -R(2)  && dy >= -R(4)
    
    A = [R(2)  0; 0 R(4)]; % 1
    
elseif dx < -R(2)  && dy >= -R(4)
    
    A = [0 -R(2);0 R(4)]; % 2
    
elseif dx < -R(2)  && dy < -R(4)
    
    A = [R(2) 0;0 R(4)]; % 3

else

    A = [R(2) 0;0 R(4)]; % 4
    
end

% B(1) = -B(1)

Y = A*X+B;

COL = round(Y(2));
ROW = round(Y(1));