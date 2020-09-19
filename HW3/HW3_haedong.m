%% Problem 1 - Brownian tree
clc
close all
clear variables

n = 400;
bt_mx = BrownianTree2(n, 15000);
xx = [];
yy = [];

for i=1:n
    for j=1:n
        if (bt_mx(i,j) == 0)
            continue
        else
            xx = [xx, i];
            yy = [yy, j];
        end
    end
end

scatter(xx, yy, 10, 'filled')
set(gca,'XColor', 'none','YColor','none')
title('Brownian Tree')

save('BT.mat')

%% Problem 2 -  Box counting method 
clc
close all
clear variables

load('BT.mat')
seed_idx = [200, 200];

% radius
rads = 1:99;
npts = zeros(1, length(rads));
for k=1:length(rads)
    r = rads(k);
    search_idx = -r:r;
    search_len = length(search_idx);
    
    cnt = 0;
    for i = 1:search_len
        for j = 1:search_len
            xidx = search_idx(i);
            yidx = search_idx(j);
            
            d = sqrt(xidx^2 + yidx^2);
            if (d<=r && d~=0)
                xidx = xidx + seed_idx(1);
                yidx = yidx + seed_idx(2);
                
                if(bt_mx(xidx, yidx))
                    cnt = cnt + 1;
                end
            else
                continue
            end            
        end
    end
    npts(k) = cnt;
end

log_rads = log(rads);
log_npts = log(npts);

plot(log_rads, log_npts, '-o')

%% Problem 3 - Recurrence plot of Lorenz attractor
clc
close all
clear variables

lparam0 = [10, 28, 8/3];
linit = [0, 1, 1.05];
[t, s] = Lorenz(lparam0, linit, 50);
x = s;

xlen = length(x);
rec_mx = zeros(xlen);
for i=1:xlen
    for j=i:xlen
        d = pdist([x(i,:); x(j,:)], 'euclidean');
        rec_mx(i,j) = d;
        rec_mx(j,i) = d;        
    end
end

figure(1)
imagesc(rec_mx);
colormap hot;
colorbar;
axis image;

xlabel('Time Index','FontSize',10,'FontWeight','bold');
ylabel('Time Index','FontSize',10,'FontWeight','bold');
get(gcf,'CurrentAxes');
set(gca,'YDir','normal')
set(gca,'LineWidth',2,'FontSize',10,'FontWeight','bold');
