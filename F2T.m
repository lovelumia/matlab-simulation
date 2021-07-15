function[t,st]=F2T(f,Sf) %傅里叶逆变换函数，
                         %通过对输入的频域信号使用傅里叶函数来计算出时域信号
df=f(2)-f(1);
fmax=(f(end)-f(1)+df);
dt=1/fmax;
N=length(f);
t=[0:N-1] * dt;
Sf=fftshift(Sf);
st=fmax * ifft(Sf);
st=real(st);
