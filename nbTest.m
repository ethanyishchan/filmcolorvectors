% nbTrain.m - This script tests the naive bayes model based on the feature 
%             vector that consist of the occurance of different colors within 
%             the film.
%             
%             Adapted from Problem Set #2 Question 3. I really hope I got it
%             right.
%
%             Note: This script assumes nbTrain has already been run, and hence
%             there are variables p_j_given_y0 X and p_j_given_y0 already loaded
%             in the workspace.
%             
% CS229 Final Project
% Ethan Chan, Rajashi Roy, John Lee
% {ethancys,rroy,johnwlee}@stanford.edu
% Created: November 27th 2015

numTestDocs = size(testMatrix, 1);
numTokens = size(testMatrix, 2);

p_x_and_y0 = sum(testMatrix*log(diag(p_j_given_y0)+ ... 
    not(diag(p_j_given_y0))),2)-log(sum(testMatrix,2))+log(p_y0);
p_x_and_y1 = sum(testMatrix*log(diag(p_j_given_y1)+ ... 
    not(diag(p_j_given_y1))),2)-log(sum(testMatrix,2))+log(p_y1);

p_y0_given_x = p_x_and_y0;
p_y1_given_x = p_x_and_y1;

output = (p_y1_given_x > p_y0_given_x);

% Compute the error on the test set
error=0;
for i=1:numTestDocs
  if (testLabels(i) ~= output(i))
    error=error+1;
  end
end

%Print out the classification error on the test set
disp(error/numTestDocs);