% Script to generate plots of the data for analysis
% Run loadData first in order to load .txt data in MATLAB workspace for
% analysis

% Matrix is pressed by robot in following sequence:
% [44 34 24 14 13 23 33 43 42 32 22 21 11 21 31 41]

% Data is read into RawData in following sequence:
% [11 12 13 14 21 22 23 24 31 32 33 34 41 42 43 44];
% Data must be reodered if it wants to be viewed in equal sequence

% RawData is [11 12..... 43 44 Alpha Beta Gamma X Y Z  Temp Time]
% Temp and Time are not neccesarily useful here

% Roughly 8ms sample period, 0.008
% For time axis, 

SamplePeriod = 8e-3;
Tlength = length(RawData) * SamplePeriod; 
NumPixels = 16;
Xaxis = linspace(0,Tlength,length(RawData));


% Reading form 0 to 5 volts is scaled 0 to 1023
% For a 8ms sample time and a 1 second wait while de-pressed, over 100
% samples per press event



%%%%%%%%%%% Look at PR Matrix readings

%{
Dataslice = RawData(:,1);  % First pixel (11)
figure
plot(Xaxis, Dataslice)
title('Pixel 1 all readings')
xlabel('Time')
ylabel('Analog reading')
%Data segmented by 391 - 392 seconds

% 
Dataslice2 = RawData(:,16); % Last pixel (44)
figure
plot(Xaxis, Dataslice2)
title('Pixel 16 all readings')
xlabel('Time')
ylabel('Analog reading')
%}

%%%%% Plot all pixels instead:
close all
for N = 1 : NumPixels
   
    Dataslice = RawData(:,N);  % First pixel (11)
    figure
    plot(Xaxis, Dataslice)
    title(['Pixel ' num2str(N) ' all readings'])
    xlabel('Time')
    ylabel('Analog reading')
end
%%%%%%%%%%% Look at Gyro readings

%{
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
%}

%%%%%%%%%%% Look at Accel readings

%{
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
%}
