%Script to preprocess the slide data into windows for access by ML algoritm

clear all

TriggerPixel = 1; %First PR element that gets introduced to curve

NumWindows = 50;

DataLocation = 'H:\Tacto\Data_LARGE\';
addpath(DataLocation)
DataName = 'Test13_SmoothA.txt';%

Delimiter = ' ';
RawDataSmooth = importdata(DataName, Delimiter);

SampleEnds = [1];


for N = 1 : length(RawDataSmooth(:,TriggerPixel))
    if RawDataSmooth(N,TriggerPixel) > 0 && ((N - SampleEnds(end)) > 1350 || length(SampleEnds) == 1)  
        SampleEnds = [SampleEnds N];
    end
    
    if length(SampleEnds) == NumWindows + 1
        break
    end
    
end

for N = 1: length(SampleEnds)-1
    %SmoothWindows{N} = RawDataSmooth(SampleEnds(N+1)-10:SampleEnds(N+1)+989,:);
    SmoothWindows(N,:,:) =  RawDataSmooth(SampleEnds(N+1)-10:SampleEnds(N+1)+989,:);
end


DataName = 'Test14_LevelledA.txt';

Delimiter = ' ';
RawDataLevelled = importdata(DataName, Delimiter);

SampleEnds = [1];


for N = 1 : length(RawDataSmooth(:,TriggerPixel))
    %Need to capture first window if less than time
    if RawDataLevelled(N,TriggerPixel) > 0 && ((N - SampleEnds(end)) > 1350 || length(SampleEnds) == 1)  
        SampleEnds = [SampleEnds N];
    end
    
     if length(SampleEnds) == NumWindows + 1
        break
     end
    
end

for N = 1: length(SampleEnds)-1
    %LevelledWindows{N} = RawDataLevelled(SampleEnds(N+1)-10:SampleEnds(N+1)+989,:);
    LevelledWindows(N,:,:) = RawDataLevelled(SampleEnds(N+1)-10:SampleEnds(N+1)+989,:);
end