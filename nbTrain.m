% nbTrain.m - This script trains a naive bayes model based on the feature vector
%             that consist of the occurance of different colors within the film.
%             
%             Adapted from Problem Set #2 Question 3. I really hope I got it
%             right.
%
%             Note: This script assumes spamLikeFeatVect has already been run, 
%             and hence there are variables X and movieNames already loaded in
%             the workspace.
%             
% CS229 Final Project
% Ethan Chan, Rajashi Roy, John Lee
% {ethancys,rroy,johnwlee}@stanford.edu
% Created: November 27th 2015

numTrainDocs = size(trainMatrix, 1);
numTokens = size(trainMatrix, 2);

classOneIndex = trainLabels';
classZeroIndex = not(classOneIndex);

p_j_given_y1 = (classOneIndex*trainMatrix+ones(1,numTokens))/ ... 
    (sum(classOneIndex*trainMatrix)+numTokens);
p_j_given_y0 = (classZeroIndex*trainMatrix+ones(1,numTokens))/ ...
    (sum(classZeroIndex*trainMatrix)+numTokens);
p_y1         = sum(classOneIndex)/length(classOneIndex);
p_y0         = sum(classZeroIndex)/length(classZeroIndex);