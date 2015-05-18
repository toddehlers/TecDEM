function stream_statistic(varargin)

% this function calculate stream statistics

load_grid_base('caller','ADN');
info  = evalin('base','info');

area_info = evalin('base','area_info');
res = area_info.res;

output = [];

% output structure contains following entries
% 1) Strahler order
% 2) No. of Streams
% 3) Stream Length Km
% 4) Bifurcation ratio
% 5) mean stream length
% 6) cumulative stream length

for i = 1:1:length(netwk_order_ind)

    id = netwk_order_ind(i).ind;

    stream_len = 0;

    for k = 1:1:length(id)

        x = str_net(id(k)).colid;
        y = str_net(id(k)).rowid;
        stream_len = stream_len + sum(sqrt(diff(x).^2 + diff(y).^2))*res/1000;

    end

    output = [output; i numel(id) stream_len];

end

aa = output(:,2);
bb = circshift(aa,length(aa)-1);

biff_ratio = aa./bb;
biff_ratio(end) = -1;

mean_stream_length_km = output(:,3)./output(:,2);
cum_mean_stream_length_km = cumsum(mean_stream_length_km);
output = [output biff_ratio mean_stream_length_km cum_mean_stream_length_km];

fid = fopen(strcat(info.path,'_drainage_statistics.txt'),'wt');

fprintf(fid, strcat('Order\t','No.\t','Length(Km)\t','Bif. Ratio\t','Mean Length(Km) ','Cumm. Length(Km)\n'));

for k = 1:1:length(output(:,1))
    fprintf(fid,'%6.0f\t%6.0f\t%6.2f\t%6.3f\t%6.3f\t%6.3f\n', output(k,:));
end
    fprintf(fid,'--- end of statistics');
fclose(fid);

try
    info = evalin('base','info');
    filedisp(strcat(info.path,'_drainage_statistics.txt'),'Drainage Statistics Report...')
catch
    msgbox('First Load DEM...!','Error');
end



