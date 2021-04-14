%% %%Smoothing Filter%% %%

clear all
close all
clc

%% Aliased frequencies
A = 0.1; % Amplitude
f1 = 697; % x1 frequency
f2 = 1209; % x2 frequency
fs = 8000; % Sampling frequency
t = [0 : 1/ fs: 2 ]; % [ start : step : end ]
ww = -pi: 0.0001: pi;

x1 = A*cos(2*pi*f1*t); % x1
x2 = A*cos(2*pi*f2*t); % x2
x = x1 + x2; % Sum of the sinusoids x

An = 0.01; % Amplitude
fs = 8000; % Sampling frequency

n = An .* randn(1, length(0 : 1/ fs: 2)); % n

s = x + n; % s

s2 = downsample(s,2); % s2
S2 = dtft(s2, -4000, 4000, ww);
figure(1)
plot(ww, abs(S2))
title("Magnitude of the DTFT of s2")
xlabel('w / rad')
ylabel('A')

s3 = upsample(s2,2); % y
S3 = dtft(s3, -8000, 8001, ww);
figure(2)
plot(ww, abs(S3))
title("Magnitude of the DTFT of y")
xlabel('w / rad')
ylabel('A')
%%
SS3 = fft(s3);
figure(3)
plot([-8000:8001], abs(SS3))
title("Magnitude of the FFT of y")

%% Filter
% hlpf = lpf(pi/2,50); % low pass filter
% y = conv(hlpf,s); % convolution

y(1) = (s(1) + s(2))/ 2;
for i = 2: length(s)-1
    y(i) = (s(i-1)+s(i)+s(i+1))/3; % Moving Average filter
end

y(length(s)) = (s(length(s)-1) + s(length(s)))/ 2;

% soundsc(s, 8000);
% soundsc(y, 8000);

% %% DTFT
% S = dtft(s, -8000, 8000, ww);
% figure(4)
% plot(ww, abs(S));
% title("Magnitude of the DTFT of s")
% xlabel('w / rad')
% ylabel('A')

%% Freqz
[hs,ws] = freqz(s,1,8000);
[hy,wy] = freqz(y,1,8000);
figure(5)
plot(ws/2/pi*fs,abs(hs));
hold on
plot(wy/2/pi*fs,abs(hy));
title("Magnitude of the DTFT of s and y")
legend('s','y')
xlabel('w / rad')
ylabel('A')


%% 
figure(6)
plot(ws/2/pi*fs,20*log(abs(hs')));
title("freqz of s")
xlabel('w / rad')
ylabel('dB')

figure(7)
plot(wy/2/pi*fs,20*log(abs(hy')));
title("freqz of y")
xlabel('w / rad')
ylabel('dB')
