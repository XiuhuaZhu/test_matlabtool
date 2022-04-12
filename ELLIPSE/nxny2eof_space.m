function [ex, ey ]=nxny2eof_space(m0,m1,mcx,mcy,eofs)
%
% [ex, ey ]=nxny2eof_space(m0,m1,mcx,mcy,eofs)
%
% determine bndx and bndy for ellipse in EOF space
%  1. to convert bootstrap samples to eof space 
%  2. to determin ellipse parameters from bootstrap samples in EOF space 
%  input: 
%       [m0 m1]: pnt in nx-ny (north-south) directions
%       [mcx mcy]: center in east-north space, corr. to (0,0) in EOF space
%       eofs:   leading two eofs in mean-std space
%  output:
%        [ex ey]: projection of [m0 m1] in EOF space
%                 ex--along eof1 
%                 ey--along eof2
  



slp=eofs(2,1)/eofs(1,1);
nrot=atan(slp);


if nrot<0
 nrot=abs(nrot);
 ex=(m0-mcx)*cos(nrot)-(m1-mcy)*sin(nrot);
 ey=(m0-mcx)*sin(nrot)+(m1-mcy)*cos(nrot);
else     % if nrot>=0   
 ex= (m0-mcx)*cos(nrot)+(m1-mcy)*sin(nrot);
 ey=-(m0-mcx)*sin(nrot)+(m1-mcy)*cos(nrot);
end



%% new center according to [ ex ey]
%eof_ec1=median(ex(:));
%pp = abs(ex(:) - eof_ec1);
%ipp = find(pp == abs(pp),1);

%n9ex  = ex(ipp);     n9ey  = ey(ipp);

irev=1;
if irev==2
%% reverse back to [north east] coordiates
if nrot<0
 nrot=abs(nrot);

 dx  =   n9ex * cos(nrot) + n9ey * sin(nrot);
 dy  = - n9ex * sin(nrot) + n9ey * cos(nrot) ;
else     % if nrot>=0   
 dx =   n9ex * cos(nrot) - n9ey * sin(nrot);
 dy =   n9ex * sin(nrot) + n9ey * cos(nrot) ;
end
sft = [ dx dy];
end
return