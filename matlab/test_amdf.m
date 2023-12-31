%script to test AMDF pitch detector
close all, clc;

[x,fs] = audioread('guitar files/High_E.wav');
x = x';
x = round(x*2^15);
win = 1024;
nframes = ceil(length(x)/win);
x = [x, zeros(1,nframes*win - length(x))];
start = 1;   
time = zeros(1,nframes);
xbuf = zeros(nframes, win);

%break into frames of 1024 samples
for i = 1:nframes
    xbuf(i,:) = x(start:start+win-1);
    time(i) = (start-1)/fs;
    start = start + win;
end

%ideally this should be the steady state buffer number following onset  
thresh = 0.98;
[ onsetBuff, ssBuff ] = find_onset(xbuf, fs, thresh );
ssBuff = 80;

pitch = amdf_pitch(xbuf(ssBuff,:),fs);
sprintf('The detected pitch is %d',pitch)
