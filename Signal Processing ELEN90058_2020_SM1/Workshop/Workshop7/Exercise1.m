%% %%Group Delay%% %%

clear all
close all
clc

%% Q1
b = 0.136728736 * [1 0 -1];
a = [1 -0.53353098 0.726542528];
[H,w] = freqz(b,a);
theta = unwrap(angle(H));
group_delay = -diff(theta(2:length(theta)))./diff(w(2:length(w)));
gd = grpdelay(b,a,length(w));

figure(1)
plot(w(2:length(w)-1)/pi,group_delay);
hold on
plot(w/pi,gd);

title('Group delay with normalised frequency')
legend('diff','grpdelay')
xlabel('Normalized Frequency (\times\pi rad/sample)')
ylabel('Group delay (samples)')
grid on

average_delay = mean(gd)
peak_delay = max(gd)

%% Q2
b = 0.136728736 * [1 0 -1];
a = [1 -0.53353098 0.726542528];
fs = 16000;
[H,w] = freqz(b,a,fs,fs);

figure(2)
grpdelay(b,a,fs,fs);

average_delay = mean(gd)/fs*1000

%% Q4
w = -2*pi:0.01:2*pi;

M1 = 5;
H1 = (1/M1)*sin(M1*w/2)./sin(w/2);
theta1 = -(M1-1)*w/2;
HH1 = H1.*exp(1j.*theta1);

M2 = 14;
H2 = (1/M2)*sin(M2*w/2)./sin(w/2);
theta2 = -(M2-1)*w/2;
HH2 = H2.*exp(1j.*theta2);

figure(3)
plot(w, mag2db(abs(HH1)));
hold on
plot(w, mag2db(abs(HH2)));
title('The magnitude response of the moving average filter for M = 5 and M = 14')
legend('M = 5','M = 14')
xlabel('w')
ylabel('magnitude')
grid on


figure(4)
plot(w, unwrap(angle(HH1)));
hold on
plot(w, unwrap(angle(HH2)));
title('The phase response of the moving average filter for M = 5 and M = 14')
legend('M = 5','M = 14')
xlabel('w')
ylabel('phase')
grid on

%% Q6
w = -2*pi:0.01:2*pi;

M1 = 5;
H1 = (1/M1)*sin(M1*w/2)./sin(w/2);
theta1 = -(M1-1)*w/2;
HH1 = H1.*exp(1i.*theta1);
theta1 = unwrap(angle(HH1));
group_delay1 = -diff(theta1(2:length(theta1)))./diff(w(2:length(w)));

M2 = 14;
H2 = (1/M2)*sin(M2*w/2)./sin(w/2);
theta2 = -(M2-1)*w/2;
HH2 = H2.*exp(1i.*theta2);
theta2 = unwrap(angle(HH2));
group_delay2 = -diff(theta2(2:length(theta2)))./diff(w(2:length(w)));

figure(5)
plot(w(2:length(w)-1)/2/pi,group_delay1);
hold on
plot(w(2:length(w)-1)/2/pi,group_delay2);
title('Group delay with normalised frequency')
legend('M = 5','M = 14')
axis([0 1 -350 350])
xlabel('Normalized Frequency (\times\pi rad/sample)')
ylabel('Group delay (samples)')
grid on

average_delay = [mode(group_delay1) mode(group_delay2)]
peak_delay = [max(group_delay1) max(group_delay2)]

%% Q8
rng default

x = triang(20);
% y = [zeros(3,1);x] + 0.3*randn(length(x)+3,1);
% [r,lags] = xcorr(y,x);

M1 = 4;
% Movm1 = movmean(x,M1);
Movm1 = filter(ones(1,M1),1,x)/M1;
[r1,lags1] = xcorr(Movm1,x);

M2 = 10;
% Movm2 = movmean(x,M2);
Movm2 = filter(ones(1,M2),1,x)/M2;
[r2,lags2] = xcorr(Movm2,x);

figure(6)
stem(lags1,r1);
hold on
stem(lags2,r2);

title('Cross-correlation')
legend('M = 4','M = 10')
xlabel('lags')
ylabel('cross-correlation')
grid on

