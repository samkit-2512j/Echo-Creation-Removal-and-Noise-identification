input_audio_q1='hindi_2s.wav';

audio=loadAudioFile(input_audio_q1);
[audio1,fs]=audioread("q1.wav");
figure;
time_grid = 1/fs:1/fs:(length(audio1))/fs;
plot(time_grid,audio1);
title('original audio');
xlabel('time grid');
ylabel('Amplitude');
%sound(audio,fs);

echo_audio=echo_addn(audio,fs);
echo_audio=echo_audio/max(abs(echo_audio));
filenampt='1sdelayecho.wav';
audiowrite(filenampt,echo_audio,fs);
sound(echo_audio,fs);
figure;
time_grid2 = 1/fs:1/fs:(length(echo_audio))/fs;
plot(time_grid2(1:132300),echo_audio(1:132300));
xlabel('time grid');
ylabel('Amplitude');
title('echoed signal');

