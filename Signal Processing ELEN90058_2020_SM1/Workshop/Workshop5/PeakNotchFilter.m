function Hd = PeakNotchFilter(GdB,fc,fs)

G = 10.^(GdB/20);
wc = 2*pi*fc/fs;
t = tan(wc/2);
B = wc/sqrt(2);
t = tan(B/2);

Numerator = [G*t+sqrt(G) -2*sqrt(G)*cos(wc) sqrt(G)-G*t];
Denominator = [t+sqrt(G) -2*sqrt(G)*cos(wc) sqrt(G)-t];

a0 = Denominator(1) ;
Numerator = Numerator ./ a0;
Denominator = Denominator ./ a0;
    
Hd = dsp.IIRFilter( ...
    'Structure', 'Direct form I', ...
    'Numerator', Numerator, ...
    'Denominator', Denominator);

% [EOF]
