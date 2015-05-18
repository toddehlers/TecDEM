function hyps_map(varargin)


load_grid_base('caller','DEM');

[r c]=size(dem);

pst = 1;

prompt={'Enter moving window size (pixels)'};
name='Hypsometric Map';
numlines=1;
defaultanswer={'10'};

typ=inputdlg(prompt,name,numlines,defaultanswer);

lt = typ;



if isempty(lt)
    return
end

lt = cell2mat(lt);
lt = str2num(lt);
add_histroy({'Start calculating Incision Grid.'});

add_histroy({strcat('Moving window size is set to ',num2str(lt),' Pixels')});

rr = lt;
cc = lt;
hyps = nan * ones(r,c);

for i = rr:1:r-(rr - 1)
    for j = cc:1:c-(cc - 1)

        sdem = dem(i-(rr - 1):1:i+(rr - 1),j-(rr - 1):1:j+(rr - 1));
        hyps(i,j) = (mean(sdem(:)) - min(sdem(:)))/(max(sdem(:)) - min(sdem(:)));

    end
    percent = round(100*(i*j)/(r*c));

    if percent == pst*1
        pause(0.0001)
        pst = pst +1;
        add_comments({strcat(num2str(percent),' Percent of calculation done')});
    end

end

info = evalin('base','info');
savefile = strcat(info.path,'_HYP.mat');
save(savefile,'hyps','-v7.3');

add_histroy({'Finish calculating Hypsometric Grid.'});
% figure; imagesc(incision); axis image
% assignin('base','incision',incision);

plot_hyps_map();

end