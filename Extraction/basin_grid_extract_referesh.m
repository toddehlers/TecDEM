function basin_grid_extract_referesh(varargin)
% This function is used to plot grid values i.e. digital elevation model or
% area grid.
% example:
%
% plot_grid('dem')
%
% plot_grid('area')
%
% TecDEM: A MATLAB based tool box for understanding tectonics from digital
% elevation models.
% Faisal Shahzad
% TU Bergakademie, Freiberg, Germany
% geoquaidian@gmail.com

try
    plot_col  = evalin('base','plot_col');
catch
    plot_col = ['k';'r'];
end

s_basins=evalin('base','s_basins');

hold on

for i = 1:1:length(s_basins)

    plot(s_basins(i).ibc,s_basins(i).ibr,strcat('-',plot_col(2)),'LineWidth',2);

    plot(s_basins(1).ibc,s_basins(1).ibr,strcat('-',plot_col(1)),'LineWidth',2);

    [ra ca]= mid_boundry(s_basins(i));
    text(ca,ra,num2str(i))
end