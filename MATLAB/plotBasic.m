%Script to plot a single row of any 24 wide array
figure

DataCol = 16;

Xaxis = linspace(1,length(RawData(:,DataCol))*8e-3,length(RawData(:,DataCol)));
Yaxis = RawData(:,DataCol);

plot(Xaxis,Yaxis)
ylabel('Count')
xlabel('Time')
title('Pixel 16')
