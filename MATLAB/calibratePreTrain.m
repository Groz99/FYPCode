%Script to use a number of datasets to calibrate the sensor before the
%training process
%To be used to assess the benefit of a priori data in the texture
%classification problem

%Just for piezoresistive elements first

%For on campus
DataLocation = 'H:\Tacto\FYPCode\Data_SMALL\';

DataName = 'Test15_PreTrainA.txt';
PreData1 = loadDataFunc(DataLocation, DataName);
DataName = 'Test15_PreTrainB.txt';
PreData2 = loadDataFunc(DataLocation, DataName);
DataName = 'Test15_PreTrainC.txt';
PreData3 = loadDataFunc(DataLocation, DataName);



PixelMaxes1 = [];
PixelMaxes2 = [];
PixelMaxes3 = [];

for N = 1 : 16
    MaxVal = max(PreData1(:,N))  % Loop through each pixel
    %MaxVal = max(RawData(:,N))  % Loop through each pixel
    PixelMaxes1(N) = MaxVal;
end

for N = 1 : 16
    MaxVal = max(PreData2(:,N))  % Loop through each pixel
    %MaxVal = max(RawData(:,N))  % Loop through each pixel
    PixelMaxes2(N) = MaxVal;
end

for N = 1 : 16
    MaxVal = max(PreData2(:,N))  % Loop through each pixel
    %MaxVal = max(RawData(:,N))  % Loop through each pixel
    PixelMaxes3(N) = MaxVal;
end


PixelMaxesAv = []

for N = 1:16
    MaxVal = mean([PixelMaxes1(N),PixelMaxes2(N),PixelMaxes3(N)]);
    PixelMaxesAv(N) = MaxVal;
end

MaxVal = max(PixelMaxesAv);
%Normalise all maximum values, this will be used as a scale factor for ALL
%pixels

for N = 1:16
    CalibrationVec(N) =  MaxVal/PixelMaxesAv(N);
end

%CalibrationVec(2) * all readings for Pixel(2)...

