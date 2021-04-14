%% %%IIR filter design using Matlab%% %%

clear all
close all
clc

%% Butterworth Lowpass Filter
% Q1
N = [2 3 10];
W = 0:0.01*pi:pi;
Wc = 0.6*pi;

for i = 1:3
    figure(i);
    Ha = sqrt(1./(1+(W/Wc).^(2*N(i))));
    plot(W,abs(Ha));
    title(sprintf('N = %i, Wc = 0.6*pi',N(i)))
    xlabel('W')
    ylabel('Magnitude')
    grid on
end

%% Designing IIR Filters in Matlab
% Q4
fs = 48000;
omp = 40/(fs/2);
oms = 50/(fs/2);
ap = 20*log10(1/(1-0.05));
as = 20*log10(1/0.05);

[N, Wn]= buttord(omp , oms , ap , as);

% Q5
[b, a]= butter(N,Wn);
figure(4)
freqz(b,a);

% Q6
figure(5)
[z,p,k]= butter(N,Wn);
[s,g]= zp2sos(z,p,k);
zplane(b,a);
flag = isstable(b,a);

% Q7
lpf = dfilt.df2sos(s,g);

% Q8
fvtool(b,a,lpf);

