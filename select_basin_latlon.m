function select_basin_latlon (lat,lon,name)

area_info = evalin('base','area_info');
info = evalin('base','info');

[ra,ca] = map2pix(area_info.RefMatrix,lon,lat);


load_grid_base('caller','FLOW')
load_grid_base('caller','DEM')

r = size(dem);

numl = numel(flowdir);
from = find(flowdir ~= -1);
to = flowdir(from);
fd =sparse(from,to,1,numl,numl);

id = sub2ind(r,round(ra),round(ca));

basinmatrix = zeros(r);

while ~isempty(id)
    basinmatrix(id(1)) = 1;
    id = [id; find(fd(:,id(1)) == 1)];
    id(1) = [];
end

basinmatrix(:,1) = 0;
basinmatrix(:,end) = 0;
basinmatrix(1,:) = 0;
basinmatrix(end,:) = 0;

savefile = strcat(info.path,['_' name '.mat']);
save(savefile,'basinmatrix','-v7.3');