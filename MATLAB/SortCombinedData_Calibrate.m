%Script to use the 16 element cell of pixel data to calibrate sensor
%values;

% MUST RUN SORT COMBINED DATA FOR TEST 6 first

%Highest mean
MaxMean = max(Meanvals) ;

for N = 1 : length(Meanvals)
    ScaleFactor(N) = MaxMean/Meanvals(N);
end

%Plot results
close all

for N = 1 : 16
    FullFrame = PixelData{N} * ScaleFactor(N);
    Xaxis = linspace(1,length(FullFrame(:,N)),length(FullFrame(:,N)));
    Yaxis = FullFrame(:,N);
    Maxvals(N) = max(Yaxis);
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
    FullFrame = PixelData{N}* ScaleFactor(N);
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
bar(Maxvals,0.5)
%plot(length(PixelMaxes),PixelMaxes)
title('Comparison of taxel Maximum values')
ylabel('Maximum reading observed')
xlabel('Pixel')




%Heatmaps
Threshold = 100;

%Need to do fullframe outside this loop:



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
        Heatvals(M) = FullFrame(idx + 200,M) * ScaleFactor(M);
        
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





