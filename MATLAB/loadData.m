%Script to load data into MATLAB workspace


%Campus
%DataLocation = 'H:\Tacto\FYPCode\Data_SMALL\';
%DataLocation = 'H:\Tacto\Data_LARGE\';

%Home PC 
DataLocation = 'F:\UNI year 4\Tacto FYP\Data_LARGE'

%Laptop?

addpath(DataLocation);

DataName = 'Test2_FullSpeed.txt';
Delimiter = ' ';
RawData = importdata(DataName, Delimiter);