clc
clear all

% TecDEM execution scripts
scpAddpathlist();

folder = 'data/Pakistan/'; % Folder location to read in the big mosaic file or input data
file = 'Potwar.tif'; % File name in the above mentioned folder

outfolder = [folder 's16/']; % Where do you want to save processed data
outfile = 's16.tif';         % name of the processed files start with ????, its flexible

% bbox = area_info.BoundingBox;    % IF you want to process the whole data
bbox = [74  34;  72  32]; % upper left lower right

% Play around with these parameters
lat = -19.4161;  % Location for basin extraction or sample location
lon = -63.2563;
bname = 'B09';    % this is the basin name
% 
% 
% 
% 
% % ====== ====== ====== ====== ====== ====== ====== ====== ======
% % ====== ====== ====== ====== ====== ====== ====== ====== ======
% % DONT CHANGE BELOW unless you know what you are going to do.
% 
area_info=geotiffinfo(strcat(folder,file));
% bbox = area_info.BoundingBox;
scpload_dem(folder,file,'map',bbox,outfolder,outfile);
% scpfill_dem(); % Filling holes in DEM
% scpgridding_full(); % finding flow direction
% scpupslope_area2(); % Finding upslope area
% scpstrahlere_segments(1); % 1 sq km threshold to extract drainage network
% % scpcatcment_boundary(4); % 4th strahler order
% select_basin_latlon (lat,lon,bname);

%
% % ====== ====== ====== ====== ====== ====== ====== ====== ======
% % ====== ====== ====== ====== ====== ====== ====== ====== ======
% % JUST IN CASE YOU WANT TO HAVE A QUICK LOOK ON THE BASIN
%
% load_grid_base('caller','B09');
% figure
% imagesc(basinmatrix);
% axis image
% colorbar
% title('EXTRACTED BASIN')


% [a b] = map2pix(area_info.RefMatrix,72.5325,28.3658)
