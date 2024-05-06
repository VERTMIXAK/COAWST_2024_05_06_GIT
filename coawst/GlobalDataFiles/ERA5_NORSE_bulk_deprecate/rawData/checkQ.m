file = 'single_2022.nc';
Q = nc_varget('single_2022.nc','r');

[Max,Index] = max(Q(:)) ;
[k,j,i] = ind2sub(size(Q),Index)


