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
numClass   = 4;
class1Dirs = {'horror'};
% class2Dirs = {'movie_categories/action'; 'movie_categories/animation'; ...
%     'movie_categories/everything_else'; 'movie_categories/romance'};
class2Dirs = {'animation'};
class3Dirs = {'romance'};
class4Dirs = {'action'};

baseDir    = pwd;

%% Counting the number of datapoints available
numMovies = zeros(numClass, 1);
for class = 1:numClass
    if (class == 1)
        dataDirs = class1Dirs;
    elseif (class == 2)
        dataDirs = class2Dirs;
    elseif (class == 3)
        dataDirs = class3Dirs;
    elseif (class == 4)
        dataDirs = class4Dirs;
    end
    for d = 1:size(dataDirs, 1)
        cd(['movie_categories/' dataDirs{d}]);
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
X = zeros(sum(numMovies), k+1);
labels = zeros(sum(numMovies), 1);

movNum = 1;
for class = 1:numClass;
    if (class == 1)
        dataDirs = class1Dirs;
    elseif (class == 2)
        dataDirs = class2Dirs;
    elseif (class == 3)
        dataDirs = class3Dirs;
    elseif (class == 4)
        dataDirs = class4Dirs;
    end
    for d = 1:size(dataDirs, 1)
        cd(['movie_categories/' dataDirs{d}]);
        D = dir();
        for i = 1:length(D)
            if (length(D(i).name) >= 4) && strcmpi(D(i).name(end-3:end), '.txt')
                movName = D(i).name(1:end-4);
                movieNames(movNum) = cellstr(movName);
                featVect = load(D(i).name);
                idx = knnsearch(C, featVect);
                X(movNum, 1:k) = histcounts(idx, k);
                X(movNum, k+1) = round(load([baseDir '/movie_dynamics/' dataDirs{d} '/' D(i).name]));
                labels(movNum) = (class);
                movNum = movNum + 1;
            end
        end
        cd(baseDir);
    end
end


