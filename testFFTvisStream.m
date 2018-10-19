L=BuffSize

X=filt_data(3,:)';
X=filt_data';
subplot(121)
plot(X)
subplot(122)
Y = fft(X);

P2 = abs(Y/L);
P1 = P2(1:L/2+1,:);
P1(2:end-1,:) = 2*P1(2:end-1,:);
f = Fs*(0:(L/2))/L;

p=plot(f,10*log10(P1)) 
% plot(f,P1) 
xlim([0 60])
title('Single-Sided Amplitude Spectrum of X(t)')
xlabel('f (Hz)')
ylabel('|P1(f)|')