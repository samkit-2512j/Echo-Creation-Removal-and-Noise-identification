function noisetype = classifyNoise(audio)

[ceil_fanplusbg,fs]=audioread("music_ceiling-fan.wav");
[trafficplusbg,~]=audioread("music_city-traffic.wav");
[presscookplusbg,fs]=audioread("music_pressure-cooker.wav");
[waterpumpplusbg,fs]=audioread("music_water-pump.wav");
% [k,Fs]=audioread("music_ceiling-fan.wav");
c_orig = ceil_fanplusbg(30*fs :40*fs);
t_orig = trafficplusbg(30*fs:40*fs);
pc_orig = presscookplusbg(30*fs:40*fs);
wp_orig = waterpumpplusbg(30*fs:40*fs);
C=(fft(c_orig,length(c_orig)));
T=(fft(t_orig,length(t_orig)));
P=(fft(pc_orig,length(pc_orig)));
W=(fft(wp_orig,length(wp_orig)));
% minimum=zeros(1,length(C));
% plot(C);
% disp(length(C));
for p=1:length(C)
   a=[C(p),T(p),P(p),W(p)];

   minimum(p)=min(a);
end

bg_noisefft=minimum';
% minimum_music = ifft(bg_noisefft,length(ceil_fanplusbg));
ceil_fan=C-bg_noisefft;
traffic=T-bg_noisefft;
pressure_cooker=P-bg_noisefft;
water_pump=W-bg_noisefft;
fan_audio = ifft(ceil_fan,length(c_orig));
% fan_audio=fan_audio/max(abs(fan_audio));
% filename1='fanaudio.wav';
% audiowrite(filename1,fan_audio,fs);

traffic_audio = ifft(traffic,length(t_orig));
% traffic_audio=traffic_audio/max(abs(traffic_audio));
% filename2='trafficaudio.wav';
% audiowrite(filename2,traffic_audio,fs);

pressure_audio = ifft(pressure_cooker,length(pc_orig));
% pressure_audio=pressure_audio/max(abs(pressure_audio));
% filename4='pressureaudio.wav';
% audiowrite(filename4,pressure_audio,fs);

pump_audio = ifft(water_pump,length(wp_orig));
% pump_audio=pump_audio/max(abs(pump_audio));
% filename3='pumpaudio.wav';
% audiowrite(filename3,pump_audio,fs);
% [final,FS]= audioread("final_check.wav");
ceil_corr = xcorr(audio,fan_audio);
traffic_corr = xcorr(audio,traffic_audio);
pressure_corr = xcorr(audio,pressure_audio);
pump_corr = xcorr(audio,pump_audio);
% subplot(4,1,1)
% plot(ceil_corr);
% subplot(4,1,2)
% plot(traffic_corr);
% subplot(4,1,3)
% plot(pressure_corr);
% subplot(4,1,4)
% plot(pump_corr);
[pks,locs] = findpeaks(ceil_corr);
thres = 0.8;
global_thresh=1000;
noisetype = "The noise contains";
[~,index] = max(ceil_corr);
if(ceil_corr(index)*thres>pressure_corr(index) && ceil_corr(index)*thres>pump_corr(index) && ceil_corr(index)*thres>traffic_corr(index) && ceil_corr(index)>global_thresh)
    noisetype = noisetype + ' ' + 'ceiling fan';
end
[maxi,index] = max(traffic_corr);
if(traffic_corr(index)*thres>pressure_corr(index) && traffic_corr(index)*thres>pump_corr(index) && traffic_corr(index)*thres>ceil_corr(index) && traffic_corr(index)>global_thresh)
    noisetype = noisetype + ' ' + 'traffic';
end
[maxi,index] = max(pressure_corr);
if(pressure_corr(index)*thres>ceil_corr(index) && pressure_corr(index)*thres>pump_corr(index) && pressure_corr(index)*thres>traffic_corr(index) && pressure_corr(index)>global_thresh)
    noisetype = noisetype + ' ' + 'pressure cooker';
end
[maxi,index] = max(pump_corr);
if(pump_corr(index)*thres>pressure_corr(index) && pump_corr(index)*thres>ceil_corr(index) && pump_corr(index)*thres>traffic_corr(index) && pump_corr(index)>global_thresh)
    noisetype = noisetype + ' ' + 'water pump';
end
noisetype = noisetype + ' ' + 'noises';        

% figure;
% plot(pks);
% sound(fan_audio,fs);
end