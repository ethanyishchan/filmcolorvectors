% spamLikeFeatVect.m - This script creates a new feature vector that counds the
%                      number of times a certain color appears in the movie, and
%                      tabulates it in a matrix. 
%
%                      Corresponding movie names stored in variable movieNames
%
%                      Note: Script assumes clusterColors was run before this,
%                      that is, variable 'C' (centroid locations) is loaded in
%                      workspace.
% CS229 Final Project
% Ethan Chan, Rajashi Roy, John Lee
% {ethancys,rroy,johnwlee}@stanford.edu
% Created: November 27th 2015

%% Script Parameters
trainOn    = 0.9; %We will train the NB model on 90% of data, and test on 10%
class1Dirs = {'movie_categories/horror'};
class2Dirs = {'movie_categories/action'; 'movie_categories/animation'; ...
    'movie_categories/everything_else'; 'movie_categories/romance'};
baseDir    = pwd;

%% Counting the number of datapoints available
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

%% Loading raw data into matlab, creating new feature vector
k = size(C, 1);
movieNames = cell(sum(numMovies), 1);
X = zeros(sum(numMovies), k);
labels = zeros(sum(numMovies), 1);

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
            if (length(D(i).name) >= 4) && strcmpi(D(i).name(end-3:end), '.txt')
                movName = D(i).name(1:end-4);
                movieNames(movNum) = cellstr(movName);
                featVect = load(D(i).name);
                idx = knnsearch(C, featVect);
                X(movNum, :) = histcounts(idx, k);
                labels(movNum) = (class == 1);
                movNum = movNum + 1;
            end
        end
        cd(baseDir);
    end
end

%% Select random permutation of movies to form test set and training set
P = randperm(sum(numMovies));
trainMatrix = X(P(1:round(trainOn*sum(numMovies))),:);
trainLabels = labels(P(1:round(trainOn*sum(numMovies))),:);
testMatrix  = X(P(round(trainOn*sum(numMovies)))+1:end,:);
testLabels  = labels(P(round(trainOn*sum(numMovies)))+1:end,:);
