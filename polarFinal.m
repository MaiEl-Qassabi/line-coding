polar_cum_freq= zeros(1,1000001);
psd_cum = zeros(1,1000001);
times =10;
for r=1:times 
pNR = randi([0 1],1,1000);
ts=0.001;
for i = 1 : length(pNR)
 if(pNR(i)== 1)
 pNR(i) = 1;
 else
 pNR(i) = -1;
 end
end
c = 1;
p_width = 0:ts:length(pNR);
 x=[];
for j = 1:length(p_width);
if p_width(j)<=c;
 x(j) = pNR(c);
else
 c = c+1;
 x(j) = pNR(c);
end
end
fs=1/ts;
df=1/(length(p_width )*ts);
f = -(0.5*fs) :df :(0.5*fs-df);
unpNR_fft=fft(x);
unpNR_fft_shift=fftshift(unpNR_fft)/length(pNR);
polar_cum_freq = polar_cum_freq + unpNR_fft_shift.^2;
psd = abs(fft(x,length(x))).^2/(length(x));
psd_cum= psd_cum + psd;
end
subplot(3,1,1); 
plot(p_width,x,'Linewidth', 1.5);
title('Polar NonReturn to Zero Time Domain');
axis([0 length(pNR) -1.5 1.5 ]);
xlabel(' time(Sec)');
ylabel(' Amp(Volt)');

subplot(3,1,2);
plot(f,abs(polar_cum_freq)/times,'r');
xlim([-5 5]);
title('Polar NonReturn to Zero Frequency Domain');
xlabel(' freq(Hz)');
ylabel(' Amp(Volt)');
%psd = abs(fft(x,length(x))).^2/(length(x));
%PSD Calculation:
subplot(3,1,3);
plot(psd/times,'g')
title('Polar PSD');
xlabel(' Freq(Hz)');
ylabel(' PSD ');
xlim([0 400 ]);