function filtered_sig=echo_filter(audio,autoCorr,peak_indx)

%max value of autocorrelation
max_auto=max(autoCorr);

%scaling factor for the echo's at different delays
lambda=autoCorr(peak_indx)/max_auto;

%coefficients of the IIR filter designed to remove echo
b=[1,zeros(1,length(audio)-1)];
for n=2:length(peak_indx)
    k=peak_indx(n)+1;
    b(k)=lambda(n);
end
a=1;

%filtering using the given filter coefficients
filtered_sig=filter(a,b,audio);

end