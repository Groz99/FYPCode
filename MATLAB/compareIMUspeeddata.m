%Script to load data into MATLAB workspace
clear all

%Campus
DataLocation = 'H:\Tacto\FYPCode\Data_SMALL\';
%DataLocation = 'H:\Tacto\Data_LARGE\';

%Home PC 
%DataLocation = 'F:\UNI year 4\Tacto FYP\Data_LARGE'
%DataLocation =  'F:\UNI year 4\Tacto FYP\FYPCode\Data_SMALL';

%Laptop
%DataLocation = 'D:\TACTO FYP\CoolTerm logs';

addpath(DataLocation)


Pixel = 8;

%Test 8

DataName = 'test8_All_IMU2.txt';
Delimiter = ' ';
RawData = importdata(DataName, Delimiter);

figure
hold on

for idx = 17:19
Pixel = idx;
Xaxis = linspace(1,length(RawData(:,Pixel)),length(RawData(:,Pixel )));
%for AccelZ
%Yaxis = (RawData(:,Pixel) + 9) * 50;
Yaxis = (RawData(:,Pixel));
plot(Xaxis,Yaxis)
end

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

%Test 9 

DataName = 'test9_All_IMU_faster2.txt';
Delimiter = ' ';
RawData = importdata(DataName, Delimiter);

figure
hold on

for idx = 17:19
Pixel = idx;
Xaxis = linspace(1,length(RawData(:,Pixel)),length(RawData(:,Pixel )));
%for AccelZ
%Yaxis = (RawData(:,Pixel) + 9) * 50;
Yaxis = (RawData(:,Pixel));
plot(Xaxis,Yaxis)
end

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

%Test 10 

DataName = 'test10_All_IMU_faster2.txt';
Delimiter = ' ';
RawData = importdata(DataName, Delimiter);

figure
hold on

for idx = 17:19
Pixel = idx;
Xaxis = linspace(1,length(RawData(:,Pixel)),length(RawData(:,Pixel )));
%for AccelZ
%Yaxis = (RawData(:,Pixel) + 9) * 50;
Yaxis = (RawData(:,Pixel));
plot(Xaxis,Yaxis)
end

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

