function bvar=bootstrp_sample(var, blk_len, irpt)
%% using bootstrapping to increase samples
%  input: 
%       var: a variable, such as temperature with origional length
%       blk_len:  block length to count for memory in the time series
%       irpt:  number of repititions of bootstrapping, e.g., 1000
%  output:
%       bvar: bootstrapped samples
%
%
dump=var;
num_samp=irpt;   % number of repititions
n_year=length(var);  num_blk=floor(n_year/blk_len);
%
x99=buffer(dump,blk_len,blk_len-1);   %running window
x88=squeeze(x99(:,blk_len:end));

[i1 i2]=size(x88);   %% number of columns matters
for ii=1:irpt
rid=randi(i2,1,num_blk);
d99=x88(:,rid);
mboot(:,ii)=d99(:);    %% bootstrapped samples
end

bvar=mboot;
return