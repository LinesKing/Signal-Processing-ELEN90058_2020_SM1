%% %%Digital anti-aliasing filters%% %%

clear all
close all
clc

%% Our signal in the continuous domain
% Q2
w1 = 0.25*pi; % xn frequency
t = 0:0.5:50;
i = 1;
figure(1);
for a = 0.1:0.1:0.5 % Decaying factor
    xn(i,:) = exp(-a*t).*cos(w1*t); % xn
    plot(t,xn(i,:))
    i = i+1;
    hold on
end
title("Changing a in continuous domain")
xlabel('t/s')
ylabel('x')
legend('a = 0.1','a = 0.2','a = 0.3','a = 0.4','a = 0.5');

a = 0.1; % Decaying factor
t = 0:0.5:50;
i = 1;
figure(2);
for w1 = 0.1*pi:0.1*pi:0.5*pi % xn frequency
    xn(i,:) = exp(-a*t).*cos(w1*t); % xn
    plot(t,xn(i,:))
    i = i+1;
    hold on
end
title("Changing Omega in continuous domain")
xlabel('t/s')
ylabel('x')
legend('Omega = 0.1*pi','Omega = 0.2*pi','Omega = 0.3*pi','Omega = 0.4*pi','Omega = 0.5*pi');



%% Plotting the signal in time and frequency
a = 0.12; % Decaying factor
w1 = 0.25*pi; % xn frequency
F = 4.8; % Sampling frequency
n = 0:200;

xn = exp(-a*(1/F)*n).*cos(w1*(1/F)*n); % xn

figure(3)
plot(n,xn,'.');
title("xn")
xlabel('t/s')
ylabel('xn')

% Q4
Xw = fft(xn,1024); % Compute DFT of xn
mxw = abs(Xw); % Magnitude
fxn = 0:F/(length(mxw)-1):F; % Frequency vector

figure(4)
plot(fxn-F/2,fftshift(mxw)); % Shift the spectrum to origin
title("Xw")
xlabel('f/Hz')
ylabel('A')

% Q5
[Xw,w]= freqz(xn,1,'whole');
Xww = abs(Xw);
fw = w/pi*F/2;
figure(5)
plot(fw,Xww);
% plot(fw-F/2,fftshift(Xww));
title("freqz of xn")
xlabel('f/Hz')
ylabel('A')

%% Digital Anti-Aliasing Filter Design
% Q6
a = 0.12; % Decaying factor
w1 = 0.25*pi; % xn frequency
F = 4.8; % Sampling frequency
k = 0:99;
aa = 0.9; % alpha
y(1) = 0;

% xn = exp(-a*(1/F)*k).*cos(w1*(1/F)*k); % xk
xn(1) = 1;
xn(2:100) = 0;
for i = 2:100
   y(i) =  aa*y(i-1) + (1-aa)/2*xn(i) + (1 - aa)/2*xn(i-1); % yk
end
figure(6)
plot(k,y);
title("y")
xlabel('t/s')
ylabel('y')

% Q7
[Xw,w]= freqz(xn,1,'whole');
Xww = abs(Xw);
fw = w/pi*F/2;

[Yw,w]= freqz(y,1,'whole');
Yww = abs(Yw);
fw = w/pi*F/2;

figure(7)
plot(fw-F/2,fftshift(Yww));
hold on
plot(fw-F/2,fftshift(Xww));
title("freqz of y and xk")
xlabel('f/Hz')
ylabel('A')
legend('y','xk')

% Q9
aa = -1:0.5:1; % alpha
w = -pi:0.001:pi;
figure(8)
for i = 1:length(aa)
    h(i,:) = (1-aa(i))*(1+exp(-j*w))/2./(1-aa(i)*exp(-j*w));
end
plot(w,abs(h));
title("Amplitude of h")
xlabel('w/rad')
ylabel('A')
legend('alpha = -1','alpha = -0.5','alpha = 0','alpha = 0.5','alpha = 1')


figure(9)
plot(w,angle(h)/pi*180);
title("Angle of h")
xlabel('w/rad')
ylabel('degree')
legend('alpha = -1','alpha = -0.5','alpha = 0','alpha = 0.5','alpha = 1')


% freqz(b,a,n);
% HH = abs(H);
% fw = w*F;
% figure(6)
% plot(fw-F/2,fftshift(HH));

%%
syms x real
F = 4.8;
w = 0.25*pi/F;
x = double(solve(abs((1-x)*(1+exp(-j*w))/2./(1-x*exp(-j*w))) == 0.95,x));
aa = x; % alpha
w = -pi:0.001:pi;
figure(10)
for i = 1:length(aa)
    H(i,:) = (1-aa(i))*(1+exp(-j*w))/2./(1-aa(i)*exp(-j*w));
end
plot(w,abs(H));
title("Amplitude of H")
xlabel('w/rad')
ylabel('A')
legend(num2str(x(1)),num2str(x(2)));
w = 1.9*pi/F;
HH = abs((1-x)*(1+exp(-j*w))/2./(1-x*exp(-j*w)))

%%
syms x real
F = 4.8;
w = 0.25*pi/F;
x = double(solve((abs((1-x)*(1+exp(-j*w))/2./(1-x*exp(-j*w))))^2 == 0.95,x));
aa = x; % alpha
w = -pi:0.001:pi;
figure(11)
for i = 1:length(aa)
    H(i,:) = ((1-aa(i))*(1+exp(-j*w))/2./(1-aa(i)*exp(-j*w))).^2;
end
plot(w,abs(H));
title("Amplitude of h")
xlabel('w/rad')
ylabel('A')
legend(num2str(x(1)),num2str(x(2)));
w = 1.9*pi/F;
HH = (abs((1-x)*(1+exp(-j*w))/2./(1-xn*exp(-j*w)))).^2



