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
ylabel('log(N)')
xlabel('log(l)')

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

% continuous version
figure(1)
imagesc(rec_mx);
colormap hot;
colorbar;
xlabel('Data Index')
ylabel('Data Index')
axis image;
get(gcf,'CurrentAxes');
set(gca,'YDir','normal')

% binary version
epsilon = 5;
bi_rec_mx = rec_mx <= epsilon;

figure(2)
imagesc(bi_rec_mx);
colormap([[1 1 1]; [0 0 0]])
xlabel('Data Index')
ylabel('Data Index')
axis image;
get(gcf,'CurrentAxes');
set(gca,'YDir','normal')

save('RP.mat')

%% Problem 4 - Recurrence quantification analysis
clc
close all
clear variables

load('RP.mat')

RR = recur_rate(bi_rec_mx);
DET = determinism(bi_rec_mx, 200);
LMAX = linemax(bi_rec_mx);
ENT = entropy(bi_rec_mx, 200);
LAM = laminarity(bi_rec_mx, 100);
TT = trap_time(bi_rec_mx, 100);

%% Problem 5 - Space time separation
clc
close all
clear variables

lparam0 = [10, 28, 8/3];
linit = [0, 1, 1.05];
[t, s] = Lorenz(lparam0, linit, 50);

x = s(:,1);

p = 0.1:0.1:0.9;
STPs = cell(1, length(p));
for i=1:length(p)
    STPs{i} = STP(x, 2, 500, p(i));
end

deltats = 0:1:500;
for j=1:length(p)
    hold on
    plot(deltats, STPs{j}, 'LineWidth',2) 
    hold off
end
axis tight
xlabel('Separation in time \Delta t')
ylabel('Separation in space')
% legend('0.1','0.2','0.3','0.4','0.5','0.6','0.7','0.8','0.9')
