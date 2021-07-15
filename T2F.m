function [f,sf]= T2F(t,st) %傅里叶变换函数输入时间，信号矢量-----输出频率和信号幅度
% dt = t(2)-t(1);
T=t(end);
df = 1/T;
N = length(st);
f=-N/2*df : df : N/2 * df-df;
sf = fft(st);
sf = T/N * fftshift(sf);
