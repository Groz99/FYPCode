%Script to load data into MATLAB workspace

%DataLocation = 'H:\Tacto\FYPCode\Data_SMALL\';
DataLocation = 'H:\Tacto\Data_LARGE\';
addpath(DataLocation);

DataName = 'Test2_FullSpeed.txt';
Delimiter = ' ';
RawData = importdata(DataName, Delimiter);