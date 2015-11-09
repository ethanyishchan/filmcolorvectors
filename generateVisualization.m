% generateVisualization.m - This script generates images that help us to
%                           visualize the feature vectors that are obtained
%                           from averaging frames from a movie. This script
%                           is originally designed to support the
%                           datapoints obtained from Netflix.
% CS229 Final Project
% Ethan Chan, Rajashi Roy, John Lee
% {ethancys,rroy,johnwlee}@stanford.edu
% Created: November 8th 2015

% This script should be run from the base directory of the git repository
baseDir  = pwd;
dataDirs = {'netflix_vectors'; 'netflix_vectors/Horror'};
outDir   = 'movie_pictures';
for k = 1:size(dataDirs, 1);
    cd(dataDirs{k});
    D = dir();
    for i = 1:length(D)
        if (length(D(i).name) >= 4) && strcmpi(D(i).name(end-3:end), ...
                '.txt')
            movName = D(i).name(1:end-4);
            data = dlmread(D(i).name);
            numFrame = size(data, 1);
            for j = 1:numFrame
                patch([j-1 j-1 j j], [-1 1 1 -1], 'r', 'facecolor', ...
                    min(2*(data(j,:)'./(2^8)), 1), 'edgecolor', 'none');
            end
            axis([0,numFrame,-1,1]);
            set(gca,'position',[0 0 1 1],'units','normalized')
            print('-dpng', [baseDir, '/', outDir, '/', movName, '.png']);
        end
    end
    cd(baseDir);
end