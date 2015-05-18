function extract_specific_basin(varargin)

extractt = evalin('base','str_plt_hand');

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

[ca ra] = ginput(1);

bid = sub2ind(r,round(ra),round(ca));

basinmatrix = zeros(r);

id = bid;

fd = evalin('base','fd');

while ~isempty(id)
    basinmatrix(id(1)) = 1;
    id = [id; find(fd(:,id(1)) == 1)];
    id(1) = [];
end

basinmatrix(:,1) = 0;
basinmatrix(:,end) = 0;
basinmatrix(1,:) = 0;
basinmatrix(end,:) = 0;

bout = boundary_trace8_indvidual(basinmatrix,round(ra),round(ca),1);

assignin('base','bout',bout);

hold on

strhand=plot(bout.ibc,bout.ibr,strcat('-',plot_col(1)),'LineWidth',2);

assignin('base','strhand',strhand)
