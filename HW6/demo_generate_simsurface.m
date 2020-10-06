% Please run this demo file to generate three different types of urfaces
% (1) Fracal surfacef
% (2) Sinusoidal surface
% (3) Random surface 

% If you find this toolbox useful, please cite the following papers:
% [1]	Y. Chen and H. Yang, Numerical simulation and pattern characterization of
% nonlinear spatiotemporal dynamics on fractal surfaces for the whole-heart modeling
% applications, European Physical Journal, DOI: 10.1140/epjb/e2016-60960-6

% [2]	B. Yao, F. Imani, A. Sakpal, E. W. Reutzel, and H. Yang*, “Multifractal 
% analysis of image profiles for the characterization and detection of defects 
% in additive manufacturing,” ASME Journal of Manufacturing Science and Engineering, 
% Vol. 140, No. 3, p031014-13, 2017, DOI: 10.1115/1.4037891

% [3]	F. Imani, B. Yao, R. Chen, P. Rao, and H. Yang*, “Joint multifractal 
% and lacunarity analysis of image profiles for manufacturing quality control”. 
% ASME Journal Manufacturing Science and Engineering, Vol. 141, No. 4, 
% p 044501-7, 2019. DOI: 10.1115/1.4042579

clear all
close all
clc

figure('color','w', 'Position', [477 402 1699 420])
%% Fractal surface
n=6;
H=0.8;
[row,col,R] = fractalsurface(n,H);
% % Fractal Surface Plot
subplot(1,3,1)
surf(R);
title('Fractal surface');
axis tight
colormap jet

%% Sinusoidal surface
subplot(1,3,2)
[X,Y] = meshgrid(1:0.25:30,1:0.25:30);
Z = 0.5*sin(X) + 0.5*cos(Y);
surf(Z)
title('Sinusoidal surface');
axis tight
colormap jet


%% Random surface
subplot(1,3,3)
[X,Y] = meshgrid(1:0.5:30,1:0.5:30);
for i=1:size(X,1)
    for j=1:size(Y,1)
        C(i,j)=rand();
    end
end
surf(C)
title('Random surface');
zlim([-1,2]);
axis tight
colormap jet


string = ('Hui Yang - PSU Complex Systems Lab');
ah = axes('units','normal','pos',[0 0 1 .02],'visible','off');
set(ah,'xlim',[0 1],'ylim',[0 1])
th = text(.6,.5,string,'fontsize',5);

