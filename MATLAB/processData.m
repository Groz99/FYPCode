% Script to generate plots of the data for analysis
% Run loadData first in order to load .txt data in MATLAB workspace for
% analysis

% Matrix is pressed by robot in following sequence:
% [44 34 24 14 13 23 33 34 42 32 22 21 11 21 31 41]

% Data is read into RawData in following sequence:
% [11 12 13 14 21 22 23 24 31 32 33 34 41 42 43 44];
% Data must be reodered if it wants to be viewed in equal sequence

% RawData is [11 12..... 43 44 Alpha Beta Gamma X Y Z  Temp Time]
% Temp and Time are not neccesarily useful here

Dataslice = RawData(:,1);  % First pixel (11)
Xaxis = linspace(0,100,length(Dataslice));
figure
plot(Xaxis, Dataslice)
% 
Dataslice2 = RawData(:,16); % Last pixel (44)
figure
plot(Xaxis, Dataslice2)

Dataslice3 = RawData(:,17); % GyroX
figure 
plot(Xaxis,Dataslice3)

Dataslice4 = RawData(:,18); % GyroY
hold on
%figure 
plot(Xaxis,Dataslice4)

Dataslice5 = RawData(:,19); % GyroZ
%figure 
plot(Xaxis,Dataslice5)

legend('Alpha','Beta','Gamma')



Dataslice6 = RawData(:,20); % AccelX
figure 
plot(Xaxis,Dataslice6)

Dataslice7 = RawData(:,21); % AccelY
hold on
%figure 
plot(Xaxis,Dataslice7)

Dataslice8 = RawData(:,22); % AccelZ
%figure 
plot(Xaxis,Dataslice8)
legend('x','y','z')




% Dataslice6 = RawData(:,22); % AccelX
% figure 
% plot(Xaxis,Dataslice6)