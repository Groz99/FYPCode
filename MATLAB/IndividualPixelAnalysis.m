
close all

DataLocation = 'H:\Tacto\FYPCode\Data_SMALL\IndividualTesting';

addpath(DataLocation)

Tsample = 8e-3; % Time between readings (1/Fs)

%Files named under "Test5_pN.txt"

%Plot principal pixel for each point


Delimiter = ' ';
NumPixels = 16;

%Plots separate graph for each pixel

for N = 1:16
    DataName = ['Test5_p' num2str(N) '.txt'];
    RawData = importdata(DataName, Delimiter);
    figure
    Xaxis = linspace(0,length(RawData),length(RawData));
    plot(Xaxis, RawData(:,N))
    title(['Pixel' num2str(N)])
    PMax(N) = max(RawData(:,N));
end

%Plot maximum observed value of all pixels
figure
bar(PMax(:),0.5)
title('Max values for all pixels')

%Plot all traces on same graph
%Sample rate is the same so first pulse syncing should be sufficient
Trigger = [];
Threshold = 200; % Pulse detection threshold
Spacer = 100; % Space before pulses

figure
hold on

for N = 1:16
    DataName = ['Test5_p' num2str(N) '.txt'];
    RawData = importdata(DataName, Delimiter);
    for idx = 1:length(RawData)
        if RawData(idx,N) > Threshold
            Trigger(N) = idx;
            break
        end
    end
    
    Xaxis = linspace(0,length(RawData)*Tsample,length(RawData));
    Yaxis = RawData((idx-Spacer):end,N);
    
    Yaxis_equal = [RawData((idx-Spacer):end,N); zeros(length(RawData)-length(Yaxis),1)];
    
    plot(Xaxis, Yaxis_equal)
    title('All pixel pulses shown')
end

%legend('1','2','3','4','5','6','7','8','9','10','11','12','13','14','15','16')
legend('pixel 1','pixel 2','pixel 3','pixel 4','pixel 5','pixel 6','pixel 7','pixel 8','pixel 9','pixel 10','pixel 11','pixel 12','pixel 13','pixel 14','pixel 15','pixel 16')

hold off

xlabel('Analog reading')
ylabel('Time (s)')


%Generate heatmap for each pixel (First press only)
%From press event, 1 second at 8ms sampling will take 125 samples





for N = 1:NumPixels
    DataName = ['Test5_p' num2str(N) '.txt'];
    RawData = importdata(DataName, Delimiter);
    for idx = 1:length(RawData)
        if RawData(idx,N) > Threshold
            Trigger(N) = idx;
            break
        end
    end
    Heatvals = [];
    for M = 1:NumPixels
        %Peak val
        %Heatvals(M) = RawData(idx + 125,M);
        
        %Average
        Heatvals(M) = mean(RawData(idx + 125: idx + 135,M));
    end    
    figure
    %Note the snake pattern the robot takes
    Heatmap = [fliplr(Heatvals(1:4));Heatvals(5:8);fliplr(Heatvals(9:12));Heatvals(13:16)];
    heatmap(Heatmap,'Colormap',summer)
    title(['Pixel ' num2str(N) ' heatmap'])
end

