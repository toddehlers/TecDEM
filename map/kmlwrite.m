function kmlwrite(ds,filename)
% Faisal Shahzad, 09.09.2008
% Should work with TecDEM, may not work outside TecDEM.
endl = '\n';
descript = 'This is a TecDEM Kml File';

header = strcat('<?xml version="1.0" encoding="UTF-8"?>', endl, ...
    '<kml xmlns="http://earth.google.com/kml/2.2">', endl, ...
    '<name>', 'TecDEM 2.0' , '</name>', endl, ...
    '<description>', descript,  '</description>', endl, ...
    '<Document>', endl);

footer = strcat('</Document>', endl, '</kml>', endl);

output = '';
endl = '\n';
splacemark = strcat('<Placemark>', endl);
eplacemark = strcat('</Placemark>', endl);

BasinStyle = strcat('<Style id="Basin1"> \n', ...
    '<LineStyle> \n', ...
    '<width>1.5</width> \n', ...
    '</LineStyle> \n', ...
    '<PolyStyle> \n', ...
    '<color>7d00ff7d</color> \n', ...
    '</PolyStyle> \n', ...
    '</Style> \n');

sBasinPoly = strcat('<Polygon> \n', ...
    '<extrude>0</extrude> \n', ...
    '<altitudeMode>relative</altitudeMode> \n', ...
    '<outerBoundaryIs>\n');

eBasinPoly = strcat('</outerBoundaryIs>\n', ...
    '</Polygon>');

switch ds(1).Geometry
    
    case {'Line'}
        
        for id = 1:1:length(ds);
            
            data = {num2str(ds(id).Lon,'%.4f'),repmat(',',size(ds(id).Lat)), ...
                num2str(ds(id).Lat,'%.4f'), repmat(',',size(ds(id).Lat)),...
                num2str(zeros(size(ds(id).Lat))), repmat('\n',size(ds(id).Lat))};
            
            stackedarrays = horzcat(data{:})';
            
            data = stackedarrays(:)';
            
            name = strcat('<name>', strcat('ID_',num2str(id)), '</name>', endl );
            
            coords = strcat(endl, '<LineString>', endl, '<coordinates>', endl, data,   '</coordinates>', endl, '</LineString>', endl);
            
            styleurl = strcat('<styleUrl> </styleUrl>');
            
            desc = strcat('<description>', strcat('Value #',num2str(id)),  '</description>', endl );
            output = strcat(output,splacemark,name, desc,  styleurl, coords, eplacemark);
            
        end
        
    case {'Polygon'}
        
        
        for id = 1:1:length(ds);
            
            data = {num2str(ds(id).Lon','%.4f'),repmat(',',size(ds(id).Lat')), ...
                num2str(ds(id).Lat','%.4f'), repmat(',',size(ds(id).Lat')),...
                num2str(zeros(size(ds(id).Lat'))), repmat('\n',size(ds(id).Lat'))};
            
            stackedarrays = horzcat(data{:})';
            
            data = stackedarrays(:)';
            
            name = strcat('<name>', strcat('ID_',num2str(id)), '</name>', endl );
            
            coords = strcat(endl, '<LinearRing>', endl, '<coordinates>', endl, data,   '</coordinates>', endl, '</LinearRing>', endl);
            
            styleurl = strcat('<styleUrl></styleUrl>');
            
            desc = strcat('<description>', strcat('Basin # ',num2str(id)),  '</description>', endl );
            output = strcat(output,splacemark,name, desc,  styleurl, coords,eplacemark);
            
            
        end
        
        
    case {'Point'}
        
        
        for id = 1:1:length(ds);
            
            data = {num2str(ds(id).Lon','%.4f'),repmat(',',size(ds(id).Lat')), ...
                num2str(ds(id).Lat','%.4f'), repmat(',',size(ds(id).Lat')),...
                num2str(zeros(size(ds(id).Lat'))), repmat('\n',size(ds(id).Lat'))};
            
            stackedarrays = horzcat(data{:})';
            
            data = stackedarrays(:)';
            
            name = strcat('<name>', strcat('KP_',num2str(id)), '</name>', endl );
            
            coords = strcat(endl, '<Point>', endl, '<coordinates>', endl, data,   '</coordinates>', endl, '</Point>', endl);
            
            styleurl = strcat('<styleUrl> </styleUrl>');
            
            desc = strcat('<description>', strcat('Latitude ',num2str(ds(id).Lat','%.4f'),'\n Longitude ',num2str(ds(id).Lon','%.4f') ), '</description>', endl );
            output = strcat(output,splacemark,name, desc,  styleurl, coords, eplacemark);
            
            
        end
        
end

fid = fopen(strcat(filename(1:end-4),'.kml'), 'wt');

fprintf(fid,strcat(header,output,footer));

fclose(fid);

return;

end


