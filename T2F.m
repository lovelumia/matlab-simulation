function [f,sf]= T2F(t,st) %����Ҷ�任��������ʱ�䣬�ź�ʸ��-----���Ƶ�ʺ��źŷ���
% dt = t(2)-t(1);
T=t(end);
df = 1/T;
N = length(st);
f=-N/2*df : df : N/2 * df-df;
sf = fft(st);
sf = T/N * fftshift(sf);
