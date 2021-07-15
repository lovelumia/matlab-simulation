clc
clear
close all
dt=0.001;                                      %����ʱ����
 fm=5;                                         %�����ź�Ƶ��
 fc=20;                                        %�ز�Ƶ��
 T=5;                                          %�źų���ʱ��
 t=0:dt:T;                                     %ʱ��ʸ��
 mt=cos(2*pi*fm*t);                            %�����ź�
 ct=cos(2*pi*fc*t);                            %�ز��ź�
 
 figure(1)
 plot(t,mt);
 title('�����ź�ʱ����')
 axis([0 5 -1.01 1.01]);                       %x����Сֵ�����ֵ��y����С���ֵ
 line([0,5],[0,0],'color','k');                %������0��5������2��4����һ��ֱ��
 
 figure(2)
 [fmt,Fmt]=T2F(t,mt);
 plot(fmt,Fmt);
 title('�����ź�Ƶ����')
 axis([-8 8 0 2.6]);
 
 figure(3)
 psf1=(abs(Fmt).^2)/T;
 plot(fmt,psf1);
 axis([-34 34 0 max(psf1)]);
 title('�����źŹ�����');     %������

 figure(4)
 plot(t,ct);
 title('�ز��ź�ʱ����');
 axis([0 5 -1.01 1.01]);
 line([0,5],[0,0],'color','k');

 figure(5)
 [fct,Fct]=T2F(t,ct);
 plot(fct,Fct);
 title('�ز��ź�Ƶ����')
 axis([-24 24 0 2.6]);
 
 %vsb modulation                               %vsb ���ƹ���
 s_vsb=mt.*ct;                                 %�ѵ��ź�s_vsb                                                     
 [f,sf]=T2F(t,s_vsb);                          %T-F����Ҷ�任,���Ƶ�ʺ��źŷ���
 [t,s_vsb]=vsbpf(f,sf,0.2*fm,1.2*fm,fc);       %����vsb�˲���
 figure(6)
 plot(t,s_vsb);
 grid on;
 title('VSB�����ź�ʱ����');
 axis([0 5 -0.6 0.6]);
 line([0,5],[0,0],'color','k');
 
 figure(7)
 [fvsb,Fvsb]=T2F(t,s_vsb);
 plot(fvsb,Fvsb);
 title('VSB�����ź�Ƶ����');
 axis([-34 34 0 0.7]);
 
 figure(8)
 psf=(abs(Fvsb).^2)/T;
 plot(fvsb,psf);
 axis([-34 34 0 max(psf)]);
 title('VSB�źŹ����ײ���'); 

 svsb1=awgn(s_vsb,5); 
 svsb2=awgn(s_vsb,10);
 svsb3=awgn(s_vsb,15);
 figure(9)
 subplot(311)
 plot(t,svsb1);                                          %����DSB�źŲ���
 hold on
 plot (t,mt,'r-');                                       %����ԭ�ź�
 title('VSB�����ź� S/N=5dB');
 axis([0 5 -2.4 2.4]);
 line([0,5],[0,0],'color','k');
 subplot(312)
 plot(t,svsb2);                                          %����DSB�źŲ���
 hold on
 plot (t,mt,'r-');                                       %����ԭ�ź�
 title('VSB�����ź� S/N=10dB');
 axis([0 5 -2.4 2.4]);
 line([0,5],[0,0],'color','k');
 subplot(313)
 plot(t,svsb3);                                          %����DSB�źŲ���
 hold on
 plot (t,mt,'r-');                                       %����ԭ�ź�
 title('VSB�����ź� S/N=15dB');
 axis([0 5 -2.4 2.4]);
 line([0,5],[0,0],'color','k');

 %vsb demodulation                                %vsb�������
 Sp1=svsb1.*ct;
 Sp2=svsb2.*ct;
 Sp3=svsb3.*ct;
 
 figure(10);
 subplot(311)
 plot(t,Sp1);
 hold on
 plot (t,mt,'r-');                                       %����ԭ�ź�
 title('VSB�����ź���ɽ��������ź� S/N=5dB')
 axis([0 5 -1.5 1.5]);
 line([0,5],[0,0],'color','k');
 subplot(312)
 plot(t,Sp2);
 hold on
 plot (t,mt,'r-');                                       %����ԭ�ź�
 title('VSB�����ź���ɽ��������ź� S/N=10dB')
 axis([0 5 -1.5 1.5]);
 line([0,5],[0,0],'color','k');
 subplot(313)
 plot(t,Sp3);
 hold on
 plot (t,mt,'r-');                                       %����ԭ�ź�
 title('VSB�����ź���ɽ��������ź� S/N=15dB')
 axis([0 5 -1.5 1.5]);
 line([0,5],[0,0],'color','k');
 
 [f1,rf1]=T2F(t,Sp1);                                          %T-F����Ҷ�任
 [t,Sp1]=lpf(f1,rf1,2*fm);                                %������ͨ�˲���
 [f2,rf2]=T2F(t,Sp2);                                          %T-F����Ҷ�任
 [t,Sp2]=lpf(f2,rf2,2*fm);                                %������ͨ�˲���
 [f3,rf3]=T2F(t,Sp3);                                          %T-F����Ҷ�任
 [t,Sp3]=lpf(f3,rf3,2*fm);                                %������ͨ�˲���

 figure(11)
 subplot(311)
 plot(t,Sp1);
 axis([2 3 -0.5 0.5]);
 line([0,5],[0,0],'color','k');
 title('������ͨ�˲�����ɽ���źŲ��� S/N=5dB');
 subplot(312)
 plot(t,Sp2);
 line([0,5],[0,0],'color','k');
 axis([2 3 -0.5 0.5]);
 title('������ͨ�˲�����ɽ���źŲ��� S/N=10dB');
 subplot(313)
 plot(t,Sp3);
 axis([2 3 -0.5 0.5]);
 line([0,5],[0,0],'color','k');
 title('������ͨ�˲�����ɽ���źŲ��� S/N=15dB');
 xlabel('t')
