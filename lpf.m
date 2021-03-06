function[t,st]=lpf(f,sf,B)%低通滤波器函数
df=f(2)-f(1);
fN=length(f);
ym=zeros(1,fN);
xm=floor(B/df);
xm_shift=[-xm:xm-1]+floor(fN/2);
ym(xm_shift)=1;
yf=ym.* sf;
[t,st]=F2T(f,yf);
