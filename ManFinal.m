Manch_cum_freq= zeros(1,100001);
psd_cum = zeros(1,2000);
times=10; %iterations
for r=1:times
signalManch = randi([0 1],1,1000 );
N =length(signalManch);
pluse = 1;
n = 1000;
ts=0.01;
t = 0:ts:N/pluse;
x=[];
for i=1:N
  if signalManch(i)==1
    A =[1 -1];
  else
    A=[-1 1];
  end
  x=[x A];
end
counter = 1;
Manch=[];
for j = 1:length(t)
  if t(j)>counter
    counter = counter + 1;
    Manch(j)=x(counter);
    else Manch(j)=x(counter);
  end
end
%freq calculating
fs=1/ts;
df=1/(length(t)*ts);
f = -(0.5*fs) :df :(0.5*fs-df);
Manch_fft=fft(Manch);
Manch_fft_shift=fftshift(Manch_fft)/N;
Manch_cum_freq = Manch_cum_freq + Manch_fft_shift.^2;
%PSD calculating
psd = abs(fft(x,length(x))).^2/(length(x));
psd_cum= psd_cum + psd;
end
%time plotting
subplot(3,1,1); 
plot(t, Manch, 'Linewidth', 1.5)
title(' Manchester Time Domain');
xlabel(' time(Sec)');
ylabel(' Amp(Volt)');
%freq plotting
subplot(3,1,2);
plot(f,abs(Manch_cum_freq)/times,'r');
xlim([-5 5]);
title('Manchester frequency Domain');
xlabel(' freq(Hz)');
ylabel(' Amp(Volt)');
%PSD plotting
subplot(3,1,3);
plot(psd/times,'g');
title('Manchester PSD');
xlabel(' Freq(Hz)');
ylabel(' PSD ');
xlim([0 400]);

