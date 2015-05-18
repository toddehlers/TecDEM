function plot_stream_EA(varargin)

try
    curr_val = evalin('base','curr_val');
catch
    curr_val = 1;
end

stream = evalin('base','stream');
srtm = stream(curr_val);

plot_profiles(srtm)