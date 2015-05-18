function [ROW,COL] = map2pix(R,lon,lat)

COL = round(((lon - R(3,1))/R(2,1)));
ROW = round(((-lat + R(3,2))/R(1,2)));

if COL == 0
    COL = 1;
end


if ROW == 0
    ROW = 1;
end