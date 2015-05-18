function save_specific_basin(varargin)

try
    bout = evalin('base','bout');

catch
end

try
    plot_col  = evalin('base','plot_col')';
catch
    plot_col = ['k';'r'];
end

% try

if numel(bout) == 0
    msgbox('No basin to save..','Error....');
    return
else

    try
        s_basins=evalin('base','s_basins');
    catch
        s_basins = struct('ibr',[],'ibc',[],'obr',[],'obc',[],'dir',[]);
    end

    curr_val = length(s_basins)+1;
    s_basins(curr_val) = bout;
    strid = curr_val ;

    assignin('base','s_basins',s_basins);
    assignin('base','btrid',curr_val);
    assignin('base','bout',[]);

    disptyp = evalin('base','disptyp');

    for i = 1:1:length(s_basins)

        plot(s_basins(i).ibc,s_basins(i).ibr,strcat('-',plot_col(2)),'LineWidth',2);
        [ra ca]= mid_boundry(s_basins(i));
        text(ca,ra,num2str(i))

    end

    if strcmp(disptyp,'grid')

        strcut=plot(bout.ibc,bout.ibr,strcat('-',plot_col(1)),'LineWidth',2);
    else
        strcut=plot(bout.ibc,bout.ibr,strcat('-',plot_col(1)),'LineWidth',2);
    end


    assignin('base','curr_val',strid)


    info = evalin('base','info');
    savefile = strcat(info.path,'_ABSN.mat');
    save(savefile,'s_basins','strid')

    ListBox = evalin('base','ListBox');
    set(ListBox,'Val',length(s_basins),'String',num2str([1:1:length(s_basins)]'));
    add_histroy({strcat('Selected Basin No. ',num2str(strid),' was saved successfully.')});

end