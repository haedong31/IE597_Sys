clc
close all
clear variables

% moving points on raw trace and 3-D embedding
load('downsampled.mat')
load('MI.mat')

%% WT group
idx = 1;
trc = wt_trc{idx};
tau = wt_tau(idx);

t = trc.Time_ms_;
s = trc.Trace;

[embedS, xidx] = time_delay_embed(s, tau, 3);

figure('Position',[100, 100, 550, 700])
for i = 1:length(xidx)
    % raw trace
    x = [t(i), t(i+tau), t(i+2*tau)];
    y = [s(i), s(i+tau), s(i+2*tau)];
    
    subplot(2, 1, 1)
    plot(t, s)
    hold on
        plot(x, y, 'o', 'MarkerFaceColor','red')        
        pause(0.01)
    hold off
    
    % embedded
    subplot(2, 1, 2)
    plot3(embedS(:, 1), embedS(:, 2), embedS(:, 3))
    hold on
        plot3(embedS(i, 1), embedS(i, 2), embedS(i, 3), 'o', 'MarkerFaceColor','red')
        drawnow
        view(3)
    hold off
end

%% KO group
idx = 1;
trc = ko_trc{idx};
tau = ko_tau(idx);

t = trc.Time_ms_;
s = trc.Trace;

[embedS, xidx] = time_delay_embed(s, tau, 3);

figure('Position',[100, 100, 550, 700])
for i = 1:length(xidx)
    % raw trace
    x = [t(i), t(i+tau), t(i+2*tau)];
    y = [s(i), s(i+tau), s(i+2*tau)];
    
    subplot(2, 1, 1)
    plot(t, s)
    hold on
        plot(x, y, 'o', 'MarkerFaceColor','red')        
        pause(0.01)
    hold off
    
    % embedded
    subplot(2, 1, 2)
    plot3(embedS(:, 1), embedS(:, 2), embedS(:, 3))
    hold on
        plot3(embedS(i, 1), embedS(i, 2), embedS(i, 3), 'o', 'MarkerFaceColor','red')
        drawnow
        view(3)
    hold off
end
