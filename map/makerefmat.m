function R = makerefmat(x11,y11,dx,dy)

R(1,1) = 0;
R(2,1) = dx;
R(3,1) = x11-dx/2;

R(1,2) = -dy;
R(2,2) = 0;
R(3,2) = y11+dx/2; % Because of half pixel start