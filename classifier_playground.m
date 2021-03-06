% svmClassifier.m - Script to run a basic 2 class svm on the data.
%                   Initially the classes are Horror vs Non-horror.
% CS229 Final Project
% Ethan Chan, Rajashi Roy, John Lee
% {ethancys,rroy,johnwlee}@stanford.edu
% Created: November 12th 2015

numSamples = 200;
class1Dirs = {'movie_categories/horror'};
class2Dirs = {'movie_categories/action'; 'movie_categories/animation'; ...
    'movie_categories/everything_else'; 'movie_categories/romance'};
baseDir    = pwd;

numMovies = zeros(2, 1);
for class = 1:2
    if (class == 1)
        dataDirs = class1Dirs;
    elseif (class == 2)
        dataDirs = class2Dirs;
    end
    for d = 1:size(dataDirs, 1)
        cd(dataDirs{d});
        D = dir();
        for i = 1:length(D)
            if (length(D(i).name) >= 4) && strcmpi(D(i).name(end-3:end),...
                    '.txt')
                numMovies(class) = numMovies(class) + 1;
            end
        end
        cd(baseDir);
    end
end

%%
movieNames = cell(sum(numMovies), 1);
X = zeros(sum(numMovies), (3*numSamples));
Y = zeros(sum(numMovies), 1);

movNum = 1;
for class = 1:2;
    if (class == 1)
        dataDirs = class1Dirs;
    elseif (class == 2)
        dataDirs = class2Dirs;
    end
    for d = 1:size(dataDirs, 1)
        cd(dataDirs{d});
        D = dir();
        for i = 1:length(D)
            if (length(D(i).name) >= 4) && strcmpi(D(i).name(end-3:end),...
                    '.txt')
                movName = D(i).name(1:end-4);
                featVect = load(D(i).name);
                featVectStdLen = resample(featVect, numSamples, length(featVect));
                movieNames(movNum) = cellstr(movName);
                X(movNum, :) = reshape(featVectStdLen', 3*numSamples, 1);
                Y(movNum) = class;
                movNum = movNum + 1;
            end
        end
        cd(baseDir);
    end
end

Y = not(Y-1); % Shifting labels to be 1 if horror, 0 otherwise
%%
trainOn = 0.9; % of total data
testResults  = zeros(100,5);
trainResults = zeros(100,5);
for n = 1:100
    P = randperm(sum(numMovies));
    Xtrain = X(P(1:round(trainOn*sum(numMovies))),:);
    Ytrain = Y(P(1:round(trainOn*sum(numMovies))),:);
    Xtest  = X(P(1+round(trainOn*sum(numMovies)):end),:);
    Ytest  = Y(P(1+round(trainOn*sum(numMovies)):end),:);
    model  = fitcsvm(Xtrain,Ytrain, 'KernelFunction', 'linear');
%     model  = fitcsvm(Xtrain,Ytrain, 'KernelFunction', 'polynomial', ...
%         'PolynomialOrder', 3);
    Y_hat  = predict(model, Xtest);
    testResults(n,:) = [sum(Ytest) sum(Y_hat) sum(Ytest-Y_hat==1) ...
        sum(Ytest-Y_hat == -1) sum(abs(Ytest-Y_hat))/size(Ytest,1)];
    Y_ep   = predict(model, Xtrain);
    trainResults(n,:) = [sum(Ytrain) sum(Y_ep) sum(Ytrain-Y_ep==1) ...
        sum(Ytrain-Y_ep == -1) sum(abs(Ytrain-Y_ep))/size(Ytrain,1)];
end