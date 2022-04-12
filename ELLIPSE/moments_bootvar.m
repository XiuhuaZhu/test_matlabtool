function  [m0 m1 new_var]=moments_bootvar(bvar,seg_len)
% calculate moments of bvar and prepare it for eof calculation
% input: 
%       bvar: of dimension mxn, m-time length, and n-number of variables
%       seg_len: number of segments for estimating moments
% output
%       m0: mean of bootstrapped samples
%       m1: std  of bootstrapped samples
%       new_var: [m0(:) m1(:)] for EOF calculation
% 

%% isp: number of bootstrapping samples
[it isp]=size(bvar);
 n_seg=floor(it/seg_len);

for ii=1:isp
d99=squeeze(bvar(:,ii));

d99=buffer(d99,seg_len, seg_len-10);
d77 = d99(1,:); d66 = d99(end, :);
i76 = find(d77 ~= 0 & d66 ~= 0); d99=d99(:,i76); 

% remove linear trend in each segment

anomy=detrend(d99,'linear');   % no linear trend
trdy=d99-anomy;                % only linear trend

m0(:,ii)=mean(d99,1);
% m0(:,ii)=median(d99,1);  % wrong choice, why? alignment does not look
% good

m1(:,ii)=std(anomy,0,1);

%m12(:,isp)=std(trdy,0,1);
end

new_var=[m0(:) m1(:)] ;

%new_var=[m0; m1] ;


return