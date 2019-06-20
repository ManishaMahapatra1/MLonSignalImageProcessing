clc;
clear all;
close all;
R = textread('C:\Users\ECEDELL07\Desktop\arithymia100.txt');
t = 1:length(R);
rr = R((1:end),1);
figure,
plot(t,rr);
rp = 0.0001;
rs = 5;
%%  Band pass filtering
n = cheb1ord((10/360),33.3/360,rp,rs);
Wp = [10/360 33.3/360];
[b,a] = cheby1(n,rp,Wp);
y = filtfilt(b,a,rr);
figure,
plot(t,y);
%% differentiating
y1 = diff([y(1);y]);
figure,
plot(t,y1);
y2 = y1.^2;
figure,
plot(t,y2);
%% averaging
ww = floor(360*0.150);
b = ones(1,ww)./ww;
a=1;
y3 = filtfilt(b,a,y2);
yy = y3;
figure,
plot(y3);
hold on,
%% finding peaks 
[pk,lo] = findpeaks(yy,'MinPeakHeight',0.005);
stem(lo,pk);
ll = lo;
rr1=rr;
for j = 1:length(lo)
    a = lo(j);
    for jj = a-25:a+25
        if rr1(jj)>=rr1(a)
            ll(j) = jj;
            rr1(a) = rr1(jj);
        end
    end
end
pp = pk;
figure,
plot(rr);
hold on,
for i = 1:length(ll)
    pp(i) = rr(ll(i));
   
end
stem(ll,pp);






