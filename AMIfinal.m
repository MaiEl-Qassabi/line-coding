AMI_cum_freq= zeros(1,999001);
psd_cum = zeros(1,999001);
times =10;
for r=1:times
AMI = randi([0 1],1000);
ts=0.001;
k=0;
for i=1: length (AMI)
    if AMI(i)==0
        b(i)=0;
    else
        k=k+1;
        if rem(k,2)==0
            b(i)=-1;
        else
            b(i)=+1;
        end
    end
end
c=1;
x=[];
p_width = 0:0.001:length(AMI)-1;
for j = 1:length(p_width);
if p_width(j)<=c;
 x(j) = b(c);
else
 c = c+1;
 x(j) = b(c);
end
end
fs=1/ts;
df=1/(length(p_width )*ts);
f = -(0.5*fs) :df :(0.5*fs-df);
AMI_fft=fft(x);
AMI_fft_shift=fftshift(AMI_fft)/length(x);
AMI_cum_freq = AMI_cum_freq + AMI_fft_shift.^2;
psd = abs(fft(x,length(x))).^2/(length(x));
psd_cum= psd_cum + psd;
end
subplot(3,1,1);
plot(p_width ,x)
axis([0 length(AMI) -1.5 1.5]);
title('AMI bipolar NonReturn to Zero Time Domain');
xlabel(' time(Sec)');
ylabel(' Amp(Volt)');
subplot(3,1,2);
plot(f,AMI_cum_freq/times,'r')

xlim([-5 5]);
title('AMI NonReturn to Zero Freq Domain');
subplot(3,1,3);
psd = abs(fft(x,length(x))).^2/(length(x));
plot (psd/times,'g');
xlim([0 400]);
title('AMI PSD');
