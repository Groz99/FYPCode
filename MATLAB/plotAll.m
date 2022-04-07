% Script to plot all 16 taxels across the whole time domain
% Specialised segment of processData
%close all

NumTaxels = 16;
SamplePeriod = 8e-3;
Tlength = length(RawData) * SamplePeriod; 

Xaxis = linspace(0,Tlength,length(RawData));

% Matrix is pressed by robot in following sequence:
% [44 34 24 14 13 23 33 43 42 32 22 21 11 21 31 41]

% In order of raw data:
% [16 12 8 3 7 11 15 14 10 6 2 1 5 9 13] 

%TapOrder = [16 12 8 4 3 7 11 15 14 10 6 2 1 5 9 13] ;

%Moved to order of press from within the arduino code itself
TapOrder = [1:16];


% Reading form 0 to 5 volts is scaled 0 to 1023
% For a 8ms sample time and a 1 second wait while de-pressed, over 100
% samples per press event

%%%%%%%%%%% Look at PR Matrix readings


figure 
hold on 

for N = 1 : NumTaxels
    Dataslice = RawData(:,N);  % Loop through each pixel
    plot(Xaxis, Dataslice);
end

legend('11','12','13','14' ,'21', '22', '23', '24', '31', '32', '33', '34', '41', '42',  '43', '44')
title('Comparison of all taxel readings')
ylabel('10 bit analog reading')
xlabel('time (s)')


%%%%%% Repear to print max observed values in each pixel (assumed to be
%%%%%% during primary pressing event

PixelMaxes = [];

for N = 1 : NumTaxels
    MaxVal = max(RawData(:,TapOrder(N)))  % Loop through each pixel
    %MaxVal = max(RawData(:,N))  % Loop through each pixel
    PixelMaxes(N) = MaxVal;
end

figure
bar(PixelMaxes,0.5)
%plot(length(PixelMaxes),PixelMaxes)
title('Comparison of taxel maximum values')
ylabel('Max reading observed')
xlabel('Pixel')

%%%%%%%% Means  

PixelMeans = [];

for N = 1 : NumTaxels
    MeanVal = mean(RawData(:,TapOrder(N)));  % Loop through each pixel
    PixelMeans(N) = MeanVal;
end

figure
bar(PixelMeans,0.5)
title('Comparison of taxel mean values')
ylabel('Mean reading observed')
xlabel('Pixel')

%%%%%%%% Median  

PixelMeds = [];

for N = 1 : NumTaxels
    % need to remove zeros for median analysis
    MedVal = median(nonzeros((RawData(:,TapOrder(N)))));  % Loop through each pixel
    PixelMeds(N) = MedVal;
end

figure
bar(PixelMeds,0.5)
title('Comparison of taxel median values')
ylabel('Mean reading observed')
xlabel('Pixel')