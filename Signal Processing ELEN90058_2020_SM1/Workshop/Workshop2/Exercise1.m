%% %%Changing the Sampling Rate%% %%

clear all
close all
clc

%% Gererate a pair of sinusoid x1 and x2
A = 0.1; % Amplitude
f1 = 697; % x1 frequency
f2 = 1209; % x2 frequency
fs = 8000; % Sampling frequency
t = [0 : 1/ fs: 2 ]; % [ start : step : end ]

x1 = A*cos(2*pi*f1*t); % x1
x2 = A*cos(2*pi*f2*t); % x2
x = x1 + x2; % Sum of the sinusoids x

soundsc(x, fs);

%% Gererate a Gaussian white noise
An = 0.01; % Amplitude
fs = 8000; % Sampling frequency

n = An .* randn(1, length(0 : 1/ fs: 2)); % n

soundsc(n, fs);

%% Signal Construction
s = x + n; % s

soundsc(s, fs);

%% Downsampling
s2 = downsample(s,2); % s2

soundsc(s2, fs);

S2 = fft(s2); % Compute DFT of s2
ms2 = abs(S2); % Magnitude
fs2 = 0:fs/(length(s2)-1):fs; % Frequency vector

S = fft(s); % Compute DFT of s
ms = abs(S); % Magnitude
fss = 0:fs/(length(s)-1):fs; % Frequency vector

figure(1)
plot(fs2 - fs/2,fftshift(ms2)); % Shift the spectrum to origin
hold on
plot(fss - fs/2,fftshift(ms)); % Shift the spectrum to origin
title("Magnitude of the FFT of s2 and s")
legend('s2','s')
xlabel('f / Hz')
ylabel('A')

%% Upsampling
y = upsample(s2,2); % y

soundsc(y, fs);

Y = fft(y); % Compute DFT of y
my = abs(Y); % Magnitude
fy = 0:fs/(length(y)-1):fs; % Frequency vector
hold on
plot(fss - fs/2,fftshift(ms)); % Shift the spectrum to origin
title("Magnitude of the FFT of y and s")
legend('y','s')
xlabel('f / Hz')
ylabel('A')
figure(2)
plot(fy - fs/2,fftshift(my)); % Shift the spectrum to origin


%% Generate a sinusoid
An = 0.1; % Amplitude
f1 = [697 770 852 941 1209 1336 1477]; % x1 frequency: 697 Hz, 770 Hz, 852 Hz, 941 Hz, 1209 Hz, 1336 Hz, 1477Hz
fs = 2000; % Sampling frequency
t = [0 : 1/ fs: 2 ]; % [ start : step : end ]

figure(3)
for i = 1: 7
    xx(i,:) = An*cos(2*pi*f1(i)*t); % xx
    XX = fft(xx(i,:));
    fxx = 0:fs/(length(xx(i,:))-1):fs;
    subplot(4,2,i)
    plot(fxx - fs/2,fftshift(abs(XX)));
    legend(num2str(f1(i)))
    xlabel('f / Hz')
    ylabel('A')
end   
sgtitle('Magnitude of the FFT when using frequencies in DTMF(Hz)')
soundsc(xx(i,:), fs);


