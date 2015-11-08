% kMeans.m - Script to perform k-means clustering of the feature vectors
%            obtained from movies.
% CS229 Final Project
% Ethan Chan, Rajashi Roy, John Lee
% {ethancys,rroy,johnwlee}@stanford.edu
% Created: November 7th 2015

%% Script Parameters
numSamples = 200;
k = 2;

%% Loading feature vectors into matlab
D = dir();
numMovies = 0;
for i = 1:length(D)
    if (length(D(i).name) >= 4) && strcmpi(D(i).name(end-3:end), '.txt')
        numMovies = numMovies + 1;
    end
end

%% 
movieNames = cell(numMovies, 1);
X = zeros(numMovies, 3*numSamples);

movNum = 1;
for i = 1:length(D)
    if (length(D(i).name) >= 4) && strcmpi(D(i).name(end-3:end), '.txt')
        movName = D(i).name(1:end-4);
        featVect = load(D(i).name);
        featVectStdLen = resample(featVect, numSamples, length(featVect));
        movieNames(movNum) = cellstr(movName);
        X(movNum,:) = reshape(featVectStdLen', 3*numSamples, 1);
        movNum = movNum + 1;
    end
end

idx = kmeans(X, k);
        