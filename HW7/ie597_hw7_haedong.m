%% data preparation
clc
close all
clear variables

t = 0:0.001:1;
x1 = cos(2*pi*5*t);
x2 = cos(2*pi*25*t);
x3 = cos(2*pi*50*t);

subplot(3, 1, 1)
plot(t, x1)
title('5 Hz')
xlabel('Time (s)')

subplot(3, 1, 2)
plot(t, x2)
title('25 Hz')
xlabel('Time (s)')

subplot(3, 1, 3)
plot(t, x3)
title('50 Hz')
xlabel('Time (s)')

%% slide 9
% stationary
x4 = x1 + x2+ x3;

% non-stationary
cidx1 = find(t == 0.3);
cidx2 = find(t == 0.6);

x5 = [x1(1:cidx1), x2(cidx1+1:cidx2), x3(cidx2+1:end)];

subplot(2, 1, 1)
plot(t, x4)
title('A signal with three frequency components')
xlabel('Time (s)')

subplot(2, 1, 2)
plot(t, x5)
title('A signal with three frequency component at varying times')
xlabel('Time (s)')

%% slide 10
l = length(t);

y1 = fft(x1);
p12 = abs(y1)/l;
p11 = p12(1:l/2+1);
