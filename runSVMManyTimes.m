load('2015_12_10_Centroid_512.mat');
spamLikeFeatVect;

maxTrials = 100;
recall_A = zeros(4, maxTrials);
precision_A = zeros(4, maxTrials);

for r = 1:100
	if (mod(r, 10) == 0)
		disp(r);
	end
	svmOnSpamLikeFeatVect;
	recall_A(:,r) = recall_F;
	precision_A(:,r) = precision_F;
end
