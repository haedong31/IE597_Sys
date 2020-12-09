clc
close all
clear variables

load('embed_matrix')

[len_ko_trc, ~] = size(ko_embed_mx);
[len_wt_trc, ~] = size(wt_embed_mx);

ko_rec_mx = cell(len_ko_trc, 1);
for k = 1:len_ko_trc
    s = ko_embed_mx{k};
    [num_pts, ~] = size(s);
    
    rec_mx = zeros(num_pts, num_pts);
    for i = 1:num_pts
        for j = i:num_pts
            d = norm(s(i, :) - s(j, :));
            rec_mx(i, j) = d;
            rec_mx(j, i) = d;
        end
    end

    ko_rec_mx{k} = rec_mx;
end

wt_rec_mx = cell(len_wt_trc, 1);
for k = 1:len_wt_trc
    s = wt_embed_mx{k};
    [num_pts, ~] = size(s);
    
    rec_mx = zeros(num_pts, num_pts);
    for i = 1:num_pts
        for j = i:num_pts
            d = norm(s(i, :) - s(j, :));
            rec_mx(i, j) = d;
            rec_mx(j, i) = d;
        end
    end

    wt_rec_mx{k} = rec_mx;
end

%% save
save('recurrence_mx.mat', 'ko_rec_mx','wt_rec_mx', '-v7.3')

for i = 1:len_ko_trc
    p = sprintf('./recurrence_matrix/ko%i.csv', i);
    writematrix(ko_rec_mx{i}, p)
end

for i = 1:len_wt_trc
    p = sprintf('./recurrence_matrix/wt%i.csv', i);
    writematrix(wt_rec_mx{i}, p)
end

%% visualization

