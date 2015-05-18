function save_specific_valley(varargin)

try
    cout = evalin('base','cout');

catch
end

try
    plot_col  = evalin('base','plot_col')';
catch
    plot_col = ['k';'r'];
end

% try

if numel(cout) == 0
    msgbox('No basin to save..','Error....');
    return
else

    try
        c_valley=evalin('base','c_valley');
    catch
        c_valley = struct('obr',[],'obc',[],'pbr',[],'pbc',[],'elev',[],'ind',[]);
    end

    curr_val = length(c_valley)+1;
    c_valley(curr_val) = cout;
    strid = curr_val ;

    assignin('base','c_valley',c_valley);
    assignin('base','btrid',curr_val);
    assignin('base','cout',[]);

    disptyp = evalin('base','disptyp');

    for i = 1:1:length(c_valley)

        plot(c_valley(i).obr,c_valley(i).obc,strcat('-',plot_col(2)),'LineWidth',2);
%         [ra ca]= mid_boundry(s_basins(i));
%         text(ca,ra,num2str(i))

    end

    if strcmp(disptyp,'grid')

        strcut=plot(cout.obr,cout.obc,strcat('-',plot_col(1)),'LineWidth',2);
    else
        strcut=plot(cout.obr,cout.obc,strcat('-',plot_col(1)),'LineWidth',2);
    end


    assignin('base','curr_val',strid)


    info = evalin('base','info');
    savefile = strcat(info.path,'_VAL.mat');
    save(savefile,'c_valley','strid')

    ListBox = evalin('base','ListBox');
    set(ListBox,'Val',length(c_valley),'String',num2str([1:1:length(c_valley)]'));
    add_histroy({strcat('Selected Valley No. ',num2str(strid),' was saved successfully.')});

end