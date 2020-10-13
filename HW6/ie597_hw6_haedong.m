clc
close all
clear variables

load frac_surf

% sample training data from surface
[nrow, ncol] = size(frac_surf);
sample_size = 50;
noise_sig = 1;

row_idx = datasample(1:nrow, sample_size, 'Replace',false);
col_idx = datasample(1:ncol, sample_size);

trnX = [row_idx', col_idx'];

% without noise
trnY = zeros(sample_size, 1);
for i=1:sample_size
    trnY(i) = frac_surf(row_idx(i), col_idx(i));
end

% noise into trnY
trnY = trnY + normrnd(0, 1, sample_size, 1);

% test data (full grid)
x1 = 1:nrow;
x2 = 1:ncol;
testX = apxGrid('expand', {x1', x2'});

% visualization
figure(1)
gobj(1) = surf(frac_surf, 'FaceAlpha',0.7, 'EdgeColor','none');
colormap jet
colorbar
hold on
    gobj(2) = scatter3(col_idx, row_idx, trnY, 'MarkerEdgeColor','black', 'MarkerFaceColor','black');
hold off
axis tight
xlabel('x2')
ylabel('x1')
zlabel('Surface Value')
legend(gobj(2), 'Training Data')
set(gca, 'CameraPosition',[379.5151 -315.1491    7.8348])
set(gca, 'Ydir','reverse')

%% train GP
% set up
mean_func = [];
cov_func = @covSEiso;
lik_func = @likGauss;
hyp1 = struct('mean',[], 'cov',[0, 0], 'lik',-1);

% hyperparameter optimization
hyp2 = minimize(hyp1, @gp, -20, @infGaussLik, mean_func, cov_func, lik_func, trnX, trnY);

% prediction
[ym, ys] = gp(hyp2, @infGaussLik, mean_func, cov_func, lik_func, trnX, trnY, testX);
ucb = ym + 1.96.*sqrt(ys);
lcb = ym - 1.96.*sqrt(ys);

% reshape mean vecto into grid
yym = reshape(ym, [nrow, ncol]);
uucb = reshape(ucb, [nrow, ncol]);
llcb = reshape(lcb, [nrow, ncol]);

% visualize prediction results
figure(2)
surf(yym, 'FaceColor','red', 'FaceAlpha',0.5, 'EdgeColor','none')
hold on
    surf(uucb, 'FaceColor',[0.5, 0.5, 0.5], 'FaceAlpha',0.7, 'EdgeColor','none')
    surf(llcb, 'FaceColor',[0.5, 0.5, 0.5], 'FaceAlpha',0.3, 'EdgeColor','none')
    scatter3(col_idx, row_idx, trnY, 'MarkerEdgeColor','black', 'MarkerFaceColor','black')
hold off
axis tight
xlabel('x2')
ylabel('x1')
zlabel('Surface Value')
set(gca, 'CameraPosition',[379.5151 -315.1491    7.8348])
set(gca, 'Ydir','reverse')
legend('Prediction', 'Upper Confidence Bound', 'Lower Confidence Bound', 'Training Data')

%% optimization
x1 = optimizableVariable('x1', [1, 65]);
x2 = optimizableVariable('x2', [1, 65]);

target_func = @(x)target_surf(x);
initX = array2table(trnX);
initX.Properties.VariableNames = {'Var1', 'Var2'};
bayesopt(target_func, [x1, x2], 'AcquisitionFunctionName', 'probability-of-improvement', ...
    'InitialX',initX, 'MaxObjectiveEvaluations',300)
