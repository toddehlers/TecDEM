function plot_hyps_map(varargin)

try

    hyps =evalin('base','hyps');
    
catch
    
    load_grid_base('caller','HYP');

end
tecfig =evalin('base','tecfig');
pos = get(tecfig,'Position');

fig = figure('Units','Pixels','Name','Hypsometric map','NumberTitle','off');
% file_manu = uimenu(fig,'Label','Overlay');
% 
% mnuopenproject =  uimenu(file_manu,'Label','Drainage Network','Callback',@overlay_drainage);
% mnuimportdem =  uimenu(file_manu,'Label','Sub Basins','Callback',@overlay_subbasin);
set(fig,'Position',[pos(1) pos(2) pos(3) 420]);

imagesc(hyps);
title('Incision Map','FontSize',13)
xlabel('Longitude');
ylabel('Latitude');
axis image
add_histroy({'Hypsometric map plotted.'});
add_comm_line();