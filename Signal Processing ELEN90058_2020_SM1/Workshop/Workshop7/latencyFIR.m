function [r] = latencyFIR(num,den)
    frameSize = 1024;
fileReader = dsp. AudioFileReader ('speech_wideband_16k.wav', ...
    'SamplesPerFrame',frameSize);
fileWriter = dsp. AudioFileWriter ('Filename', 'output.wav', ...
    'SampleRate',fileReader.SampleRate);
Ntrials = 1;
playDuration = 2.4;
NFrames = ceil(playDuration * fileReader.SampleRate / frameSize);
Buffer = dsp.AsyncBuffer(Ntrials * NFrames * frameSize);
fileReader.SamplesPerFrame = NFrames * frameSize ;
audioOut = fileReader();
for k = 1: Ntrials
    write(Buffer,audioOut);
end

r =[];
r.SamplesPerFrame = frameSize * ones (Ntrials,1);
r.SampleRate = fileReader.SampleRate/1000 * ones(Ntrials,1);
r.Latency = 0;

for k = 1:Ntrials
    for ind = 1:NFrames
        audioIn = read(Buffer,frameSize);
        equaliseIn = filter(num,den,audioIn);
        fileWriter(equaliseIn);
        write(Buffer,equaliseIn);
    end
end

latency = zeros ( Ntrials ,1);

for k = 1: Ntrials
    audioProc = read(Buffer,NFrames * frameSize);
    [temp,idx] = xcorr(audioOut,audioProc);
    rxy = abs(temp);
    [~,Midx] = max(rxy);
    latency(k) = -idx(Midx)*1/fileReader.SampleRate;
end  
    
% latency(latency<0) = NaN;
r.Latency = abs(latency*1000);
r = struct2table(r);
r.Properties.VariableUnits = {'Samples','Hz','ms'};
r.Properties.VariableNames = {'SamplesPerFrame','SampleRate_kHz','Latency_ms'};

disp (r);
end

