function label = testTrees_fast(data,tree,param)
% Faster version - pass all data at same time
cnt = 1;
learner = param.learner;
for T = 1:length(tree) % run through trees
    idx{1} = 1:size(data,1); % run through all test data
    for n = 1:length(tree(T).node) % within this tree, run through all nodes
        if ~tree(T).node(n).dim % when a node does not have dim, the node is a leaf node
            leaf_idx = tree(T).node(n).leaf_idx; % find leaf_idx
            if ~isempty(tree(T).leaf(leaf_idx))
                label(idx{n}',T) = tree(T).leaf(leaf_idx).label;
            end
            continue;
        end
        
        switch learner
            case 'axis_aligned'
                idx_left = data(idx{n},tree(T).node(n).dim) < tree(T).node(n).t;
            case 'two_pixel'
                idx_left = data(idx{n},tree(T).node(n).dim(1)) - data(idx{n},tree(T).node(n).dim(2)) < tree(T).node(n).t;
        end     
        idx{n*2} = idx{n}(idx_left');
        idx{n*2+1} = idx{n}(~idx_left');
    end
end

end

