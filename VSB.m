clc
clear
close all
dt=0.001;                                      %采样时间间隔
 fm=5;                                         %调制信号频率
 fc=20;                                        %载波频率
 T=5;                                          %信号持续时间
 t=0:dt:T;                                     %时间矢量
 mt=cos(2*pi*fm*t);                            %调制信号
 ct=cos(2*pi*fc*t);                            %载波信号
 
 figure(1)
 plot(t,mt);
 title('输入信号时域波形')
 axis([0 5 -1.01 1.01]);                       %x轴最小值，最大值；y轴最小最大值
 line([0,5],[0,0],'color','k');                %画出（0，5）到（2，4）的一条直线
 
 figure(2)
 [fmt,Fmt]=T2F(t,mt);
 plot(fmt,Fmt);
 title('输入信号频域波形')
 axis([-8 8 0 2.6]);
 
 figure(3)
 psf1=(abs(Fmt).^2)/T;
 plot(fmt,psf1);
 axis([-34 34 0 max(psf1)]);
 title('输入信号功率谱');     %新增加

 figure(4)
 plot(t,ct);
 title('载波信号时域波形');
 axis([0 5 -1.01 1.01]);
 line([0,5],[0,0],'color','k');

 figure(5)
 [fct,Fct]=T2F(t,ct);
 plot(fct,Fct);
 title('载波信号频域波形')
 axis([-24 24 0 2.6]);
 
 %vsb modulation                               %vsb 调制过程
 s_vsb=mt.*ct;                                 %已调信号s_vsb                                                     
 [f,sf]=T2F(t,s_vsb);                          %T-F傅里叶变换,输出频率和信号幅度
 [t,s_vsb]=vsbpf(f,sf,0.2*fm,1.2*fm,fc);       %经过vsb滤波器
 figure(6)
 plot(t,s_vsb);
 grid on;
 title('VSB调制信号时域波形');
 axis([0 5 -0.6 0.6]);
 line([0,5],[0,0],'color','k');
 
 figure(7)
 [fvsb,Fvsb]=T2F(t,s_vsb);
 plot(fvsb,Fvsb);
 title('VSB调制信号频域波形');
 axis([-34 34 0 0.7]);
 
 figure(8)
 psf=(abs(Fvsb).^2)/T;
 plot(fvsb,psf);
 axis([-34 34 0 max(psf)]);
 title('VSB信号功率谱波形'); 

 svsb1=awgn(s_vsb,5); 
 svsb2=awgn(s_vsb,10);
 svsb3=awgn(s_vsb,15);
 figure(9)
 subplot(311)
 plot(t,svsb1);                                          %画出DSB信号波形
 hold on
 plot (t,mt,'r-');                                       %画出原信号
 title('VSB调制信号 S/N=5dB');
 axis([0 5 -2.4 2.4]);
 line([0,5],[0,0],'color','k');
 subplot(312)
 plot(t,svsb2);                                          %画出DSB信号波形
 hold on
 plot (t,mt,'r-');                                       %画出原信号
 title('VSB调制信号 S/N=10dB');
 axis([0 5 -2.4 2.4]);
 line([0,5],[0,0],'color','k');
 subplot(313)
 plot(t,svsb3);                                          %画出DSB信号波形
 hold on
 plot (t,mt,'r-');                                       %画出原信号
 title('VSB调制信号 S/N=15dB');
 axis([0 5 -2.4 2.4]);
 line([0,5],[0,0],'color','k');

 %vsb demodulation                                %vsb解调过程
 Sp1=svsb1.*ct;
 Sp2=svsb2.*ct;
 Sp3=svsb3.*ct;
 
 figure(10);
 subplot(311)
 plot(t,Sp1);
 hold on
 plot (t,mt,'r-');                                       %画出原信号
 title('VSB调制信号相干解调与调制信号 S/N=5dB')
 axis([0 5 -1.5 1.5]);
 line([0,5],[0,0],'color','k');
 subplot(312)
 plot(t,Sp2);
 hold on
 plot (t,mt,'r-');                                       %画出原信号
 title('VSB调制信号相干解调与调制信号 S/N=10dB')
 axis([0 5 -1.5 1.5]);
 line([0,5],[0,0],'color','k');
 subplot(313)
 plot(t,Sp3);
 hold on
 plot (t,mt,'r-');                                       %画出原信号
 title('VSB调制信号相干解调与调制信号 S/N=15dB')
 axis([0 5 -1.5 1.5]);
 line([0,5],[0,0],'color','k');
 
 [f1,rf1]=T2F(t,Sp1);                                          %T-F傅里叶变换
 [t,Sp1]=lpf(f1,rf1,2*fm);                                %经过低通滤波器
 [f2,rf2]=lpf(t,Sp2);                                          %T-F傅里叶变换
 [t,Sp2]=LPF(f2,rf2,2*fm);                                %经过低通滤波器
 [f3,rf3]=lpf(t,Sp3);                                          %T-F傅里叶变换
 [t,Sp3]=LPF(f3,rf3,2*fm);                                %经过低通滤波器

 figure(11)
 subplot(311)
 plot(t,Sp1);
 axis([2 3 -0.5 0.5]);
 line([0,5],[0,0],'color','k');
 title('经过低通滤波的相干解调信号波形 S/N=5dB');
 subplot(312)
 plot(t,Sp2);
 line([0,5],[0,0],'color','k');
 axis([2 3 -0.5 0.5]);
 title('经过低通滤波的相干解调信号波形 S/N=10dB');
 subplot(313)
 plot(t,Sp3);
 axis([2 3 -0.5 0.5]);
 line([0,5],[0,0],'color','k');
 title('经过低通滤波的相干解调信号波形 S/N=15dB');
 xlabel('t')
