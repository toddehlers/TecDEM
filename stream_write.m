function stream_write(varargin)
% stream_write.m
% This function is used to write ith stream in a text file.
%
% TecDEM: A MATLAB based tool box for understanding tectonics from digital
% elevation models.
% Faisal Shahzad
% TU Bergakademie, Freiberg, Germany
% geoquaidian@gmail.com
%
%


dd = evalin('base','curr_val');



info = evalin('base','info');
stream = evalin('base','stream');

area_info = evalin('base','area_info');

res1 = area_info.PixelScale(1);
res2 = area_info.PixelScale(2);
y1 = area_info.TiePoints.WorldPoints.Y;
x1 = area_info.TiePoints.WorldPoints.X;

R = makerefmat(x1, y1,res1,-res2);


[filename, pathname] = uiputfile(strcat(info.path,'*.txt'),'Save current Stream and Knickpoints as .txt Files');

files = strcat(pathname,filename);

if isempty(files)
    return
end


for ll = 1:1:length(dd)

    i = dd(ll);
    kps_id = stream(i).knickpoint;
    [lo la]=pix2map(R,stream(i).lon,stream(i).lat);

    %     fid = fopen(strcat(info.path,'_stream_',num2str(i),'.txt'), 'wt');

    fid = fopen(strcat(files(1:end-4),'_stream','.txt'), 'wt');

    data = [la, lo, stream(i).x, stream(i).y, stream(i).len, stream(i).elevation, stream(i).rawelevation, stream(i).area];
    fprintf(fid, strcat('Lat\t','Lon\t','X\t','Y\t','Length\t','FilledElevation\t','RawElevation\t','Area\n'));

    for k = 1:1:length(data(:,1))
        fprintf(fid,'%6.4f\t%6.4f\t%6.0f\t%6.0f\t%6.6f\t%6.6f\t%6.6f\t%6.6f\n', data(k,:));
    end

    fclose(fid);


    fid_kps = fopen(strcat(files(1:end-4),'_knickpoints','.txt'), 'wt');
    data = data(kps_id,:);
    fprintf(fid_kps, strcat('ID\t Lat\t','Lon\t','X\t','Y\t','Length\t','FilledElevation\t','RawElevation\t','Area\n'));

    for k = 1:1:length(data(:,1))
        fprintf(fid,'%6.0f\t%6.4f\t%6.4f\t%6.0f\t%6.0f\t%6.6f\t%6.6f\t%6.6f\t%6.6f\n', [k data(k,:)]);
    end
    fclose(fid_kps);

end

add_histroy({strcat('Stream No. ',dd, 'saved in the project folder')});
