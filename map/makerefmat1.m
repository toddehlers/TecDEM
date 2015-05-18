function R = makerefmat(x11,y11,dx,dy)
% FShahzad, geoquaidian@gmail.com
% 11.09.2011
R(1,1) = 0;
R(2,1) = dx;
R(3,1) = -dx+x11;

R(1,2) = dy;
R(2,2) = 0;
R(3,2) = -dy+y11; % Because of half pixel start