%% %%Parametric Equalisers%% %%

clear all
close all
clc

%% First Order Low-Frequency Shelving Filter
% Q5
G = 0.5;
p = [0.3 0.5 0.7 1];
for i =1:4
    num = sqrt(G) * [1 p(i)];
    den = [1 -p(i)];
    figure(i)
    freqz(num,den);
    title(sprintf('G = %.1f, p = %.1f', G, p(i)))
end


%% Spectral Transformations
% Q11
fs = 48000;
fc = 1000;
GdB = [12 -12 8 -8 4 -4];
G = 10.^(GdB/20);
wc = 2*pi*fc/fs;
t = tan(wc/2);
for i =1:6
    num = [G(i)*t+sqrt(G(i)) G(i)*t-sqrt(G(i))];
    den = [t+sqrt(G(i)) t-sqrt(G(i))];
    [h,w] = freqz(num,den,fs);
    figure(i+4)
    plot(w/2/pi*fs/1000,20*log10(abs(h)));
    title(sprintf('G = %d dB', GdB(i)))
    grid on
    xlabel('f / kHz')
    ylabel('A / dB')
end