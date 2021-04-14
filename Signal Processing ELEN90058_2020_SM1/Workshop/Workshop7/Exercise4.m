%% %%Minimum-phase FIR Filter%% %%
clear all
close all
clc

%% Question 1. FIR
z = tf('z',1);
H = (1-0.9*exp(1j*0.6*pi)*z^(-1))*(1-0.9*exp(-1j*0.6*pi)*z^(-1))*...
    (1-1.25*exp(1j*0.8*pi)*z^(-1))*(1-1.25*exp(-1j*0.8*pi)*z^(-1));
[num,den] = tfdata(H);
N = abs(cell2mat(num));
D = abs(cell2mat(den));
[z,p,k] = tf2zpk(N,D);

zplane(z,p);

fvtool(N,D);

FLAG1 = isminphase(N,D)

%% Question 2. FIR
% b = abs(N(end-(length(N)+1)/2+1:end));
% bb = [fliplr(abs(N(end-(length(N)+1)/2+2:end))) b];
% H_minphase = firminphase(bb);

z_minphase = zeros(length(z),1);
for i = 1:length(z)
%     if magnitude of zero greater than 1, replce 
%         the zero with its inverse conjugate and
%         scale the gain parameter.
    if(abs(z(i)) > 1)
        z_minphase(i) = 1/conj(z(i));
        k = k*abs(conj(z(i)));
    else
        z_minphase(i) = z(i);
    end
end

zplane(z_minphase,p);
[n,d] = zp2tf(z_minphase,p,k);

FLAG2 = isminphase(n,d)

fvtool(n,d);

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Question 3. FIR
clear all
close all
clc

N = 30;
fs = 16000;
GdB = [-30,-30,-20,-10,-10,0,15,15];
fpts = [0, 1/64, 1/32, 1/16, 1/8, 1/4, 1/2, 1];
mval = db2mag(GdB);
multibandFIR = fir2(N,fpts, mval);

r1 = latencyFIR(multibandFIR,1);
fvtool(multibandFIR);

[z,p,k] = tf2zpk(multibandFIR,1);
zeros_ouside = length(find(abs(z)>1))
[n,d] = zp2tf(z,p,k);
r2 = latencyFIR(n,d);

%% Question 4. IIR
z_minphase = zeros(length(z),1);
for i = 1:length(z)
%     if magnitude of zero greater than 1, replce 
%         the zero with its inverse conjugate and
%         scale the gain parameter.
    if(abs(z(i)) > 1)
        z_minphase(i) = 1/conj(z(i));
        k = k*abs(conj(z(i)));
    else
        z_minphase(i) = z(i);
    end
end

zplane(z_minphase,p);
[n,d] = zp2tf(z_minphase,p,k);

FLAG2 = isminphase(n,d)

fvtool(n,d);

%% Question 5.
r2 = latencyFIR(n,d);




