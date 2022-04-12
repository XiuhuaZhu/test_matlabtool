function bvar=bootstrp_sample_ens(var, blk_len, irpt)
%% using bootstrapping to increase samples in an ensemble setting
%  input: 
%       var: a variable, such as temperature with origional length
%       blk_len:  block length to count for memory in the time series
%       irpt:  number of repititions of bootstrapping, e.g., 1000
%  output:
%       bvar: bootstrapped samples
%
%
rng('default');
num_samp=irpt;   % number of repititions
[i1 i2]=size(var);
% if i1--time
%disp('-assuming D_time > D_num_ens-'),pause(0.5)
if i1>i2, n_year=i1; num_ens=i2;           end
if i1<i2, n_year=i2; num_ens=i1; var=var'; end
% var -- [ time num_ens]
num_blk=floor(n_year/blk_len);
 
%
for ii=1:num_ens   
    dump=var(:,ii);                    % of dimension t x number_ensemble
    x99=buffer(dump,blk_len,blk_len-1);   %running window
    d77=x99(1,:); d66 = x99(end,:);  i76 = find(d77~=0 & d66 ~=0);
    x88=squeeze(x99(:,i76));
   
    dmp_ncol=size(x88,2);
    if ii==1; x77=zeros(blk_len,dmp_ncol*num_ens);    end
    pid=(ii-1)*dmp_ncol + (1:dmp_ncol); 
    x77(:,pid)=x88;
end


[i1 i2]=size(x77);   %% number of columns matters
for ii=1:irpt
    
rid=randi(i2,1,num_blk);
d99=x77(:,rid);
mboot(:,ii)=d99(:);    %% bootstrapped samples
end

bvar=mboot;
return