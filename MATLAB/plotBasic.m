%Script to plot a single row of any 24 wide array
figure

%NB must ensure that there are NaN datapoints or FFT will not work.. data
%will be slightly corrupt.

DataCol = 17;

%Xaxis = linspace(1,length(RawData(:,DataCol))*8e-3,length(RawData(:,DataCol))); % TIME
Xaxis = linspace(1,length(RawData(:,DataCol)),length(RawData(:,DataCol))); % SAMPLE
Yaxis = RawData(:,DataCol);

YaxisF = fft(abs(Yaxis));

plot(Xaxis,YaxisF)
xlabel('Time')
ylabel('Count')
title('Pixel 16')
