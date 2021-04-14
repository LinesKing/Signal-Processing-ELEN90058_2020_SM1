function compareResponse(filename)
%CREATEFIGURE(X1, Y1, X2, YMatrix1)
%  X1:  vector of x data
%  Y1:  vector of y data
%  X2:  vector of x data
%  YMATRIX1:  matrix of y data
X2 = [125, 250, 500, 1000, 2000, 4000, 8000];
YMatrix1 = [-48, -48, -48, -45, -45, -45, -45; -38, -38, -38, -35, -35, -35, -35];
%  Auto-generated by MATLAB on 26-Apr-2020 12:36:22

[xin, fs] = audioread('speech_wideband_16k.wav');
[x_in,fs] = audioread(filename);

nfft= 32; % length of the fft
noverlap= nfft/2; % number of overlapping time samples
window= hanning(nfft); % window function
[pxx_in,X1]= pwelch(x_in,window,noverlap,nfft,fs);  % W/Hz  PSD
Y1= 10*log10(pxx_in*fs/nfft); % dBW/bin

nfft= 32; % length of the fft
noverlap= nfft/2; % number of overlapping time samples
window= hanning(nfft); % window function
[pxx_in,X3]= pwelch(xin,window,noverlap,nfft,fs);  % W/Hz  PSD
Y3= 10*log10(pxx_in*fs/nfft); % dBW/bin

% Create figure
figure1 = figure;

% Create axes
axes1 = axes('Parent',figure1);
hold(axes1,'on');

% Create semilogx
semilogx(X1,Y1);
semilogx(X3,Y3);

% Create multiple lines using matrix input to semilogx
semilogx1 = semilogx(X2,YMatrix1,'LineWidth',2,'Color',[0 1 0]);

% The following line demonstrates an alternative way to create a data tip.
% datatip(semilogx1(1),1000,-45);
% Create datatip
datatip(semilogx1(1),'DataIndex',4);

% Create ylabel
ylabel('Power/Frequency (dB/Hz)');

% Create xlabel
xlabel('Frequency (Hz)');

box(axes1,'on');
grid(axes1,'on');
% Set the remaining axes properties
set(axes1,'XMinorTick','on','XScale','log');

legend('filtered signal','original signal')

% sound(x_in)
