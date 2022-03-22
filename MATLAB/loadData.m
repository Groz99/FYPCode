%Script to load data into MATLAB workspace

DataLocation = 'H:\Tacto\FYPCode\Data_SMALL\';
addpath(DataLocation);

DataName = 'Test1Data.txt';
Delimiter = ' ';
RawData = importdata(DataName, Delimiter);