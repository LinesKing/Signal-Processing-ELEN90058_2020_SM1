%% %%The Flanging Filter and System Objects%% %%

clear all
close all
clc

%% Building an Audio Signal Processing Pipeline
% fileReader = dsp.AudioFileReader("Filename", "SpeechDFT-16-8-mono-5secs.wav");
% deviceWriter = audioDeviceWriter('SampleRate', fileReader.SampleRate);
% 
% reverb = reverberator ( ...
%   'SampleRate',fileReader.SampleRate, ...
%   'PreDelay',0.5, ...
%   'WetDryMix',0.4);
% 
% while ~isDone(fileReader)
%     audio_in = fileReader() ;
%     audio_out = reverb(audio_in);
%     deviceWriter(audio_out);
% end
% 
% pause(1);
% release(fileReader)
% release(deviceWriter)
% release(reverb)

%% The Flanging Filter
Fs = 8000; % Sampling frequency in [Hz]
% n = 0:5*Fs-1; % [sec]
% w = pi/Fs;
% a = 0.7; % alpha
% D = 80;
% dn = round(D*(1-cos(w*n)));
% x = randn(size(n));%creating white noise signal
[x,Fs]=audioread('SpeechDFT-16-8-mono-5secs.wav');
% x is the audio signal and fs is the sampling frequency
% Implementing the Flanging Filter

% for i=1:length(x)
%     y(i) = x(i) + a*x(i-dn(i));
% end

Flanger = flanger();
y = Flanger(x);

% Xw = fft(x); % Compute DFT of xn
% mxw = abs(Xw); % Magnitude
% fxn = 0:Fs/(length(mxw)-1):Fs; % Frequency vector
% 
% figure(1)
% plot(fxn-Fs/2,fftshift(mxw)); % Shift the spectrum to origin
% title("Xw")
% xlabel('f/Hz')
% ylabel('A')

sound(y)







