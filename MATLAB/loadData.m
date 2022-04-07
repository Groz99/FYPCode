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


addpath(DataLocation);

%DataName = 'Test2_FullSpeed.txt';
%DataName = 'Test3_Pixel comparison.txt';
%DataName = 'Test4_Pixel comparison.txt';
%DataName = 'test7_All_repeatability.txt';
%DataName = 'test6_All.txt'
%DataName = 'test6_All_redo.txt'
%DataName = 'test6_All_redo2.txt'
%DataName = 'test6_All_redo3.txt'
%DataName = 'test8_All_IMU2.txt';
%DataName = 'test9_All_IMU_faster2.txt';
%DataName = 'test10_All_IMU_faster2.txt';
%DataName = 'Test11_1_Calibration2.txt';
%DataName = 'Test11_8_Calibration.txt';
%DataName = 'Test11_9_Calibration.txt';
%DataName = 'Test11_16_Calibration.txt';
%DataName = 'Test12_Pretrain4.txt';
%DataName = 'Test13_Smooth1.txt';%
%DataName = 'Test14_Levelled1.txt';
%DataName = 'Test15_PretrainC.txt';
%DataName = 'Test16_SmoothA.txt';
%DataName = 'Test16_RoughA.txt';
%DataName = 'Test16_LevelledA.txt';
DataName = 'Test16_RidgedA.txt';

Delimiter = ' ';
RawData = importdata(DataName, Delimiter);