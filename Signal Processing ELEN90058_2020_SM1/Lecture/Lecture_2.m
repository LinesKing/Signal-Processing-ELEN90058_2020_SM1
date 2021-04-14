clear all
close all
clc

%% Sinusoid
k = 1:256;
x = cos(2*pi*0.01*k);
%plot(x);

%% Noise
n = randn(1,256);
%plot(n);

%% Our signal
s = x + 0.1*n;
plot(s);
hold on

%% Filter 1
for i=2:255
y1(i) = 1/3*(s(i-1)+s(i)+s(i+1));
end
plot(y1);
hold on

%% Filter 2
for i=2:255
y2(i) = 1/4*(s(i-1)+2*s(i)+s(i+1));
end
plot(y2);
hold on

%% Filter 3
for i=4:253
y3(i) = 1/5*(s(i-2)+s(i-1)+s(i)+s(i+1)+s(i+2));
end
plot(y3);
hold on

legend('origin','y1','y2','y3')