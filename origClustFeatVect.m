% originalFeatVect.m - This script creates an interpolated feature vector 
%
%                      Corresponding movie names stored in variable movieNames
%
% CS229 Final Project
% Ethan Chan, Rajarshi Roy, John Lee
% {ethancys,rroy,johnwlee}@stanford.edu
% Created: December 7th 2015

%% Script Parameters
trainOn    = 0.9; %We will train the NB model on 90% of data, and test on 10%
numClass   = 4;
class1Dirs = {'horror'};
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
k = size(C, 1); % What feature length to extrapolate color vector to
movieNames = cell(sum(numMovies), 1);
X = zeros(sum(numMovies), k*3);
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
                featVect = load(D(i).name); % Unextrapolated feature vector
                featVectStdLen = resample(featVect, k, length(featVect)); % Extrapolate
                featVectStdLen = max(featVectStdLen,0);   % Clamp
                featVectStdLen = min(featVectStdLen,256); % Clamp
                idx = knnsearch(C, featVectStdLen);
                X(movNum, 1:k) = idx; %Columnize
                labels(movNum) = (class);
                movNum = movNum + 1;
            end
        end
        cd(baseDir);
    end
end


