% nbLib.m - Uses matlab library instead of doing the math myself. Fulfills the
%           function of nbTrain and nbTest.
%
% CS229 Final Project
% Ethan Chan, Rajashi Roy, John Lee
% {ethancys,rroy,johnwlee}@stanford.edu
% Created: December 5th 2015


%% Select random permutation of movies to form test set and training set
P = randperm(sum(numMovies));

% for j = 1:10
%     P = [P(round(trainOn*sum(numMovies))+1:end) P(1:round(trainOn*sum(numMovies)))]
    trainMatrix = X(P(1:round(trainOn*sum(numMovies))),:);
    trainLabels = labels(P(1:round(trainOn*sum(numMovies))),:);
    testMatrix  = X(P(round(trainOn*sum(numMovies))+1:end),:);
    testLabels  = labels(P(round(trainOn*sum(numMovies))+1:end),:);

    numTestDocs = size(testMatrix, 1);
    nbModel = fitcnb(trainMatrix, trainLabels, 'DistributionNames','mn');
    output  = predict(nbModel, testMatrix);

    % Compute the error on the test set

    error=0;
    for i=1:numTestDocs
        if (testLabels(i) ~= output(i))
            error=error+1;
        end
    end

    %Print out the classification error on the test set
    disp(error/numTestDocs);

    error = 0;
    genreError = zeros(numClass, 1);
    numGenre = zeros(numClass, 1);
    for i=1:numTestDocs
        error = (testLabels(i) ~= output(i));
        genreError(testLabels(i)) = genreError(testLabels(i)) + error;
        numGenre(testLabels(i)) = numGenre(testLabels(i)) + 1;
    end
