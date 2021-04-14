%% %%Anti-Aliasing%% %%

clear all
close all
clc

%% Implementing the filter
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
soundsc(s2, 8000);

y(1) = (s2(1) + s2(2))/ 2;
for i = 2: length(s2)-1
    y(i) = (s2(i-1)+s2(i)+s2(i+1))/3; % Moving Average filter
end

y(length(s2)) = (s2(length(s2)-1) + s2(length(s2)))/ 2;
soundsc(y, 8000);

%% Implementing another filter 
y = zeros(8,8001);
i = 1;
for k = 3: 2: 17
    y(i,:) = movmean(s2,k); % Moving Average filter
    h = fft(y(i,:));
    figure(1)
    subplot(4,2,i)
    plot(-4000:4000,abs(h));
    legend(num2str(i))
    xlabel('f / Hz')
    ylabel('A')
    i = i + 1;
end
sgtitle('Magnitude of the FFT when using different d')

soundsc(y(8,:), 8000);

%% Decimation again
s4 = downsample(s,4);
soundsc(s4, 8000);

S = fft(s); % Compute DFT of s
ms = abs(S); % Magnitude
fss = 0:fs/(length(s)-1):fs; % Frequency vector

S4 = fft(s4); % Compute DFT of y
ms4 = abs(S4); % Magnitude
fs4 = 0:fs/(length(s4)-1):fs; % Frequency vector
figure(2)
plot(fs4 - fs/2,fftshift(ms4)); % Shift the spectrum to origin
hold on
plot(fss - fs/2,fftshift(ms)); % Shift the spectrum to origin
title("Magnitude of the FFT of s4 and s")
legend('s4','s')
xlabel('f / Hz')
ylabel('A')
figure(2)

