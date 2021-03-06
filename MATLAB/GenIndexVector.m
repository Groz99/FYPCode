%Script to preprocess the slide data into windows for access by ML algoritm

clear all

TriggerPixel = 1; %First PR element that gets introduced to curve

NumWindows = 50;

DataLocation = 'H:\Tacto\FYPCode\Data_SMALL';


%Classes
%
%1 - Smooth 
%2 - Levelled
%3 - Ridged
%4 - Rough

DataStack = [];

for Class = 1:4
    
    
    
    switch Class
        case 1 
            DataName = 'Test16_SmoothA.txt';%
        case 2 
            DataName = 'Test16_LevelledA.txt';%
        case 3 
            DataName = 'Test16_RidgedA.txt';%
        case 4 
            DataName = 'Test16_RoughA.txt';%
        otherwise 
            disp('ERROR')
            break
    end
    RawData = loadDataFunc(DataLocation,DataName);
    DataStack = [DataStack ; RawData];
    DataLength(Class) = length(RawData);
    %IndexMat = [];
    IndexMat(Class,:) = zeros(1,51);
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
    IndexMatLong(2,(N-1)*50+1:N * NumWindows) = N; % add class label 
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


%REMOVE NANS

for N = 1 : length(DataStack)
    if sum(isnan(DataStack(N,:))) > 0
        DataStack(N,:) = DataStack(N-1,:);
        
    end
end

DataStackShort = DataStack(:,1:22);

%test capture
%{
Xaxis = linspace(1,length(RawData(:,TriggerPixel)),length(RawData(:,TriggerPixel))); % SAMPLE
Yaxis = RawData(:,TriggerPixel);
figure
plot(Xaxis,Yaxis)
hold on 

Xaxis2 = linspace(1,length(RawData(:,TriggerPixel)),length(RawData(:,TriggerPixel)));
Yaxis2 = zeros(length(RawData(:,TriggerPixel)),1);

for N = 1 : NumWindows
    
    Yaxis2(IndexMat(N)) = 100;
end
plot(Xaxis2,Yaxis2)
%}

