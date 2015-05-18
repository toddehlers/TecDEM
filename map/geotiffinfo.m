function tiff_info=geotiffinfo(fname)
% FShahzad, geoquaidian@gmail.com
% 11.09.2011
% Should work with TecDEM, 
% you might not get desired results if used for purpose other than TecDEM.
imginfo = imfinfo(fname);

tiff_info.Filename = imginfo.Filename;
tiff_info.FileModDate = imginfo.FileModDate;
tiff_info.FileSize = imginfo.FileSize;
tiff_info.Format = imginfo.Format;
tiff_info.FormatVersion = imginfo.FormatVersion;
tiff_info.Width = imginfo.Width;
tiff_info.Height = imginfo.Height;

tiff_info.BitDepth = imginfo.BitDepth;
tiff_info.ColorType = imginfo.ColorType;
tiff_info.GCS = imginfo.GeoAsciiParamsTag;
tiff_info.PixelScale = imginfo.ModelPixelScaleTag;

tiff_info.RefMatrix = makerefmat(imginfo.ModelTiepointTag(4), ...
                      imginfo.ModelTiepointTag(5), ...
                      imginfo.ModelPixelScaleTag(1), ...
                      -imginfo.ModelPixelScaleTag(2));

tiff_info.TiePoints.ImagePoints.Row = 0.5;
tiff_info.TiePoints.ImagePoints.Col = 0.5;

tiff_info.TiePoints.WorldPoints.X = imginfo.ModelTiepointTag(4);
tiff_info.TiePoints.WorldPoints.Y = imginfo.ModelTiepointTag(5);

BBOX = zeros(2,2);
BBOX(1) = imginfo.ModelTiepointTag(4);
BBOX(4) = imginfo.ModelTiepointTag(5);
BBOX(2) = BBOX(1) + (tiff_info.Width-1).*tiff_info.PixelScale(1);
BBOX(3) = BBOX(4) - (tiff_info.Height-1).*tiff_info.PixelScale(2);

tiff_info.BoundingBox = BBOX;
tiff_info.imginfo = imginfo;


