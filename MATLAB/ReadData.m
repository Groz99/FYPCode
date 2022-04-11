% Script to read data straight into array
%port = serialportlist('available');
% still reads with 4ms latency as eariler.

%Modified to use the data to plot a heatmap in real time for demo purposes
%Can only run at 2Hz due to MATLAB readline being so slow


%
%WORKING IN 2021b

clear all
%instrreset
%ard = arduino;
baud = 115200;
%port = serialportlist('available');
port = "COM5";

%%%%% 2016 version

%arduino = serial(port,'BaudRate',baud);
%fopen(arduino);
%data = fread(arduino,16)
%data = fscanf(arduino)


%Matlab 2019 onwards..
arduino = serialport(port,baud);
data = [];
    

%Readline does not work on 2018b...

%Run through init
for N = 1:10
    line = readline(arduino)
end


while true
    %data = [data; readline(arduino)];
    line = readline(arduino);
    PRArray = split(line,' ');
    
    Pressuremap = str2double([fliplr(PRArray(1:4)'); PRArray(5:8)'; fliplr(PRArray(9:12)'); PRArray(13:16)']);

    heatmap(Pressuremap,'Colormap',summer)
    caxis([0 500]);
    drawnow
    
end


    

