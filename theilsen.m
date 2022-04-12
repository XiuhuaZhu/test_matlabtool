function [beta,intc]=theilsen(dumx,dumy)
% only for one-D data
%% function [beta,intc]=theilsen(dumx,dumy)

var_len=length(dumx);
% permutation
aa=combnk([1:var_len],2);
%bb=combnk([var_len:-1:1],2);
%aa=[aa;bb];

% dy
ddy=diff(dumy(aa),1,2);
%dx
ddx=diff(dumx(aa),1,2);

% slope
dbb=ddy./ddx;
% median of slopes
beta=median(dbb);


%% intercept
intc=median(dumy-dumx*beta);


return
