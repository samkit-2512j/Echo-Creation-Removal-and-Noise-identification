inputAudiofile = 'music_pressure-cooker_hp.wav';
% soundsc('noisy_ceiling-fan.mp3');
[audio,fs] = loadAudioFile(inputAudiofile);
%soundsc(audio,fs);
noisetype = classifyNoise(audio);
disp(noisetype);