% averagingFramesBatch.m - Script to find the average color for each 
%                          extracted frame in the movie. Runs through
%                          a folders to generate the feature vectors for
%                          those movies.
% CS229 Final Project
% Ethan Chan, Rajashi Roy, John Lee
% {ethancys,rroy,johnwlee}@stanford.edu
% Created: November 7th 2015

D = dir();
for i = 1:length(D)
    if D(i).isdir && ~strcmpi(D(i).name(1), '.')
        movName = D(i).name;
        movFol = dir(movName);
        numFrame = length(movFol(not([movFol.isdir])));
        cd(movName);
        featVect = zeros(3, numFrame);
        for j = 1:numFrame
            img = imread(sprintf('%03d.jpg', j));
            avg = squeeze(mean(mean(img)));
            featVect(:,j) = avg;
            patch([j-1 j-1 j j], [-1 1 1 -1], 'r', 'facecolor', ...
                min(2*(avg'./(2^8)), 1), 'edgecolor', 'none');
        end
        axis([0,numFrame,-1,1]);
        set(gca,'position',[0 0 1 1],'units','normalized')
        cd('..');
        dlmwrite([movName, '.txt'],featVect', ' ');
        print('-dpng', [movName, '.png']);
    end
end
