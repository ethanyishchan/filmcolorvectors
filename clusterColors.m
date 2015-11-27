% clusterColors.m - Finds k centroids in the RGB space that are most common in 
%                   the dataset.
% CS229 Final Project
% Ethan Chan, Rajashi Roy, John Lee
% {ethancys,rroy,johnwlee}@stanford.edu
% Created: November 26th 2015

%% Script Parameters
k = 64;
dataDirs = {'movie_categories/horror'; 'movie_categories/action'; ...
    'movie_categories/animation'; 'movie_categories/everything_else'; ...
    'movie_categories/romance'};
baseDir  = pwd;
%% Counting the number of datapoints available
numMovies   = 0;
X           = zeros(0,3);
for d = 1:size(dataDirs, 1)
    cd(dataDirs{d});
    D = dir();
    for i = 1:length(D)
        if (length(D(i).name) >= 4) && strcmpi(D(i).name(end-3:end), ...
                '.txt')
            numMovies = numMovies + 1;
            movName = D(i).name(1:end-4);
            featVect = load(D(i).name);
            X = [X ; featVect];
        end
    end
    cd(baseDir);
end

[idx, C] = kmeans(X, k, 'MaxIter', 500);