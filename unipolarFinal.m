unpNR = randi([0 1],1,64);
ts=0.01;
for i = 1 : length(unpNR)
 if(unpNR(i)== 1)
 unpNR(i) = 1;
 else
 unpNR(i) = 0;
 end
end
c = 1;
p_width = 0:ts:length(unpNR);
 x=[];
for j = 1:length(p_width);
if p_width(j)<=c;
 x(j) = unpNR(c);
else
 c = c+1;
 x(j) = unpNR(c);
end
end
subplot(3,1,1); 
plot(p_width,x,'Linewidth', 1.5);
title('UniPolar NonReturn to Zero Time Domain');
axis([0 length(unpNR) -1.5 1.5 ]);
xlabel(' time(Sec)');
ylabel(' Amp(Volt)');
fs=1/ts;
df=1/(length(p_width )*ts);
f = -(0.5*fs) :df :(0.5*fs-df);
unpNR_fft=fft(x);
unpNR_fft_shift=fftshift(unpNR_fft)/length(unpNR);
subplot(3,1,2);
plot(f,abs(unpNR_fft_shift),'r');
xlim([-5 5]);
title('UniPolar NonReturn to Zero Frequency Domain');
xlabel(' freq(Hz)');
ylabel(' Amp(Volt)');
%PSD Calculation:
psd = abs(fft(x,length(x))).^2/(length(x));
subplot(3,1,3);
plot(psd,'g','linewidth',1.5);
title('unipolar PSD');
xlabel(' Freq(Hz)');
ylabel(' PSD ');
xlim([0 400 ]);