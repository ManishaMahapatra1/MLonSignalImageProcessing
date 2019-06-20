clc;
close all;
clear all;
x1 = xlsread('C:\Users\ECEDELL07\Desktop\workshop\dct for signal\wave.xlsx');     %reading the signal
part = input('No. of parts');
par = floor(length(x1)/part)+1;
par1=input('No. of zeros of each block');
x = [x1 zeros(1,par*part-length(x1))];
t = 0:1/length(x):1-(1/length(x));
 subplot(3,1,1);
plot(x);title('input wave');
xlabel('time');
ylabel('voltage');
o=0;
u=par-par1+1;
p = 1;
B = zeros(1,length(x));
f = 0:par-1;
subplot(3,1,2);

%% DCT
for i=1:part
    j = par*i;
    c = x(1,p:j);
    X = dct(c);
    B(1,p:j) = X;
    plot(f+o,X(1,1:par));hold on
    o = j+1;p = j+1;
    B(1,u:j) = zeros(1,par1);
    u = par-par1+1+j;
end
title('dct waves forms of parts');
xlabel('samples of frequency');
ylabel('magnitude');
p = 1;
%% IDCT
for i=1:part
    j = par*i;
    c = B(1,p:j);
    b = idct(c);
    ID(1,p:j) = b;
    p = j+1;
end
subplot(3,1,3);
plot(ID);ylim([0,1000]);title('output waveform');
xlabel('time');ylabel('voltage');
%plot(t,b);
ii1=1;

%% calculating PSNR
for ii = 500:1660
    com(ii1) = 1662/ii;
 
Y1 = dct(x);
aa = length(Y1(1,ii+1:end));
Y2 = Y1(1,1:ii);
Y1(1,ii+1:end) = zeros(1,aa);
Y3 = idct(Y1);
 
TTTT = ((x-Y3).^2);
TTTT = sum(TTTT);
PSS(ii1) = 10*log10((max(x).^2)./(TTTT));
 
ii1 = ii1+1;
end
ttt = 1000:1660;
figure,
plot(com,PSS);
xlabel('compression ratio');
ylabel('PSNR of considered samples');
title('compression vs PSNR');

