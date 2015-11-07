% averagingFrames.m - Script to find the average color for each extracted
%                     frame in the movie.
% CS229 Final Project
% Ethan Chan, Rajashi Roy, John Lee
% {ethancys,rroy,johnwlee}@stanford.edu
% Created: November 7th 2015

movName = input('Enter folder name: ', 's');
D = dir(movName);
Num = length(D(not([D.isdir])));
cd(movName);
featVect = zeros(3, Num);
for i = 1:Num
    img = imread(sprintf('img%03d.jpg', i));
    avg = squeeze(mean(mean(img)));
    featVect(:,i) = avg;
    patch([i-1 i-1 i i], [-1 1 1 -1], 'r', 'facecolor', ...
        min(2*(avg'./(2^8)), 1));
end
axis([0,Num,-1,1]);
set(gca,'position',[0 0 1 1],'units','normalized')
cd('..');
dlmwrite([movName, '.txt'],featVect', ' ');
print('-dpng', [movName, '.png']);
