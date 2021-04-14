%% %%Parallel Graphic Equaliser%% %%


clear all
close all
clc

% Band 1
Fs = 16000;
Wp = 125/8000;
Ws = 177/8000;
Rp = 20*log10(1/(1-0.05));
Rs = 20*log10(1/0.5);
[N,Wn] = buttord (Wp ,Ws ,Rp ,Rs)
[z,p,k] = butter (N,Wn);
sos = zp2sos (z,p,k);
lpf = sos2tf(sos);
figure()
freqz (sos,512,16000)
title (sprintf('n = %d Butterworth Lowpass Filter',N))

%band2
Wp = [230 270]/8000;
Ws = [177 355]/8000;
Rp = 20*log10 (1/(1-0.05));
Rs = 20*log10 (1/0.5);
[N,Wn] = buttord (Wp ,Ws ,Rp ,Rs)
[z,p,k] = butter (N,Wn);
sos = zp2sos (z,p,k);
bpf1 = sos2tf(sos);
figure()
freqz (sos,512,16000)
title (sprintf('n = %d Butterworth Bandpass Filter',N))

% Q1
%band3
Wp = [460 540]/8000;
Ws = [355 710]/8000;
Rp = 20*log10 (1/(1-0.05));
Rs = 20*log10 (1/0.5);
[N,Wn] = buttord (Wp ,Ws ,Rp ,Rs)
[z,p,k] = butter (N,Wn);
sos = zp2sos (z,p,k);
bpf2 = sos2tf(sos);
figure()
freqz (sos,512,16000)
title (sprintf('n = %d Butterworth Bandpass Filter',N))

%band4
Wp = [850 1150]/8000;
Ws = [710 1420]/8000;
Rp = 20*log10 (1/(1-0.05));
Rs = 20*log10 (1/0.5);
[N,Wn] = buttord (Wp ,Ws ,Rp ,Rs)
[z,p,k] = butter (N,Wn);
sos = zp2sos (z,p,k);
bpf3 = sos2tf(sos);
figure()
freqz (sos,512,16000)
title (sprintf('n = %d Butterworth Bandpass Filter',N))

%band5
Wp = [1650 2350]/8000;
Ws = [1420 2840]/8000;
Rp = 20*log10 (1/(1-0.05));
Rs = 20*log10 (1/0.5);
[N,Wn] = buttord (Wp ,Ws ,Rp ,Rs)
[z,p,k] = butter (N,Wn);
sos = zp2sos (z,p,k);
bpf4 = sos2tf(sos);
figure()
freqz (sos,512,16000)
title (sprintf('n = %d Butterworth Bandpass Filter',N))

%band6
Wp = 4000/8000;
Ws = 2840/8000;
Rp = 20*log10 (1/(1-0.05));
Rs = 20*log10 (1/0.5);
[N,Wn] = buttord (Wp ,Ws ,Rp ,Rs)
[z,p,k] = butter (N,Wn,'high');
sos = zp2sos (z,p,k);
hpf = sos2tf(sos);
figure()
freqz (sos,512,16000)
title (sprintf('n = %d Butterworth Highpass Filter',N))

Hpara = dfilt.parallel(lpf,bpf1,bpf2,bpf3,bpf4,hpf);
fvtool(Hpara)
