% Script to read data straight into array
%port = serialportlist('available');
% still reads with 4ms latency as eariler.

clear all
baud = 115200;
port = serialportlist('available');
%port = "COM5";
arduino = serialport(port,baud);
data = [];
    
while true
    data = [data; readline(arduino)];
end

