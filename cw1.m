clear all; close all; 
% Initialisation
init; clc;

% set rf codebook parameters if using it
param_cb.num = 5;
param_cb.depth = 5;
param_cb.splitNum = 5;
param_cb.split = 'IG';
param_cb.learner = 'axis_aligned';

[data_train, data_test] = getData_Two_Modes('km', param_cb); % second argument from ['km','rf']

param.num = 10;         % Number of trees % intially 50
param.depth = 4;        % Depth of each tree
param.splitNum = 10;     % Number of trials in split function
param.split = 'IG';     % Currently support 'information gain' only
param.learner = 'axis_aligned';    % Currently support 'axis_aligned','two_pixel'


trees = growTrees(data_train,param); % this is the final function to be used for tree training

% Test Random Forest
leaf_assign = testTrees_fast(data_test,trees,param);

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