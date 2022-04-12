function aa=split_str(str);
%  to split bb by the delimetr 'spaces'
% input: str   looks like 'aaxxxbbxxxxxccddxx' if 'x' denotes spaces.
% output: aa   is a cell array containing 'aa','bb','ccdd'

str1=strtrim(str);
numeric_str=uint8(str1);

% to compress repeated spaces 
ind_del=32;
ind_space=find(numeric_str==ind_del); fx_space=ind_space;
nn=length(ind_space);
for ii=1:nn-1
id1=ind_space(ii); id2=ind_space(ii+1);
if id2-id1==1; fx_space(ii)=999; end
end
sel_ind=ind_space(fx_space==999); str1(sel_ind)=[];

% no repeated spaces between two words
num_str=uint8(str1); loc_space=find(num_str==ind_del);
n_str=length(loc_space)+1; name_var=cell(n_str,1);

for ii=1:n_str
if ii==1; tx1=1; else, ind0=loc_space(ii-1); tx1=ind0+1;end
if ii<n_str; tx2=loc_space(ii)-1; else, tx2=length(num_str); end
name_var{ii}=str1(tx1:tx2);
end

aa=name_var;


