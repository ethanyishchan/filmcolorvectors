% clusterColors.m - Finds k centroids in the RGB space that are most common in 
%                   the dataset.
% CS229 Final Project
% Ethan Chan, Rajashi Roy, John Lee
% {ethancys,rroy,johnwlee}@stanford.edu
% Created: November 26th 2015

%% Script Parameters
kArray = [64, 128, 256, 512];
for i = 1:length(kArray)
    k = kArray(i);
    dataDirs = {'movie_categories/horror'; 'movie_categories/action'; ...
        'movie_categories/animation';  ...
        'movie_categories/romance'};
    % dataDirs = {'movie_categories/horror'; 'movie_categories/animation'};
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

    [idx, C] = kmeans(X, k, 'MaxIter', 1000);
    save(sprintf('2015_12_10_Centroid_%d.mat', k), 'C');
end