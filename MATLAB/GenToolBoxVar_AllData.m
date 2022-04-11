%Script to generate data suitable for the matlab classifier toolbox

%Generates a simpler version of the data that can be universally applied

%Data is formatted as: 

% [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 X Y Z A B G Temp Time] X Binwidth
% with class at the end

% i.e. each element is 24,000 + 1 long


clear all

TriggerPixel = 1; %First PR element that gets introduced to curve

NumWindows = 200;

DataLocation = 'H:\Tacto\FYPCode\Data_SMALL';

%ROS PC
%DataLocation = '/u/n/rrb32/Tacto/FYPCode/Data_SMALL';

%Classes
%
%1 - Smooth 
%2 - Levelled
%3 - Ridged
%4 - Rough

DataStack = [];


for Class = 1:4
    
    % RUN FOR TEST 16, 18, 19
    
    switch Class
        case 1 
            DataName = 'Test21_SmoothA_COMB16_18_19_20.txt';%
        case 2 
            DataName = 'Test21_LevelledA_COMB16_18_19_20.txt';%
        case 3 
            DataName = 'Test21_RidgedA_COMB16_18_19_20.txt';%
        case 4 
            DataName = 'Test21_RoughA_COMB16_18_19_20.txt';%
        otherwise 
            disp('ERROR')
            break
    end
    RawData = loadDataFunc(DataLocation,DataName);
    DataStack = [DataStack ; RawData];
    DataLength(Class) = length(RawData);
    %IndexMat = [];
    IndexMat(Class,:) = zeros(1,NumWindows + 1);
    IndexCount = 1;
    
    for N = 1 : length(RawData)    
        if RawData(N,TriggerPixel) > 0 && ((N - max(IndexMat(Class,:))) > 800 || sum(IndexMat(Class,:)) == 0)  
            %IndexMat(Class,:) = [IndexMat(Class,:) N];
            IndexMat(Class,IndexCount) = N;
            IndexCount = IndexCount+1;
        end

        if IndexCount > NumWindows + 1
            %IndexMat(1) = '';   
            break
        end    
    end
end

%Remove extra data element
IndexMat(:,end) = '';   


%GENERATES:

%IndexMat:
% Class1: Index 1.... Index 50
% Class2: Index 1.... Index 50
% Class3: Index 1.... Index 50
% Class4: Index 1.... Index 50

%increase later indexes so they are the sames as if gathered simultaneously
% i.e. if all data is 1000 samples, index 3 in data 2 will be 1003, index
% 74 in data 3 will be 2074

IndexMat(1,:) = IndexMat(1,:);
IndexMat(2,:) = IndexMat(2,:) + DataLength(1);
IndexMat(3,:) = IndexMat(3,:) + DataLength(1) + DataLength(2);
IndexMat(4,:) = IndexMat(4,:) + DataLength(1) + DataLength(2) + DataLength(3);

%Sort into one long Vector with format

% Index: 1, 2, 3, 4...
% Class: 1, 1, 1, 1... 



% USE THIS TO REMOVE A CERTAIN SET. HERE REMOVES 1
%%%%%%%%%%
IndexMatLong(1,:) = [IndexMat(1,:) IndexMat(2,:) IndexMat(3,:) IndexMat(4,:)];
%IndexMatLong(1,:) = [IndexMat(2,:) IndexMat(3,:) IndexMat(4,:)];
%%%%%%%%%%


IndexMatLong(2,:) = zeros(1,length(IndexMatLong(1,:)));


% USE THIS TO REMOVE A CERTAIN SET. HERE REMOVES 1
%%%%%%%%%%
%for N = 2:4
%    IndexMatLong(2,(N-1)*50+1:N * NumWindows) = N; % add class label 
%end
%IndexMatLong(:,1:50) = '';

for N = 1:4
    IndexMatLong(2,(N-1)*NumWindows+1:N * NumWindows) = N; % add class label 
end







%%%%%%%%%%

%Sort randomly to make suitable for insertion into MLP:
randomseq = randperm(length(IndexMatLong));
for N = 1:length(randomseq)
    IndexMatRand(:,N) = IndexMatLong(:,randomseq(N));
end


%Generate stack of reading data;
%Data formed as:
% PR 1 : 16,  X, Y, Z, A, B, G, Temp, Time,
% With index going down

%Optional - Remove temperature and timestamp
DataStackShort = DataStack(:,1:22);

%REMOVE NANS

for N = 1 : length(DataStack)
    if sum(isnan(DataStack(N,:))) > 0
        DataStack(N,:) = DataStack(N-1,:);
        
    end
end

BinWidth = 1000;
%Need to subsample somehow

DataStackSub = downsample(DataStackShort,10);


for N = 1 : length(IndexMatLong)
    Spikestart = IndexMatRand(1,N);
    Class = IndexMatRand(2,N);
    
    % NO ' gives 11, 11, 11.... to N Binwidth
    DataWide(N,:) = [reshape(DataStack(Spikestart:Spikestart + BinWidth-1,:),1,[]) Class];
    DataWideShort(N,:) = [reshape(DataStackShort(Spikestart:Spikestart + BinWidth-1,:),1,[]) Class];
    DataWideSub(N,:) = [reshape(DataStackSub(Spikestart/10:Spikestart/10 + BinWidth/10-1,:),1,[]) Class];
   
    % ' Gives 11, 12, 13 .... to Time X N Binwidth
    %DataWide(N,:) = [reshape(DataStack(Spikestart:Spikestart + BinWidth-1,:)',1,[]) Class];
    
end

DataWideSub_PR = [DataWideSub(:,1:1600) DataWideSub(:,2201)] ;
DataWideSub_IMU = [DataWideSub(:,1601:2200) DataWideSub(:,2201)] ;
DataWideSub_Gyro = [DataWideSub(:,1601:1900) DataWideSub(:,2201)] ;
DataWideSub_Accell = [DataWideSub(:,1901:2200) DataWideSub(:,2201)] ;




