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
    figure('Position', [100, 100, 800, 800]);
    currentCounter = 1;
    numCat = sum((idx == j));
    spDim = ceil(sqrt(numCat));
    ha = tight_subplot(spDim, ceil(numCat/spDim), [0.05, 0.02], [0.03, 0.03], 0.02);
    for i = 1:numCat
        while(idx(currentCounter) ~= j)
            currentCounter = currentCounter + 1;
        end
        imgName = (strcat(directoryName, cellstr(movieNames(currentCounter)),'.png'));
        img = imread(imgName{1});
        axes(ha(i));
        imshow(img);
        title(movieNames{currentCounter}(1:min(length(movieNames{currentCounter}),15)),'FontSize', 10);
        currentCounter = currentCounter + 1;
    end
    for i = numCat+1:spDim*ceil(numCat/spDim)
        delete(ha(i));
    end
%     print('-dpng', sprintf('kMeans_results/229MoviesK7Num%d.png',j));
end