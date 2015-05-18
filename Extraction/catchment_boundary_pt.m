function catchment_boundary_pt(varargin)

load_grid_base('base','FLOW');

flowdir = evalin('base','flowdir');
%siz = evalin('base','siz');

siz = ginput(1);
add_histroy({'Point based Watershed Extraction Started'});

r = round([siz(2)-1,siz(2),siz(2)+1]);
c = round([siz(1)-1,siz(1), siz(1)+1]);

id = sub2ind(size(flowdir),r(:),c(:));

numl = numel(flowdir);
from = find(flowdir ~= -1);
to = flowdir(from);
fd =sparse(from,to,1,numl,numl);

basinmatrix = zeros(size(flowdir));

while ~isempty(id)
    basinmatrix(id(1)) = 1;
    id = [id; find(fd(:,id(1)) == 1)];
    id(1) = [];
end

basinmatrix(:,1) = 0;
basinmatrix(:,end) = 0;
basinmatrix(1,:) = 0;
basinmatrix(end,:) = 0;

assignin('base','basinmatrix',basinmatrix);

bout = boundary_trace8_pt(1);
assignin('base','bout',bout);


hold on
plot(bout.ibc,bout.ibr,'-')