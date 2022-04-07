% Script to sort through combined data to separate each pixel reading.
% Running robot script "_testPixel"


%%%%% Specced and tested for 5 second delay between pulses

% NB will only work if return to zero is good.



% period of waiting between pixel presses
WaitTime = 5;
SampleRate = 8e-3;
WaitSamples = WaitTime / SampleRate;

% if 0s for decent perdiod of WaitSamples, pixel change has occured.
SampleCount = 0;
PixelNum = 1;
PixelData = [];
PulsePeriod = 80; % SET TO 500 for 6, 80 for 6redo


%Find start point
for M = 1: length(RawData(:,1))
    totalReading = sum(RawData(M,1:16));
    if totalReading > 100 
       StartPoint = M;
       break
    end
end

%Buffer a few zeroes at the start
StartPoint = StartPoint - 100; % 350 for 6, 100 6redo

%
Endlast = StartPoint;

%%%% NB there will be some spare cells due to zeros at the end

%Find periods of zeroes between readings
for N = StartPoint : length(RawData(:,1))
    totalReading = sum(RawData(N,1:16));
    if totalReading == 0
       SampleCount = SampleCount + 1;
    elseif totalReading > 100
       SampleCount = 0;   
    end
    
    if SampleCount > (WaitSamples * 0.8)        
       PixelData{PixelNum} = RawData(Endlast:N,1:16);
       
       if PixelNum == 16
           break
       end
       
       PixelNum = PixelNum + 1;
       Endlast = N;
       SampleCount = 0;     
    end
end



%{
%Attempt to find nonzeros with an ignore

NewPulse = 1;

for N = StartPoint : length(RawData(:,1))
    totalReading = sum(RawData(N,1:16));
    if totalReading > 10 && NewPulse == 1
       PixelData{PixelNum} = RawData(Endlast:N,1:16);
       PixelNum = PixelNum + 1;
       Endlast = N;
       SampleCount = 0;
       NewPulse = 0;
    end
    
    SampleCount = SampleCount + 1;
    
    if SampleCount > PulsePeriod
    NewPulse = 1;          
    end
end
%}


%Plot results
close all

for N = 1 : 16
    FullFrame = PixelData{N};
    Xaxis = linspace(1,length(FullFrame(:,N)),length(FullFrame(:,N)));
    Yaxis = FullFrame(:,N);
    Maxvals(N) = max(Yaxis);
    Meanvals(N) = mean(Yaxis);
    figure
    XaxisT = Xaxis * 8e-3;
    plot(XaxisT,Yaxis)
    title(['Pixel ' num2str(N)]) 
    xlabel('Time (s)')
    ylabel('Count')
end    

%plot on one graph for ease of comparison;
figure
hold on
for N = 1 : 16
    FullFrame = PixelData{N};
    Xaxis = linspace(1,length(FullFrame(:,N)),length(FullFrame(:,N)));
    Yaxis = FullFrame(:,N);
    XaxisT = Xaxis * 8e-3;
    plot(XaxisT,Yaxis)
    title('All pixel pulses') 
    xlabel('Time (s)')
    ylabel('Count')
end  

legend('1','2','3','4','5','6','7','8','9','10','11','12','13','14','15','16')

% Max Vals
% This proves that max values are observed during the correct pixel press
% 

figure
%bar(Meanvals,0.5)
bar(Maxvals,0.5)
%plot(length(PixelMaxes),PixelMaxes)
title('Comparison of taxel Maximum values')
ylabel('Maximum reading observed')
xlabel('Pixel')





%Heatmaps
Threshold = 100;

for N = 1 : 16
    FullFrame = PixelData{N};
    %Heatmaps
    for idx = 1:length(FullFrame(:,N))
        if FullFrame(idx,N) > Threshold
            Trigger(N) = idx;
            break
        end
    end
    
    for M = 1:16
        %Peak val
        Heatvals(M) = FullFrame(idx + 100,M); %250 for 6, 100 for 6redo
        
        %Average
        %Heatvals(M) = mean(RawData(idx + 125: idx + 135,M));
    end 
    
    figure
    Heatmap = [fliplr(Heatvals(1:4));Heatvals(5:8);fliplr(Heatvals(9:12));Heatvals(13:16)];
    heatmap(Heatmap,'Colormap',summer)
    title(['Pixel ' num2str(N) ' heatmap'])
    xlabel('Pixel row')
    ylabel('Pixel column')
end   






