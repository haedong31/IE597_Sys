%% data preparation
clc
clear
close all

% generate time space
Fs = 1000; % sampling rate
dt = 1/Fs; % sampling interval
L = 1001; % number of time points
t = 0:dt:((L-1)*dt); % time vector

x1 = cos(2*pi*5*t);
x2 = cos(2*pi*25*t);
x3 = cos(2*pi*50*t);

subplot(3, 1, 1)
plot(t, x1)
axis tight
title('5 Hz')
xlabel('Time (s)')

subplot(3, 1, 2)
plot(t, x2)
axis tight
title('25 Hz')
xlabel('Time (s)')

subplot(3, 1, 3)
plot(t, x3)
axis tight
title('50 Hz')
xlabel('Time (s)')

%% slide 9
close all

% stationary
x4 = x1 + x2+ x3;

% non-stationary
cidx1 = find(t == 0.3);
cidx2 = find(t == 0.6);

x5 = [x1(1:cidx1), x2(cidx1+1:cidx2), x3(cidx2+1:end)];

figure(1)
plot(t, x4)
axis tight
xlabel('Time (s)')

figure(2)
plot(t, x5)
axis tight
xlabel('Time (s)')

%% FFT to stationary signal (x4)
X4 = fft(x4);

% sing side band
SSB4 = X4(1:ceil(L/2));
SSB4(2:end) = 2*SSB4(2:end);

% normalize
SSB4 = abs(SSB4/L);

% frequency space
f4 = (0:ceil(L/2)-1)*(Fs/L);

% inverse FFT
y4 = ifft(X4);

subplot(3, 1, 1)
plot(t, x4)
axis tight
title('x_4')
xlabel('Time (s)')

subplot(3, 1, 2)
[~, f4_idx] = min(abs(f4 - 100));
plot(f4(1:f4_idx), SSB4(1:f4_idx))
title('FFT of the above signal')
xlabel('Frequency (Hz)')
ylabel('Normalized amplitude')

subplot(3, 1, 3)
plot(t, y4)
title('Reconstructed x_4 using inverse FFT')
xlabel('Time (s)')

%% FFT to non-stationary signal (x5)
X5 = fft(x5);

% sing side band
SSB5 = X5(1:ceil(L/2));
SSB5(2:end) = 2*SSB5(2:end);

% normalize
SSB5 = abs(SSB5/L);

% frequency space
f5 = (0:ceil(L/2)-1)*(Fs/L);

% inverse FFT
y5 = ifft(X5);

subplot(3, 1, 1)
plot(t, x5)
axis tight
title('x_5')
xlabel('Time (s)')

subplot(3, 1, 2)
[~, f5_idx] = min(abs(f5 - 100));
plot(f5(1:f5_idx), SSB4(1:f5_idx))
title('FFT of the above signal')
xlabel('Frequency (Hz)')
ylabel('Normalized amplitude')

subplot(3, 1, 3)
plot(t, y5)
title('Reconstructed x_5 using inverse FFT')
xlabel('Time (s)')
