function shapewrite(ds,filename)
% This is a wrapper for KMWRITE, since we dont want to edit the TecDEM
% files right now and plane to write a shape file writing routine.
% Faisal Shahzad 10.10.2012

kmlwrite(ds,filename)


end