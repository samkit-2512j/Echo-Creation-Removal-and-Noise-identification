inputSignal="echo_in.wav";

%Loading input signal
[x,Fs]=loadAudioFile(inputSignal);
x=x';
%sound(x,Fs);
%Finding the auto-correlation of the signal containing echo.
[autoCorr,timeStamps] = xcorr(x);

%Truncating the vectors for only t>0.
autoCorr = autoCorr(timeStamps>0);
timeStamps = timeStamps(timeStamps>0);

%{
Using an envelope function which returns index of peaks of
auto-correlation
%}
peak_indx=env(autoCorr,Fs);

final=echo_filter(x,autoCorr,peak_indx);
final=final/max(abs(final));
sound(final,Fs);
figure;
subplot(3,1,1);
plot(1/Fs:1/Fs:length(x)/Fs,x);
title("Original Signal with echo");
xlabel("Time(s)");
ylabel("Amplitude");

subplot(3,1,2);
plot(timeStamps,autoCorr);
title("Auto-Correlation of the echo signal");
xlabel("Time(s)");
ylabel("Amplitude");

subplot(3,1,3);
plot(1/Fs:1/Fs:length(x)/Fs,final);
title("Filtered signal without echo");
xlabel("Time(s)");
ylabel("Amplitude");
