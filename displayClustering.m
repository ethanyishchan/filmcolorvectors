% displayClustering.m - Script to display the different clusters determined
%                       by k-means. The script draws the visualization
%                       vector of each cluster on 1 plot, allowing visual
%                       comparison of the clusters.
%                       
%                       Note: Assumes that kMeans was run immediately
%                       before this script is run. (i.e. variables "idx",
%                       "k", "movieNames", etc) is already loaded in
%                       workspace.
%                       
% CS229 Final Project
% Ethan Chan, Rajashi Roy, John Lee
% {ethancys,rroy,johnwlee}@stanford.edu
% Created: November 7th 2015

directoryName = 'movie_pictures/';
for j = 1:k
    figure;
    currentCounter = 1;
    numCat = sum((idx == j));
    spDim = ceil(sqrt(numCat));
    for i = 1:numCat
        while(idx(currentCounter) ~= j)
            currentCounter = currentCounter + 1;
        end
        imgName = (strcat(directoryName, cellstr(movieNames(currentCounter)),'.png'));
        img = imread(imgName{1});
        subplot(spDim, spDim, i);
        imshow(img);
        title(movieNames{currentCounter}(1:min(length(movieNames{currentCounter}),20)));
        currentCounter = currentCounter + 1;
    end
end