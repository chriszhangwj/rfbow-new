function [idx_, dim, t] = axis_aligned(D, data)
    dim = randi(D-1); % randomly pick a dimension within the feature space
    d_min = single(min(data(:,dim))) + eps; % Find the data range of this dimension
    d_max = single(max(data(:,dim))) - eps;
    t = d_min + rand*((d_max-d_min)); % Pick a random value within the range as threshold
    idx_ = data(:,dim) < t; % return the index of the left node
end