%% %%The Chorus Filter and System Objects%% %%

clear all
close all
clc

%% Another chorus filter
fs = 8000;
[h1,w1] = freqz ([1 zeros(1,49) 1 zeros(1,49) 1],[1],'whole',fs);
figure(1)
plot(w1,20*log10(abs(h1)));
xlim([0 0.1*pi])
ylim([-30 10])

title('freqz rad/samples D = 50');

%% The Chorus Filter
Fs = 8000; % Sampling frequency in [Hz]
% n = 0:5*Fs-1; % [sec]
% w = pi/Fs;
% a1 = 0.7; % alpha
% a2 = 0.7;
% D1 = 200;
% D2 = 200;
% dn1 = round(D1*(1-cos(w*n)));
% dn2 = round(D2*(1+cos(w*n)));

[x,Fs]=audioread('SpeechDFT-16-8-mono-5secs.wav');

% for i=1:length(x)
%     y(i) = x(i) + a1*x(i-dn1(i)) + a2*x(i-dn2(i));
% end

Chorus = chorus();
y = Chorus(x);

figure(2)
plot(x);
title('speech waveform before Choursing')
xlabel('Samples')
ylabel('Magnitude')
figure(3)
plot(y);
title('Choursing of speech waveform')
xlabel('Samples')
ylabel('Magnitude')