%Script to load data into MATLAB workspace


%Campus
DataLocation = 'H:\Tacto\FYPCode\Data_SMALL\';
%DataLocation = 'H:\Tacto\Data_LARGE\';

%Home PC 
%DataLocation = 'F:\UNI year 4\Tacto FYP\Data_LARGE'

%Laptop?

addpath(DataLocation);

%DataName = 'Test2_FullSpeed.txt';
%DataName = 'Test3_Pixel comparison.txt';
DataName = 'Test4_Pixel comparison2.txt';
DataName = 'Test4_PC.txt';

Delimiter = ' ';
RawData = importdata(DataName, Delimiter);