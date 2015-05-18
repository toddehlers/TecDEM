function extract_specific_valley(varargin)

extractt = evalin('base','str_plt_hand');
dem = evalin('base','dem');

%strax = evalin('base','strax');

if extractt == 0
    msgbox('First Plot Girds or Drainage Network', 'Error');
    return
end

r = evalin('base','r');
load_grid_base('base','FLOW');
res = evalin('base','area_info.res');

try
    plot_col  = evalin('base','plot_col')';
catch
    plot_col = ['k';'r'];
end

try

    strhand = evalin('base','strhand');
    set(strhand,'Visible','off')
    extfig = evalin('base','extfig');
    figure(extfig);
    axes(strax);

end

[x y] = (ginput(2));
x = round(x);
y = round(y);

[x2 y2] = slope2line(x(1),y(1),x(2),y(2),100,100);
ind = sub2ind(size(dem),y2,x2);
elev = dem(ind);

cout = struct('obr',[],'obc',[],'pbr',[],'pbc',[],'elev',[],'ind',[]);
cout.obr = x;
cout.obc = y;
cout.pbr = x2;
cout.pbc = y2;
cout.elev = elev;

assignin('base','cout',cout);

hold on

strhand=plot(cout.obr,cout.obc,strcat('-',plot_col(1)),'LineWidth',2);

assignin('base','strhand',strhand)
