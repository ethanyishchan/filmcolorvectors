
maxTrials = 100;
recall_A = zeros(4, maxTrials);
precision_A = zeros(4, maxTrials);
TP_A = zeros(4, maxTrials);
FP_A = zeros(4, maxTrials);
FN_A = zeros(4, maxTrials);

for r = 1:100
	if (mod(r, 10) == 0)
		disp(r);
	end
	svmOnSpamLikeFeatVect;
	recall_A(:,r) = recall_F;
	precision_A(:,r) = precision_F;
	TP_A(:,r) = TP_F;
	FP_A(:,r) = FP_F;
	FN_A(:,r) = FN_F;
end

TP_F = mean(TP_A, 2);
FP_F = mean(FP_F, 2);
FN_F = mean(FN_F, 2);