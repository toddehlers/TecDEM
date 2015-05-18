function [X,Y] = pix2map(R,ROW,COL)
% FShahzad, geoquaidian@gmail.com
% 11.09.2011

X = R(3,1)+(COL)*R(2,1);
Y = R(3,2)-(ROW)*R(1,2);