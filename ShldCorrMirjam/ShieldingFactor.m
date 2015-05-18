function prodfac = ShieldingFactor(flowdir,dem,area_info,m)

siz = size(flowdir);

prodfac = ones(siz);

for ii = 2:1:siz(1) - 1
    disp(strcat('Percent Done',num2str(100*ii/siz(1))));
    
    for jj = 2:1:siz(2) - 1
        
        try
            ind = sub2ind(siz,ii,jj);
            
            [azimuth, nind] = inflow_indices(flowdir,siz,ind);
            
            dh = dem(nind) - dem(ind);
            dx = area_info.res;
            
            inclination =  atan(dh./dx);
            
%             m = 2.3;
            
            prodfac(ii,jj) = (1 - sum(azimuth.* power(sin(inclination),m+1))./360);
            
            
        catch
            
            prodfac(ii,jj) = 1;
        
        end
        
        
    end
    
end