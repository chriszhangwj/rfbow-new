function [idx_, dim_sel, t] = two_pixel( D, data )
    dim = randperm(D-1);
    dim_sel = randsample(dim,2,false); % randomly select 2 dimensions without replacement
    d_min = single(min(data(:,dim_sel(1)) - data(:,dim_sel(2)))) + eps;
    d_max = single(max(data(:,dim_sel(1)) - data(:,dim_sel(2)))) - eps;
    t = d_min + rand*((d_max-d_min));
    idx_ = data(:,dim_sel(1))-data(:,dim_sel(2)) < t;
end
