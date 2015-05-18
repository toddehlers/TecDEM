function basin_extract(varargin)
% This function is used to plot grid values i.e. digital elevation model or
% area grid.

%
% TecDEM: A MATLAB based tool box for understanding tectonics from digital
% elevation models.
% Faisal Shahzad
% TU Bergakademie, Freiberg, Germany
% geoquaidian@gmail.com

try
    load_grid_base('base','DEM');
catch
    msgbox('No DEM to plot.','Error');
end
% load_grid_base('base','AREA');

try
    plot_col  = evalin('base','plot_col')';
catch
    plot_col = ['k';'r'];
end



try
    grd = evalin('base','dem');

catch
    msgbox('No Grid for display','Error');
    return
end

try

    load_grid_base('base','ABSN');
    s_basins=evalin('base','s_basins');

catch

    s_basins = struct('ibr',[],'ibc',[],'obr',[],'obc',[],'dir',[],'outlet_r',[],'outlet_c',[]);
    s_basins(1) = [];
end

typ = 'dem';
% grd = evalin('base','dem');
% grd(grd == -9999) = NaN;
assignin('base','r',size(grd));
dispout = evalin('base','dispout');

add_histroy({'Start Plotting Digital Elevation Model.'});

str_plt_hand = evalin('base','str_plt_hand');

cl = get(str_plt_hand,'Color');
hp = uipanel('BackgroundColor',cl,'Position',[.05 .03 .7 .95]);

strax = axes('Parent',str_plt_hand,'Position',[.05 .06 .7 .9]);
set(strax,'DataAspectRatioMode','Manual','PlotBoxAspectRatioMode','Manual','Visible','Off')

hp = uipanel('BackgroundColor',cl,'Position',[.8 .03 .15 .95]);

pos = get(gcf,'Position');

tst = uicontrol('Style','text','String','Basin No.','Units','normalized', 'Position',[.81 .92 .13 .05],'BackgroundColor',cl);
ListBox = uicontrol('Style','ListBox','String','','Units','normalized', 'Position',[.81 .05 .13 .88],'CallBack', @ListBoxCallBack);
grd(grd == -9999) = NaN;
imagesc(grd)
colormap Jet
shading interp

axis image
set(gca,'YTick',[],'XTick',[])
hold on


for i = 1:1:length(s_basins)

    plot(s_basins(i).ibc,s_basins(i).ibr,strcat('-',plot_col(2)),'LineWidth',2);
    % text(s_basins(i).ibc(1),s_basins(i).ibr(1),strcat('',num2str(i)),'FontSize',13,'Color','k');
    [ra ca]= mid_boundry(s_basins(i));
    text(ca,ra,num2str(i))

end

try
    i = get(ListBox, 'Value');
    plot(s_basins(i).ibc,s_basins(i).ibr,strcat('-',plot_col(1)),'LineWidth',2);
catch

end

assignin('base','disptyp','grid');
assignin('base','extractt',1);

set(ListBox,'String',num2str([1:1:length(s_basins)]'));
add_histroy({'Finished Plotting Digital Elevation Model.'});

assignin('base','ListBox',ListBox);
assignin('base','s_basins',s_basins);
assignin('base','strax',strax);
assignin('base','tp','dem');


% add_comm_line();

    function ListBoxCallBack(varargin)

        try
            plot_col  = evalin('base','plot_col');
        catch
            plot_col = ['k';'r'];
        end
        
        try
                s_basins  = evalin('base','s_basins');
        catch
                s_basins = [];
        end
        
        for i = 1:1:length(s_basins)

            plot(s_basins(i).ibc,s_basins(i).ibr,strcat('-',plot_col(2)),'LineWidth',2);
            [ra ca]= mid_boundry(s_basins(i));
            text(ca,ra,num2str(i))

        end

        i = get(ListBox, 'Value');
        strhand=plot(s_basins(i).ibc,s_basins(i).ibr,strcat('-',plot_col(1)),'LineWidth',2);

        assignin('base','curr_val',i);

        assignin('base','strhand',strhand);

    end
end