%% CWT
clc
clear
close all

Fs = 1000; % sampling rate
dt = 1/Fs; % sampling interval
L = 1024; % number of time points
t = 0:dt:((L-1)*dt); % time vector

x1 = cos(2*pi*5*t);
x2 = cos(2*pi*25*t);
x3 = cos(2*pi*50*t);
x4 = [x1(1:400), x2(401:800), x3(801:end)];

%% denoising using DWT - Signal A
clc
clear
close all

Fs = 100; % sampling rate
dt = 1/Fs; % sampling interval

tA = 0:dt:20;
dummy_vec = ones(1, length(tA));
noiz_size = 0.1;

idx1 = find(tA == 2);
a1 = band_noise(dummy_vec(1:idx1)*0, noiz_size);

idx2 = find(tA == 4);
a2 = band_noise(dummy_vec(idx1+1:idx2)*1, noiz_size);

idx3 = find(tA == 6);
a3 = band_noise(dummy_vec(idx2+1:idx3)*0, noiz_size);

idx4 = find(tA == 9);
a4 = band_noise(dummy_vec(idx3+1:idx4)*-1, noiz_size);

idx5 = find(tA == 9.5);
a5 = band_noise(dummy_vec(idx4+1:idx5)*0, noiz_size);

idx6 = find(tA == 11);
a6 = band_noise(dummy_vec(idx5+1:idx6)*-2, noiz_size);

idx7 = find(tA == 14);
a7 = band_noise(dummy_vec(idx6+1:idx7)*0, noiz_size);

idx8 = find(tA == 17);
a8 = band_noise(dummy_vec(idx7+1:idx8)*2, noiz_size);

idx9 = length(tA);
a9 = band_noise(dummy_vec(idx8+1:idx9)*0, noiz_size);

a = [a1, a2, a3, a4, a5, a6, a7, a8, a9];

plot(tA, a, '.', 'MarkerSize',0.1)
ylim([-4, 4])

%% denoising using DWT - Signal B
clc
clear
close all

Fs = 1000; % sampling rate
dt = 1/Fs; % sampling interval
noiz_size = 0.1;

tB = 0:dt:2;
dummy_vec = ones(1, length(tB));

idx1 = find(tB == 0.8);
A1 = 1/2; 
N1 = 5; % cycles of Gaussian pulse
f1 = N1/0.8; % frequency
b1 = A1*(1-cos(2*pi*f1*tB(1:idx1)/N1)).*sin(2*pi*f1*tB(1:idx1));
b1 = band_noise(b1, noiz_size);

idx2 = find(tB == 1);
b2 = band_noise(ones(1, idx2-idx1)*0, noiz_size);

idx3 = find(tB == 1.5);
A3 = 1/4;
N3 = 12;
f3 = N3/(1.5-1);
b3 = A3*(1-cos(2*pi*f3*tB(idx2+1:idx3)/N3)).*sin(2*pi*f3*tB(idx2+1:idx3));
b3 = band_noise(b3, noiz_size);

idx4 = length(tB);
A4 = 1/4;
N4 = 26;
f4 = N4/(2-1.5);
b4 = A4*(1-cos(2*pi*f4*tB(idx3+1:idx4)/N4)).*sin(2*pi*f4*tB(idx3+1:idx4));
b4 = band_noise(b4, noiz_size);

b = [b1, b2, b3, b4];
plot(tB, b, '.', 'MarkerSize',0.1)
ylim([-2, 2])
