% determineCosineSimilarity.m - This script computes the angle between the
%                               feature vectors of different movies. This
%                               was primarily driven by a need to verify
%                               that the two different methods of
%                               generating datapoints were comparable.
% CS229 Final Project
% Ethan Chan, Rajashi Roy, John Lee
% {ethancys,rroy,johnwlee}@stanford.edu
% Created: November 9th 2015

%% Script Parameters
dataDirs = {'movie_vectors'; 'netflix_vectors'; 'netflix_vectors/Horror'};
baseDir  = pwd;

numSamples = 200;
k = 4;

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
    cd(baseDir);
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
    cd(baseDir);
end

%% Specify movie of interest
movInterest = 'ForrestGumpNetflixCmp';
index = find(not(cellfun('isempty', strfind(movieNames, movInterest))));
result = zeros(numMovies, 1);
for i = 1:size(X, 1);
    result(i) = dot(X(i,:), X(index, :))/(norm(X(i,:))*norm(X(index,:)));
end

%% Print names of 5 most similar movies
sortedResult = sort(result);
disp(movieNames{(result == sortedResult(end-1))});
disp(movieNames{(result == sortedResult(end-2))});
disp(movieNames{(result == sortedResult(end-3))});
disp(movieNames{(result == sortedResult(end-4))});
disp(movieNames{(result == sortedResult(end-5))});