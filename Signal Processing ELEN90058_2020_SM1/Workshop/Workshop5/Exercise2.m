%% %%Cascade Graphic Equalisers%% %%

clear all
close all
clc

%% Magnitude Response
% Q3
fs = 48000;
fc = [1000 10000];
GdB = [12 -12];
G = 10.^(GdB/20);
wc = 2*pi*fc/fs;
B = wc/sqrt(2);
t = tan(B/2);
figure(1)
for i =1:2
    for j =1:2
        num = [G(i)*t(j)+sqrt(G(i)) -2*sqrt(G(i))*cos(wc(j)) sqrt(G(i))-G(i)*t(j)];
        den = [t(j)+sqrt(G(i)) -2*sqrt(G(i))*cos(wc(j)) sqrt(G(i))-t(j)];
        [h,w] = freqz(num,den,fs);
        semilogx(w/2/pi*fs,20*log10(abs(h)));
        hold on
    end
end
grid on
xlabel('f / Hz');
ylabel('A / dB');
legend('G = 12 dB, fc = 1 kHz','G = 12 dB, fc = 10 kHz','G = -12 dB, fc = 1 kHz','G = -12 dB, fc = 10 kHz')

%% A Wideband Telephony Speech Equaliser
% G = 10^(12/20) ;
% fs = 16000;
% fc = 1000;
% wc = 2* pi*fc/fs;
% b = [G*tan(wc/2)+sqrt(G) G*tan(wc/2)-sqrt(G)];
% a = [tan(wc/2)+sqrt(G) tan(wc/2)-sqrt(G)];

%% A Wideband Telephony Speech Equaliser
GdB = [-30,-20,0,-10,3,20.5];
fc = [125, 250, 500, 1000, 2000, 4000];
fs = 16000;

[x_in,fs] = audioread('speech_wideband_16k.wav');

dataIn = x_in;

%one LowShelvingFilter
Hd = LowShelvingFilter(GdB(1),fc(1),fs);
Numerator(1,:) = [Hd.Numerator 0];
Denominator(1,:) = [Hd.Denominator 0];
dataOut = filter(Hd.Numerator,Hd.Denominator,dataIn);
dataIn = dataOut;

%four PeakNotchFilter
for i =2:5
    Hd = PeakNotchFilter(GdB(i),fc(i),fs);
    Numerator(i,:) = Hd.Numerator;
    Denominator(i,:) = Hd.Denominator;
    dataOut = filter(Hd.Numerator,Hd.Denominator,dataIn);
    dataIn = dataOut;
end

%one HighShelvingFilter
Hd = HighShelvingFilter(GdB(6),fc(6),fs);
Numerator(6,:) = [Hd.Numerator 0];
Denominator(6,:) = [Hd.Denominator 0];
dataOut = filter(Hd.Numerator,Hd.Denominator,dataIn);

audiowrite('speech_wideband_16k_filtered.wav',dataOut,fs)

compareResponse('speech_wideband_16k_filtered.wav')




