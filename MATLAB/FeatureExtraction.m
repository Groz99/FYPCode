%Use inbuilt functions to examine features

%Run GenToolBoxVar_AllData.m first

%All predictors
X = DataWideSub(:,1:2200);
Y = DataWideSub(:,2201);


[idx,scores] = fscchi2(X,Y);

bar(scores(idx))
xlabel('Predictor rank')
ylabel('Predictor importance score')

ScoresPerSource = []
M=1;

for N = 1 :  100 : length(scores) - 99 

   
scoreav(M) = mean(scores(N:N+99))

M = M + 1;
end

bar(scoreav)

%Most important seem to be pixel 11,12 and 18 (Gyro Y).