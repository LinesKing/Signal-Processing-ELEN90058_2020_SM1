%% %%Compare Group Delay%% %%

clear all
close all
clc

%% Question 1. IIR
GdB = [-30,-20,0,-10,3,20.5];
fc = [125, 250, 500, 1000, 2000, 4000];
fs = 16000;

Hd1 = LowShelvingFilter(GdB(1),fc(1),fs);
%four PeakNotchFilter
Hd2 = PeakNotchFilter(GdB(2),fc(2),fs);
Hd3 = PeakNotchFilter(GdB(3),fc(3),fs);
Hd4 = PeakNotchFilter(GdB(4),fc(4),fs);
Hd5 = PeakNotchFilter(GdB(5),fc(5),fs);
%one HighShelvingFilter
Hd6 = HighShelvingFilter(GdB(6),fc(6),fs);

CascadeIIR = dsp.FilterCascade(Hd1,Hd2,Hd3,Hd4,Hd5,Hd6);
r1 = latencyIIR(CascadeIIR);

%% Question 2. IIR
GdB1 = [-30,-20,0,-10,3,20.5];
GdB2 = [0,0,0,0,60,0];
fc = [125, 250, 500, 1000, 2000, 4000];
fs = 16000;

Hd1 = LowShelvingFilter(GdB1(1),fc(1),fs);
%four PeakNotchFilter
Hd2 = PeakNotchFilter(GdB1(2),fc(2),fs);
Hd3 = PeakNotchFilter(GdB1(3),fc(3),fs);
Hd4 = PeakNotchFilter(GdB1(4),fc(4),fs);
Hd5 = PeakNotchFilter(GdB1(5),fc(5),fs);
%one HighShelvingFilter
Hd6 = HighShelvingFilter(GdB1(6),fc(6),fs);

CascadeIIR1 = dsp.FilterCascade(Hd1,Hd2,Hd3,Hd4,Hd5,Hd6);

Hd1 = LowShelvingFilter(GdB2(1),fc(1),fs);
%four PeakNotchFilter
Hd2 = PeakNotchFilter(GdB2(2),fc(2),fs);
Hd3 = PeakNotchFilter(GdB2(3),fc(3),fs);
Hd4 = PeakNotchFilter(GdB2(4),fc(4),fs);
Hd5 = PeakNotchFilter(GdB2(5),fc(5),fs);
%one HighShelvingFilter
Hd6 = HighShelvingFilter(GdB2(6),fc(6),fs);

CascadeIIR2 = dsp.FilterCascade(Hd1,Hd2,Hd3,Hd4,Hd5,Hd6);

fvtool(CascadeIIR1);
fvtool(CascadeIIR2);

% [H,w] = freqz(CascadeIIR1);
% theta = unwrap(angle(H));
% group_delay1 = -diff(theta(2:length(theta)))./diff(w(2:length(w)));
% average_delay1 = mean(group_delay1)


%% Question 3. & 4. FIR
N = 30;
fs = 16000;
GdB = [-30,-30,-20,-10,-10,0,15,15];
fpts = [0, 1/64, 1/32, 1/16, 1/8, 1/4, 1/2, 1];
mval = db2mag(GdB);
multibandFIR = fir2(N,fpts, mval);

r2 = latencyFIR(multibandFIR,1);
fvtool(multibandFIR);






