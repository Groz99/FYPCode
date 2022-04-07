DataLocation = 'H:\Tacto\Data_LARGE\';
addpath(DataLocation)
DataName = 'Test13_SmoothA.txt';%

Delimiter = ' ';
RawData = importdata(DataName, Delimiter);

SampleRate = 8e-3

figure
hold on
for idx = 17:19
Pixel = idx;
Xaxis = linspace(1,length(RawData(:,Pixel))*SampleRate,length(RawData(:,Pixel )));
%for AccelZ
%Yaxis = (RawData(:,Pixel) + 9) * 50;
Yaxis = (RawData(:,Pixel));
plot(Xaxis,Yaxis)
xlabel('Time (s)')
ylabel('Gyroscope reading deg/s')
end
legend('X', 'Y', 'Z')

%plot all accels
figure
hold on

for idx = 20:22
Pixel = idx;
Xaxis = linspace(1,length(RawData(:,Pixel)),length(RawData(:,Pixel )));
%for AccelZ
%Yaxis = (RawData(:,Pixel) + 9) * 50;
Yaxis = (RawData(:,Pixel));
plot(Xaxis,Yaxis)
end


DataName = 'Test14_LevelledA.txt';

Delimiter = ' ';
RawData = importdata(DataName, Delimiter);

figure
hold on
for idx = 17:19
Pixel = idx;
Xaxis = linspace(1,length(RawData(:,Pixel))*SampleRate,length(RawData(:,Pixel )));
%for AccelZ
%Yaxis = (RawData(:,Pixel) + 9) * 50;
Yaxis = (RawData(:,Pixel));
plot(Xaxis,Yaxis)
xlabel('Time (s)')
ylabel('Gyroscope reading deg/s')
end
legend('X', 'Y', 'Z')
%plot all accels
figure
hold on

for idx = 20:22
Pixel = idx;
Xaxis = linspace(1,length(RawData(:,Pixel)),length(RawData(:,Pixel )));
%for AccelZ
%Yaxis = (RawData(:,Pixel) + 9) * 50;
Yaxis = (RawData(:,Pixel));
plot(Xaxis,Yaxis)
end

