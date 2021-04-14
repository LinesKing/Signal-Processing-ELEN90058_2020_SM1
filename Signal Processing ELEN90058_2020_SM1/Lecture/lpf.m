function h = lpf(wc,K)
h0 = wc/pi;
k = 1:K;
hp = sin(wc*k)./(pi*k);
h = [flip(hp) h0 hp];
end

