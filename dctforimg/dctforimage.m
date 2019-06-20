clc;close all
clear all;
f=[10 20; 30 40];
figure
image(f);
[M N]=size(f)
for u=1:M
    for v=1:N
    g=0;
    if u==1
        alp(u)=1/(sqrt(M))
    else
        alp(u)=sqrt(2/M)
    end
    if v==1
        alp(v)=1/(sqrt(N))
    else
        alp(v)=sqrt(2/N)
    end
    for x=1:M
        for y=1:N
        g=g+alp(u)*alp(v)*(f(x,y)*(cos(((2*x-1)*(u-1)*pi)/(2*N)))*cos(((2*y-1)*(v-1)*pi)/(2*N)));
        end
    end
    op(u,v)=g;
    end
end
figure
image((op))
figure
image(idct2(op))