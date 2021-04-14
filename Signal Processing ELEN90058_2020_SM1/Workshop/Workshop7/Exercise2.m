%% %%FIR Design%% %%

clear all
close all
clc

%% Q1
c = 1/2;
n = -25:25;
hlp = c*sinc(c*n);
figure(1)
stem(n,hlp)
% fvtool(hlp,1)
title('Impose response')
xlabel('n')
ylabel('hLP')
grid on

%% Q2
L = 51;
ww = -pi: 0.0001: pi;

w1 = blackman(L);
w2 = hamming(L);
w3 = hann(L);
hlp_blackman = hlp.*w1';
hlp_hamming = hlp.*w2';
hlp_hann = hlp.*w3';

% Hlp_blackman = dtft(hlp_blackman, -25, 25, ww);
% Hlp_hamming = dtft(hlp_hamming, -25, 25, ww);
% Hlp_hann = dtft(hlp_hann, -25, 25, ww);
% 
% figure(2)
% plot(ww, mag2db(abs(Hlp_blackman)))
% title("Magnitude of the DTFT of Hlp_blackman")
% xlabel('w / rad')
% ylabel('A')

fvtool(hlp_blackman,1,hlp_hamming,1,hlp_hann,1)
legend('blackman','hamming','hann')

%% Q3
Ws = 16;
Wpass = 3/Ws*2*pi; 
Wstop = 5/Ws*2*pi;
Wc = (Wpass + Wstop)/2;
dW = Wstop - Wpass;
Ap = 0.2;
Ast = 40;
WW = [5.56*pi 3.32*pi 3.11*pi];

for i = 1:3
    M(i) = round(WW(i)/dW);
    N(i) = 2*M(i)+1;
end

n1 = -M(1):M(1);
n2 = -M(2):M(2);
n3 = -M(3):M(3);

hlp1 = (Wc/pi)*sinc(Wc*n1/pi);
hlp2 = (Wc/pi)*sinc(Wc*n2/pi);
hlp3 = (Wc/pi)*sinc(Wc*n3/pi);

win1 = blackman(N(1))';
win2 = hamming(N(2))';
win3 = hann(N(3))';

hlp_blackman = hlp1.*win1;
hlp_hamming = hlp2.*win2;
hlp_hann = hlp3.*win3;

% designSpecs = fdesign.lowpass('Fp,Fst,Ap,Ast',Fpass,Fstop,Ap,Ast);
     
% hlp = designfilt('lowpassfir','PassbandFrequency',Fpass,...
%   'StopbandFrequency',Fstop,'PassbandRipple',Ap,'StopbandAttenuation',Ast);
% fvtool(hlp)

figure(2)
stem(n1,hlp_blackman)
hold on
stem(n2,hlp_hamming)
hold on
stem(n3,hlp_hann)
title('Impulse responses')
legend('blackman','hamming','hann')
xlabel('n')
ylabel('meg')
grid on

fvtool(hlp_blackman,1,hlp_hamming,1,hlp_hann,1)
legend('blackman','hamming','hann')

%% Q4
w1 = blackman(N(1)+1)';
w2 = hamming(N(2)+1)';
w3 = hann(N(3)+1)';
wn = 4/8;
hlp_blackman = fir1(N(1),wn,'low',w1);
hlp_hamming = fir1(N(2),wn,'low',w2);
hlp_hann = fir1(N(3),wn,'low',w3);

figure(3)
stem((-N(1)/2:N(1)/2),hlp_blackman)
hold on
stem((-N(2)/2:N(2)/2),hlp_hamming)
hold on
stem((-N(3)/2:N(3)/2),hlp_hann)
title('Impulse responses')
legend('blackman','hamming','hann')
xlabel('n')
ylabel('meg')
grid on

fvtool(hlp_blackman,1,hlp_hamming,1,hlp_hann,1)
legend('blackman','hamming','hann')

%% Q5
Ws = 16;
Wpass = 3/Ws*2*pi; 
Wstop = 5/Ws*2*pi;
Wc = (Wpass + Wstop)/2;
dW = Wstop - Wpass;
WW = [5.56*pi 3.32*pi 3.11*pi];

for i = 1:3
    M(i) = round(WW(i)/dW);
    N(i) = 2*M(i)+1;
end

w1 = blackman(N(1)+1)';
w2 = hamming(N(2)+1)';
w3 = hann(N(3)+1)';
hlp_blackman = fir1(N(1),Wc/pi,'low',w1);
hlp_hamming = fir1(N(2),Wc/pi,'low',w2);
hlp_hann = fir1(N(3),Wc/pi,'low',w3);

% figure(4)
% stem((-N(1)/2:N(1)/2),hlp_blackman)
% hold on
% stem((-N(2)/2:N(2)/2),hlp_hamming)
% hold on
% stem((-N(3)/2:N(3)/2),hlp_hann)
% title('Impulse responses')
% legend('blackman','hamming','hann')
% xlabel('n')
% ylabel('meg')
% grid on

% fvtool(hlp_blackman,1,hlp_hamming,1,hlp_hann,1)
% legend('blackman','hamming','hann')

[h1, w1] = freqz(hlp_blackman,1,512,2*pi/0.75);
[h2, w2] = freqz(hlp_hamming,1,512,2*pi/0.75);
[h3, w3] = freqz(hlp_hann,1,512,2*pi/0.75);
plot(w1/pi, 20*log10(abs(h1)));
hold on
plot(w2/pi, 20*log10(abs(h2)));
hold on
plot(w3/pi, 20*log10(abs(h3)));
grid;
xlabel('\omega/\pi'); 
ylabel('Gain, in dB');
title('Lowpass filter designed using each window');
legend('blackman','hamming','hann')
xlim([0 1])

%% Q6
N = 30;
fs = 16000;
GdB = [-30,-30,-20,-10,-10,0,15,15];
fpts = [0, 1/64, 1/32, 1/16, 1/8, 1/4, 1/2, 1];
mval = db2mag(GdB);
B = fir2(N,fpts, mval);

fvtool(B)

[x_in,fs] = audioread('speech_wideband_16k.wav');

multiband_fir = dsp.FIRFilter(B);
audio_frame_filtered = multiband_fir(x_in);
audiowrite('speech_wideband_16k_filtered.wav',audio_frame_filtered,fs)

compareResponse('speech_wideband_16k_filtered.wav')

%% Q7
N = 30;
fs = 16000;
GdB = [-30,-30,-20,-10,-10,0,15,15];
mval = db2mag(GdB);
fpts = [0, 1/64, 1/32, 1/16, 1/8, 1/4, 1/2, 1];
for i = 2:7
    B = fir2(N,[fpts(1),fpts(i),fpts(8)], [mval(1),mval(i),mval(8)]);
    gda(i-1) = mean(grpdelay(B,1,512));
end

