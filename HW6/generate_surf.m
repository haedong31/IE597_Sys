%% generate fractal surface
clc
close all
clear variables

n=6;
H=0.8;
[~, ~, frac_surf] = fractalsurface(n,H);

% plotting
surf(frac_surf, 'Edgecolor','none');
colormap jet
colorbar
axis tight
title('3D Fractal Surface')
xlabel('x')
ylabel('y')
zlabel('z')

save frac_surf frac_surf
