% Script to compare the waveform of each pixel over time



% From settings of loop
% Number of full rotations

LoopNum = 12;

%First spike
Datum = 25000;

% From inspection of spike spacing
SpikeSpacing = 49000;

Xaxis = linspace(0,SpikeSpacing,SpikeSpacing);




for N = 1 : LoopNum
    figure
    Dataseg = RawData(Datum:Datum + SpikeSpacing-1,1);  % First pixel (11)
    plot(Xaxis,Dataseg)
    Datum = Datum + SpikeSpacing;
end

