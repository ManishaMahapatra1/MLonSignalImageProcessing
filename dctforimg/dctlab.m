clc;close all
clear all;
f=[1 1 1 1];
figure
stem(f);
N=length(f);
for u=1:N
    g=0;
    if u==1
        alp(u)=1/(sqrt(N))
    else
        alp(u)=sqrt(2/N)
    end
    for x=1:N
        g=g+alp(u)*(f(x)*cos(((2*x-1)*(u-1)*pi)/(2*N)));
    end
    op(u)=g;
end
figure
stem((op))
   
    
