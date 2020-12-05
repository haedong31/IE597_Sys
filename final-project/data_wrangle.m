clc
close all
clear variables

ko_base_path = './data/KO-traces-25s/';
wt_base_path = './data/WT-traces-25s/';

ko_dir = dir(strcat(ko_base_path, '*.xlsx'));
wt_dir = dir(strcat(wt_base_path, '*.xlsx'));

ko_trc = cell(1, length(ko_dir));
for i=1:length(ko_dir)
   p = strcat(ko_base_path, ko_dir(i).name);
   try
       df = readtable(p);
   catch ME
        fprintf(1, 'Error idetifier: %s \n', ME.identifier);
        fprintf(2, 'Error message: %s \n', ME.message);
   end
   t = df.Time_ms_;
   
   [~, end_idx] = min(abs(t-25*1000));
   ko_trc{i} = downsample(df(1:end_idx, :), 10);
end

wt_trc = cell(1, length(wt_dir));
for i=1:length(wt_dir)
    p = strcat(wt_base_path, wt_dir(i).name); 
    try    
        df = readtable(p);
    catch ME
        fprintf(1, 'Error idetifier: %s \n', ME.identifier);
        fprintf(2, 'Error message: %s \n', ME.message);
    end
    t = df.Time_ms_;
    
    [~, end_idx] = min(abs(t-25*1000));
    wt_trc{i} = downsample(df(1:end_idx, :), 10);
end

%% visualization 1; raw traces
for i=1:35
    df = ko_trc{i};
    figure(1)
    hold on
        plot(df.Time_ms_, df.Trace)
    hold off
    
    df = wt_trc{i};
    figure(2)
    hold on
        plot(df.Time_ms_, df.Trace)
    hold off
end
