%Script to slide data along for one pixel

%This script uses manual inspection of crossover point 


% Analyse full trace for pixel of choice

Pixel = 8;
Xaxis = linspace(1,length(RawData(:,Pixel)),length(RawData(:,Pixel )));
Yaxis = RawData(:,Pixel) ;
figure
plot(Xaxis,Yaxis)

%Plot thick red lines to separate readings
C1 = 20000;
C2 = 39500;
Red1X = [C1 C1];
Red2X = [C2 C2];
Red1Y = [0 1000];
Red2Y = [0 1000];
hold on
plot(Red1X,Red1Y,'r','linewidth',3)
plot(Red2X,Red2Y,'r','linewidth',3)
%Z axis accell is 22
%From 16 is alpha, beta, gamma, x,y,z


hold on
Pixel = 17;
Xaxis = linspace(1,length(RawData(:,Pixel)),length(RawData(:,Pixel )));
%for AccelZ
%Yaxis = (RawData(:,Pixel) + 9) * 50;
Yaxis = (RawData(:,Pixel));
plot(Xaxis,Yaxis)


%plot all gyros
figure
hold on

for idx = 17:19
Pixel = idx;
Xaxis = linspace(1,length(RawData(:,Pixel)),length(RawData(:,Pixel )));
%for AccelZ
%Yaxis = (RawData(:,Pixel) + 9) * 50;
Yaxis = (RawData(:,Pixel));
plot(Xaxis,Yaxis)
end

%plot all accels
figure
hold on

for idx = 20:22
Pixel = idx;
Xaxis = linspace(1,length(RawData(:,Pixel)),length(RawData(:,Pixel )));
%for AccelZ
%Yaxis = (RawData(:,Pixel) + 9) * 50;
Yaxis = (RawData(:,Pixel));
plot(Xaxis,Yaxis)
end

%{
%Crossover appears at 20000, 39500
C1 = 20000;
C2 = 39500;
Pixel = 8;

% 3 segments of data
Seg1 = RawData(1:C1,:);
Seg2 = RawData(C1+1:C2,:);
Seg3 = RawData(C2+1:end,:);

%Must be same length as RawData
%Chklngth = [Seg1; Seg2; Seg3];


%%% Sloppy but simple 

Threshold = 20;

for idx = 1:length(Seg1(:,Pixel))
    if Seg1(idx,Pixel) > Threshold
       Trigger1 = idx;
       break
    end
end

for idx = 1:length(Seg2(:,Pixel))
    if Seg2(idx,Pixel) > Threshold
       Trigger2 = idx;
       break
    end
end

for idx = 1:length(Seg3(:,Pixel))
    if Seg3(idx,Pixel) > Threshold
       Trigger3 = idx;
       break
    end
end

%
%Cannot be too large
preTrig = 500;


Seg1 = Seg1(Trigger1 - preTrig:end,Pixel);
Seg2 = Seg2(Trigger2 - preTrig:end,Pixel);
Seg3 = Seg3(Trigger3 - preTrig:end,Pixel);

%normalise length
%assume seg3 largest

Seg1 = [Seg1 ; zeros(length(Seg3) - length(Seg1),1)];
Seg2 = [Seg2 ; zeros(length(Seg3) - length(Seg2),1)];
Seg3 = [Seg3];

%Using lowpass filter
lowpassF = 0.9;
Seg1F = lowpass(Seg1,lowpassF);
Seg2F = lowpass(Seg2,lowpassF);
Seg3F = lowpass(Seg3,lowpassF);


figure
hold on
Xaxis = linspace(1,length(Seg3),length(Seg3));
plot(Xaxis,Seg1','LineWidth',0.5)
plot(Xaxis,Seg2','LineWidth',0.5)
plot(Xaxis,Seg3','LineWidth',0.5)

title('Pixel responses')
ylabel('Sensor count')
xlabel('Samples')
legend('Frame 1', 'Frame 2', 'Frame 3')

%{
figure
hold on
Xaxis = linspace(1,length(Seg3),length(Seg3));
plot(Xaxis,Seg1F','LineWidth',0.5)
plot(Xaxis,Seg2F','LineWidth',0.5)
plot(Xaxis,Seg3F','LineWidth',0.5)

legend('Frame 1', 'Frame 2', 'Frame 3')

%}

%}

