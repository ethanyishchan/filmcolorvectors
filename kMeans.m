% kMeans.m - Script to perform k-means clustering of the feature vectors
%            obtained from movies.
% CS229 Final Project
% Ethan Chan, Rajashi Roy, John Lee
% {ethancys,rroy,johnwlee}@stanford.edu
% Created: November 7th 2015

%% Script Parameters
numSamples = 200;
k = 4;

cd('movie_vectors');

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
X = zeros(numMovies, (3*numSamples)^2);

movNum = 1;
for i = 1:length(D)
    if (length(D(i).name) >= 4) && strcmpi(D(i).name(end-3:end), '.txt')
        movName = D(i).name(1:end-4);
        featVect = load(D(i).name);
        featVectStdLen = resample(featVect, numSamples, length(featVect));
        movieNames(movNum) = cellstr(movName);
        temp = reshape(featVectStdLen', 3*numSamples, 1);
        temp = temp*temp';
        X(movNum,:) = reshape(temp, (3*numSamples)^2, 1);
        movNum = movNum + 1;
    end
end

idx = kmeans(X, k);
cd('..');
        