%Script to load data into MATLAB workspace
clear all

%Campus
%DataLocation = 'H:\Tacto\FYPCode\Data_SMALL\';
%DataLocation = 'H:\Tacto\Data_LARGE\';

%Home PC 
%DataLocation = 'F:\UNI year 4\Tacto FYP\Data_LARGE'
DataLocation =  'F:\UNI year 4\Tacto FYP\FYPCode\Data_SMALL'

%Laptop?

addpath(DataLocation);

%DataName = 'Test2_FullSpeed.txt';
%DataName = 'Test3_Pixel comparison.txt';
%DataName = 'Test4_Pixel comparison.txt';
DataName = 'test7_All_repeatability.txt';


Delimiter = ' ';
RawData = importdata(DataName, Delimiter);