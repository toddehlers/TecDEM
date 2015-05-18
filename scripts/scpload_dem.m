function scpload_dem(location_in,areaname_in,typ,bbox,location_out,areaname_out)

if ~exist(location_out, 'dir')
   
    mkdir(location_out);
    
end

if areaname_in ~= 0
    
    fls = strcat(location_in,areaname_in);
    area_info = geotiffinfo(fls);
    
    rawdem = double(geotiffread(fls,typ,bbox));
    
     
    fls = strcat(location_out,areaname_out);
   
    savefile = strcat(fls(1:end-4),'_rawDEM.mat');
    save(savefile,'rawdem','-v7.3')
    
    [ny nx] =size(rawdem);
    
        
    res1 = area_info.PixelScale(1);
    res2 = area_info.PixelScale(2);
    
    info.dtheta = -0.45;
    info.path = fls(1:end-4);
    info.project_name = areaname_out;
    res = 110000*res1;
    area_info.res = res;
    
    area_info.Height = ny;
    area_info.Width = nx;
    
    area_info.TiePoints.WorldPoints.Y = bbox(1);
    area_info.TiePoints.WorldPoints.X = bbox(4);
    area_info.RefMatrix = makerefmat(bbox(1), bbox(4),res1,-res2);
        
    assignin('base','info',info);
    assignin('base','area_info',area_info);
    assignin('base','r',[ny nx]);
    assignin('base','res',res);
    
    savefile = strcat(fls(1:end-4),'_INFO.mat');
    save(savefile,'area_info','info')
    dem_info_write()
    
    
    textfile = strcat(info.path,'_info.txt');
    
    fid=fopen(textfile,'r');
    
    while 1
        tline = fgetl(fid);
        
        if ~ischar(tline),
            
            break
            
        end
        
    end
    
    disp('Digital Elevation Model loaded successfully.');

else
    
    disp('Digital Elevation Model not loaded.');
        
end