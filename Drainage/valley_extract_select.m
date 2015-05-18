function valley_extract_select(varargin)

try
    fig  = evalin('base','str_plt_hand');
    figure(fig)
    clf
    set(fig ,'Name','Valley Shapes','NumberTitle','off','MenuBar','none');

catch
    fig = figure('Units','Pixels','Name','Valley Shapes','NumberTitle','off','MenuBar','none');
    tecfig = evalin('base','tecfig');
    pos=get(tecfig,'Position');
    set(fig,'Position',[pos(1) pos(2) 550 400 ]);
end

set(gcf,'CloseRequestFcn',@close_auto_basins);

% assignin('base','curr_val',curr_val);
file_manu = uimenu(fig,'Label','File');
% e_using =  uimenu(file_manu,'Label','Base Plot');
% uimenu(e_using,'Label','Digital Elevation Model','Callback',@plot_grid_extract,'Accelerator','G');
% uimenu(e_using,'Label','Drainage Network','Callback',@plot_drainage_extract,'Accelerator','N');
mnuopenproject =  uimenu(file_manu,'Label','Color Coding','Callback',@basin_coding,'Accelerator','w');

mnuopenproject =  uimenu(file_manu,'Label','Refresh Plot','Callback',@basin_grid_extract_referesh,'Accelerator','r');

mnuopenproject =  uimenu(file_manu,'Label','Exit','Callback',@close_auto_basins,'Separator','on','Accelerator','X');

edt_manu = uimenu(fig,'Label','Edit');
mnuopenproject =  uimenu(edt_manu,'Label','Delete Basin','Callback',@delete_basin,'Accelerator','D');
mnuopenproject =  uimenu(edt_manu,'Label','Zoom In','Callback',@ZoomIn,'Accelerator','I');
mnuopenproject =  uimenu(edt_manu,'Label','Zoom Out','Callback',@ZoomOut,'Accelerator','O');

ext_manu = uimenu(fig,'Label','Extract');
ext = uimenu(ext_manu,'Label','Identify Valley','Callback',@extract_specific_valley ,'Accelerator','a');
ext =    uimenu(ext_manu,'Label','Save Valley','Callback',@save_specific_valley , 'Accelerator','s');
assignin('base','str_plt_hand',fig);

try
    plot_col  = evalin('base','plot_col')';
catch
    plot_col = ['k';'r'];
end

assignin('base','plot_col',plot_col);
assignin('base','disptyp','grid');
assignin('base','extfig',fig);

load_grid_base('caller','FLOW')
numl = numel(flowdir);
from = find(flowdir ~= -1);
to = flowdir(from);
fd =sparse(from,to,1,numl,numl);

assignin('base','fd',fd);

valey_extract();

end
