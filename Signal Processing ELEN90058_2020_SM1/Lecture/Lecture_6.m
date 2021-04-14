clear all
close all
clc

%% 
k = -50: 50;
t = -50: 0.01: 50;
h = -100: 101;
a = 0.01;
w = 2*pi*0.2;

pt = exp(-a*t.^2);
pk = exp(-a*k.^2);

xt = pt .* cos(w*t);
xk = pk .* cos(w*k);

yk = reshape([xk;zeros(size(xk))],1,[]);

hlpf = lpf(pi/2,50);
z = conv(hlpf,yk);

%%
figure(1)
plot(t,xt);
hold on;
plot(k,xk,'.');

%% 
figure(2)
plot(h,yk);
hold on
plot(h,yk,".")
axis([-50 50 -1 1]);

%%
figure(3)
plot(-150: 151,z);
hold on;
plot(-150: 151,z,".");

%%
figure(4)
plot(2*t,xt);
hold on;
plot(-150: 151,2*z,'.');
axis([-50 50 -1 1]);

%% DTFT
ww = -0.05: 0.0001: 0.05;
Xt = dtft(xt, -5000, 5000, ww);
figure(5)
plot(ww, abs(Xt))
title("Magnitude of the DTFT of x(t) Sampled at 100 Hz")

ww = -pi: 0.01: pi;
Xk = dtft(xk, -50, 50, ww);
figure(6)
plot(ww, abs(Xk))
title("Magnitude of the DTFT of x(k)")

Yk = dtft(yk, -100, 101, ww);
figure(7)
plot(ww, abs(Yk))
title("Magnitude of the DTFT of y(k)")

Z = dtft(z, -150, 151, ww);
figure(8)
plot(ww, abs(Z))
title("Magnitude of the DTFT of z(k)")







