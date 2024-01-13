function [audio,Fs] = loadAudioFile(filename)
[audio,Fs] = audioread(filename);
end