clear all
clc

% loc = '/Users/mirjam/Documents/src/MatLab/matlab_tecdem/sample_data/S16/S016_INFO.mat';
% loc = '/Users/mirjam/Desktop/TecDEM_2/data/bolivia/s09/s09_INFO.mat';
loc = '/Users/fshahzad/Dropbox/personal/TecDEM_25/data/bolivia/s09/s09_INFO.mat';
open_data_set_cl(loc)


bname = 'B09';
bin_ang = 5; % Bin size for angles, try to give in multiple of 5
rr = 10; % No. of pixels to search along rows
cc = 10; % No. of pixels to search along cols
m  = 2.3;


% ====== ====== ====== ====== ====== ====== ====== ====== ======
% ====== ====== ====== ====== ====== ====== ====== ====== ======
% DONT CHANGE BELOW unless you know what you are going to do.
load_grid_base('caller','DEM');
load_grid_base('caller',bname); % Give basin name here
load_grid_base('caller','FLOW');
load_grid_base('caller','CON');

refMAT = area_info.RefMatrix;

load_grid_base('caller',strcat('DUN_', bname ));

if ~exist('Ptot','var')

    siz = size(dem);
    inds = 1:1:numel(dem);
    [r c]=ind2sub(siz,inds);
    
    Altitude = dem(inds);
    lat = refMAT(2) - (r-1)*refMAT(4);
    
    [P_nuc, P_mu_stopped, P_mu_fast, Ptot] = calc_dunai(Altitude,lat,siz);
%     shFac = ShieldingFactor(flowdir,dem,area_info);   % Dunai Method
%    shFac = Shielding_Corr_2(rr,cc,tzero1,dem,area_info,bin_ang,m); % Student Method (2) bin size

    %
    info = evalin('base','info');
    savefile = strcat(info.path,['_DUN_' bname '.mat']);
    save(savefile,'P_nuc', 'P_mu_stopped', 'P_mu_fast', 'Ptot','shFac','-v7.3')
    
end

% shFac=tshfac;
% shFac = 1-shFac;

ind = basinmatrix==1; % this is list of coordinates inside the extracted basin.

avg_P_nuc = mean(P_nuc(ind))

avg_P_mu_stopped = mean(P_mu_stopped(ind))
avg_P_mu_fast = mean(P_mu_fast(ind))
avg_Ptot = mean(Ptot(ind))

avg_shFac = mean(shFac(ind))

avg_P_nuc_shFac = mean(P_nuc(ind) .* shFac(ind))
avg_P_mu_stopped_shFac = mean(P_mu_stopped(ind) .* shFac(ind))
avg_P_mu_fast_shFac = mean(P_mu_fast(ind) .* shFac(ind))
avg_Ptot_shFac = mean(Ptot(ind) .* shFac(ind))

total_basin_area_KM2 = (sum(basinmatrix(:)) * area_info.res * area_info.res)/(1000*1000)


% figure
% Ptot(basinmatrix==0) = NaN;
% imagesc(Ptot)
% axis image
% colorbar
% title('Proudction rate')
% 




