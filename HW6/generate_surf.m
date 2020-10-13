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
set(gca,'CameraPosition', [257.8264 -186.2852   14.2589])

save frac_surf frac_surf
