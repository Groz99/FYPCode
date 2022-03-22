% Script to generate plots of the data for analysis

Dataslice = RawData(:,1);  % First pixel (11)
Xaxis = linspace(0,100,length(Dataslice));
figure
plot(Xaxis, Dataslice)

Dataslice2 = RawData(:,16); % Last pixel (44)
figure
plot(Xaxis, Dataslice2)

Dataslice3 = 4 * RawData(:,17); % GyroX
figure 
plot(Xaxis,Dataslice3)

Dataslice4 = -20 * RawData(:,22); % AccelX
figure 
plot(Xaxis,Dataslice4)