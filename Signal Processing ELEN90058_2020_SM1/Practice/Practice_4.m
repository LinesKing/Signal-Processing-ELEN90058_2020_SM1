%% %%Phase and Group Delay%% %%

clear all
close all
clc

%% Q3(a)
b = conv([2 -1], [3 -1]);
a = [1];
figure(1)
freqz(b,a);

%% Q3(e)
b = conv([1 -2], [1 -3]);
a = [1];
figure(2)
freqz(b,a);

%% Q4(a)
x = randn(1,8);
h = randn(1,3);
y = conv(h,x)
% yy = ifft(fft([h zeros(1,5)]) .* fft(x))
yy = ifft(fft([h zeros(1,7)]) .* fft([x 0 0]))

%% Q5
x = @(t) exp ( -0.003*t.^2) .*cos (1.5*t);

t=0:0.01:50;
figure(3)
plot(t,x(t));

kk = 0:50;
xk = x(kk);
hold on; 
plot(kk ,xk ,"." ); 
hold off

% Slow but simple way 
yk = [xk(1)]% y[0]

for k=1:50 
    yk = [yk 0.5*yk(end)+xk(k+1)];
end
figure(4)
stem(kk,yk);

N = 30;
xf = xk(1:N);
hf = 0.5.^(0:N-1)

yf = ifft(fft(xf).*fft(hf)); 
hold on; 
stem (0:N-1,yf); 
hold off


