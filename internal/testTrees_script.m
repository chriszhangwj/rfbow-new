% Test Random Forest
leaf_assign = testTrees_fast(data_test,trees);

for T = 1:length(trees)
    p_rf(:,:,uint8(T)) = trees(1).prob(leaf_assign(:,uint8(T)),:);
end

% average the results from all trees
p_rf = squeeze(sum(p_rf,3))/length(trees); % Regression
[~,c] = max(p_rf'); % Regression to Classification
C=confusionmat(data_test(:,end)',c);
% plotconfusion(data_test(:,end)',c);
plotConfMat(C,{'1', '2', '3', '4', '5', '6', '7', '8', '9', '10'});
accuracy_rf = sum(c==data_test(:,end)')/length(c); % Classification accuracy (for Caltech dataset)
