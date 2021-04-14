%% %%Delays and Echoes%% %%

clear all
close all
clc

%% Delays and Echoes
% Q4
figure(1)
freqz ([1 0 0 0 1],[1],'whole');
title('freqz when D = 4');

fs = 8000;
[h1,w1] = freqz ([1 zeros(1,49) 1],[1],'whole',fs);
[h2,w2] = freqz ([1 zeros(1,99) 1],[1],'whole',fs);
figure(2)
plot(w1,20*log10(abs(h1)));
% plot(w1/2/pi*fs,20*log(abs(h1)));
% plot(w1*fs,20*log(abs(h1)));
hold on
plot(w2,20*log10(abs(h2)));
% plot(w2/2/pi*fs,20*log(abs(h2)));
% plot(w2*fs,20*log(abs(h2)));

xlim([0 0.1*pi])
ylim([-30 10])

title('freqz rad/samples');

legend('D = 50','D = 100')