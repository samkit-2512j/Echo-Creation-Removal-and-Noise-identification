% Function 1: Load the input audio file
function [audio,fs] = loadAudioFile(filename)
% Load the audio file
[audio,fs] = audioread(filename);
end