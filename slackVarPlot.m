% BoxConstraint
%
% CS229 Final Project
% Ethan Chan, Rajashi Roy, John Lee
% {ethancys,rroy,johnwlee}@stanford.edu
% Created: December 13th 2015

load('2015_12_10_Centroid_512.mat');
CHWDFeatVect;

Y       = labels;

P       = randperm(sum(numMovies));

tic;

c_array = logspace(0,3);
for k = 1:length(c_array);
for j = 1:10
    P       = [P(1+round(0.9*sum(numMovies)):end) P(1:round(trainOn*sum(numMovies)))];
    Xtrain  = X(P(1:round(trainOn*sum(numMovies))),:);
    Ytrain  = Y(P(1:round(trainOn*sum(numMovies))),:);
    Xtest   = X(P(1+round(0.9*sum(numMovies)):end),:);
    Ytest   = Y(P(1+round(0.9*sum(numMovies)):end),:);

    for i = 1:numClass
        Yclass  = (Ytrain == i);
        model{i}= fitcsvm(Xtrain,Yclass, 'KernelFunction', 'linear', 'BoxConstraint', 10);
    end

    Y_hat = zeros(size(Xtest, 1), numClass);
    S_hat = zeros(size(Xtest, 1), numClass);
    Y_ep  = zeros(size(Xtrain, 1), numClass);
    S_ep  = zeros(size(Xtrain, 1), numClass);
    %%
    for i = 1:numClass
        [Y_hat(:,i), score_hat]   = predict(model{i}, Xtest);
        [Y_ep(:,i) , score_ep ]   = predict(model{i}, Xtrain);
        S_hat(:,i) = score_hat(:,2);
        S_ep(:,i) = score_ep(:,2);
    end

    %%
    [~, Y_hat_fin] = max(S_hat, [], 2);
    [~, Y_ep_fin] = max(S_ep, [], 2);

    genEr(j) = 1-sum(Ytest  == Y_hat_fin)/length(Ytest);
    trnEr(j) = 1-sum(Ytrain == Y_ep_fin)/length(Ytrain);

end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% Is this the way that we want to deal with NaN's? %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


toc;
% beep

% for i = 1:50
%     for n = 1:500
%         P       = randperm(sum(numMovies));
%         Xtrain 	= X2(P(1:round(trainOn*sum(numMovies))),:);
%         Ytrain 	= Y(P(1:round(trainOn*sum(numMovies))),:);
%         Xtest  	= X2(P(1+round(0.9*sum(numMovies)):end),:);
%         Ytest  	= Y(P(1+round(0.9*sum(numMovies)):end),:);
%         model   = fitcsvm(Xtrain,Ytrain, 'KernelFunction', 'linear', 'BoxConstraint', i);
%         Y_hat   = predict(model, Xtest);
%         Y_ep    = predict(model, Xtrain);
%         testErr(n)  = sum(abs(Ytest-Y_hat))/size(Ytest,1);
%         trainErr(n) = sum(abs(Ytrain-Y_ep))/size(Ytrain,1);

%         % testResults(i, :) = [sum(Ytest) sum(Y_hat) sum(Ytest-Y_hat==1) ...
%         %     sum(Ytest-Y_hat == -1) sum(abs(Ytest-Y_hat))/size(Ytest,1)];
        
%         % trainResults(i, :) = [sum(Ytrain) sum(Y_ep) sum(Ytrain-Y_ep==1) ...
%         %     sum(Ytrain-Y_ep == -1) sum(abs(Ytrain-Y_ep))/size(Ytrain,1)];

%     end
%     testResults(i) = mean(testErr);
%     trainResults(i) = mean(trainErr);
% end

% clf;
% plot(1:100, testResults);
% hold on;
% plot(1:100, trainResults);
% legend('Test error', 'Training error');
% xlabel('Box Constraint');
% ylabel('Percentage error');
% print('-dpng', 'SVM_ErrorVSBoxConstraint.png');
