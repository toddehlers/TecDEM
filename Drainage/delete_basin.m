function delete_basin(varargin)

try
    curr_val = evalin('base','curr_val');
catch
    curr_val = 1;
end

r = evalin('base','r');
prompt={'Enter Basin number to be delete..'};
name='Delete Basin';
numlines=1;
defaultanswer={num2str(curr_val)};

typ=inputdlg(prompt,name,numlines,defaultanswer);

lt = typ;
lt = cell2mat(lt);


if isempty(lt)
    return
else
    lt = str2num(lt);
end

s_basins = evalin('base','s_basins');
try

    strid =  evalin('base','strid');
catch
    strid = 1;
end
strid = strid -1;

s_basins(lt) = [];

add_histroy({strcat('Basin No. ',num2str(lt),' was deleted.')});

assignin('base','s_basins',s_basins);
assignin('base','strid',strid);
assignin('base','curr_val',1);

info = evalin('base','info');

savefile = strcat(info.path,'_ABSN.mat');
save(savefile,'s_basins','strid')

tp = evalin('base','tp');

ListBox=evalin('base','ListBox');

set(ListBox,'String',num2str([1:1:length(s_basins)]'),'Value',1)

grd = evalin('base','dem');
grd(grd == -9999) = NaN;
imagesc(grd)
colormap Jet
shading interp
axis image

basin_grid_extract_referesh();