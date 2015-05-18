function img = geotiffread(varargin)
% FShahzad, geoquaidian@gmail.com
% 11.09.2011

if nargin == 1
    
    fname = varargin{1};
    Tinfo = geotiffinfo(fname);
    imgBox = [1 1; Tinfo.Height Tinfo.Width];
    
elseif nargin == 3
    
    fname = varargin{1};
    Tinfo = geotiffinfo(fname);
    
    if strcmp(varargin{2},'image')
    
        imgBox =  varargin{3};
    
    elseif strcmp(varargin{2},'map')
        
        mapBox =  varargin{3};

        [imgBox(1,1), imgBox(1,2)]=map2pix(Tinfo.RefMatrix,mapBox(1,1),mapBox(2,2));
        [imgBox(2,1), imgBox(2,2)]=map2pix(Tinfo.RefMatrix,mapBox(2,1),mapBox(1,2));
           
    else
        
        disp('second argument is not correct. exiting');
        img = [];
        return;
        
    end
    
else
    
    disp('not enought input arguments.. exiting');
    img = [];
    return;
    
end


fmt = Tinfo.BitDepth/8;

switch fmt
    
    case {1}
        format = 'uint8';
    case {2}
        format = 'int16';
    case{3}
        format = 'int32';
    case {4}
        format = 'single';
        
end

w = imgBox(4)- imgBox(3)+1;
h = imgBox(2)- imgBox(1)+1;

img=zeros(h,w,format);

ind = Tinfo.imginfo.StripOffsets;

fid = fopen(fname,'r','ieee-le');

imgBox(1)
imgBox(2)

for i= imgBox(1):1:imgBox(2)
    
    fseek(fid,ind(i),'bof');
    t=fread(fid,Tinfo.Width,format);
    img(i-imgBox(1)+1,:) = t(imgBox(3):imgBox(4));
    
end

fclose(fid);