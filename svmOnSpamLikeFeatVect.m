% svmOnSpamLikeFeatVect.m - Builds and tests a SVM classifier on the spam 
%                           like feature vector. Assumes spamLikeFeatVect.m
%							was run immediately before this.
%
% CS229 Final Project
% Ethan Chan, Rajashi Roy, John Lee
% {ethancys,rroy,johnwlee}@stanford.edu
% Created: December 5th 2015

Y       = labels;

P       = randperm(sum(numMovies));

recall = zeros(numClass, 10);
precision = zeros(numClass, 10);

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

    for i = 1:numClass
        recall(i, j)    = sum((Ytest == i).*(Ytest == Y_hat_fin))/sum(Ytest == i);
        precision(i, j) = sum((Ytest == i).*(Ytest == Y_hat_fin))/sum(Y_hat_fin == i);
    end

end
recall(isnan(recall)) = 0;
precision(isnan(precision)) = 0;
recall_F = mean(recall, 2);
precision_F = mean(precision, 2);

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
