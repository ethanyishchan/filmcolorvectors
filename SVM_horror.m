% kMeans.m - Script to perform k-means clustering of the feature vectors
%            obtained from movies.
% CS229 Final Project
% Ethan Chan, Rajashi Roy, John Lee
% {ethancys,rroy,johnwlee}@stanford.edu
% Created: November 7th 2015








%% Script Parameters
numSamples = 200;
k = 4;
dataDirs = {'movie_vectors'; 'movie_vectors_2'};

%% Counting the number of datapoints available
numMovies = 0;
for d = 1:size(dataDirs, 1)
    cd(dataDirs{d});
    D = dir();
    for i = 1:length(D)
        if (length(D(i).name) >= 4) && strcmpi(D(i).name(end-3:end), ...
                '.txt')
            numMovies = numMovies + 1;
        end
    end
    cd('..');
end

%% Loading feature vectors into matlab, resampling to ensure uniform length
movieNames = cell(numMovies, 1);
X = zeros(numMovies, (3*numSamples));

movNum = 1;
for d = 1:size(dataDirs, 1)
    cd(dataDirs{d});
    D = dir();
    for i = 1:length(D)
        if (length(D(i).name) >= 4) && strcmpi(D(i).name(end-3:end), '.txt')
            movName = D(i).name(1:end-4);
            featVect = load(D(i).name);
            featVectStdLen = resample(featVect, numSamples, length(featVect));
            movieNames(movNum) = cellstr(movName);
            %temp = reshape(featVectStdLen', 3*numSamples, 1);
            %temp = temp*temp';
            %X(movNum,:) = reshape(temp, (3*numSamples)^2, 1);
            X(movNum, :) = reshape(featVectStdLen', 3*numSamples, 1);
            movNum = movNum + 1;
        end
    end
    cd('..');
end

idx = kmeans(X, k);
        