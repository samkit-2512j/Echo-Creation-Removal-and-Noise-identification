function echo_audio=echo_addn(audio,fs)
 % b=[1,zeros(1,20000),0.7];
 % a=1;
 % if size(audio)==[,:2]
 % echo_audio(:,1)=filter(b,a,audio(:,1));
 % echo_audio(:,2)=filter(b,a,audio(:,2));
 h=zeros(1,10*fs);
 h(1)=1;
 h(round(0.5*fs))=0.5;
 h(round(1*fs))=0.25;
 
 [~,n] = size(audio);
 for i = 1:n
    echo_audio(:,i)=conv(audio(:,i),h);
 end
end