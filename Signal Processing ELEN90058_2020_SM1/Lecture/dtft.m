function X = dtft(x, kmin, kmax, ww)
k = kmin: kmax;
X = zeros(1,length(ww));
for iw = 1:length(ww)
    w = ww(iw);
    ex = exp(-j*w*k);
    X(iw) = sum(x.* ex);
end

