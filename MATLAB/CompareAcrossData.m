%Need to load data for testing i.e. 19 etc... from GenToolBoxVar
%Need to also load in trainedModel struct from file


yfit = trainedModel_18.predictFcn(DataWideSub(:,1:2200));
compare = [DataWideSub(:,2201) yfit];


% compare is [TRUE, PREDICT]

%Plot confusion matrix from compare:

confmat = zeros(4);

for N = 1: length(compare)
    confmat(compare(N,1),compare(N,2)) = confmat(compare(N,1),compare(N,2)) + 1;
end

%confmat structure is 

%       Pred1 Pred2 Pred3 Pred4
% True1
% True2
% True3
% True4


% 16 to 18 is very good
% 18 to 19 is worse... despite being seated at the same time

% do one more for reseated etc...
