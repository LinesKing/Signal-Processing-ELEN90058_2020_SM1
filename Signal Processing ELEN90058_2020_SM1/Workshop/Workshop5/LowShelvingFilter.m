function Hd = LowShelvingFilter(GdB,fc,fs)

G = 10.^(GdB/20);
wc = 2*pi*fc/fs;
t = tan(wc/2);

Numerator = [G*t+sqrt(G) G*t-sqrt(G)];
Denominator = [t+sqrt(G) t-sqrt(G)];

a0 = Denominator(1) ;
Numerator = Numerator ./ a0;
Denominator = Denominator ./ a0;


    
Hd = dsp.IIRFilter( ...
    'Structure', 'Direct form I', ...
    'Numerator', Numerator, ...
    'Denominator', Denominator);

% [EOF]
