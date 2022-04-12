function    [v eofs alpha]=eof_bootstrp(var,ik)
%[v eofs alpha ]=eof_bootstrp(var,ik)
% calculate eofs for statstical moments of bootstrapped samples
% return eofs and the orientation
% return the projectory of the ellipse at a given confidence level
%   & center & range of the axes
% inpput:
%       var: bootstrapped examples including original data
%       ik:  kept number of leading modes
%%%       XXXp  : the confidence level to define the ellipse space
% output: of EOF and ellipse parameters
%       v: eigenvalues
%       eofs: eofs
%       alpha (in radians): the angle of the long axis w.r.p. to x-axis 
%       

%%  new coords determined from EOF--outliers
                   [v eofs ec error]=eof(var,ik);
% original space
                    eof1=eofs(:,1);
                    eof2=eofs(:,2);
% alpha of rotation
                    alpha=atan(eof1(2)/eof1(1));  % of EOF1

%%  new coords determined from theilsen---more robust
% [beta,intc]=fast9_TheilSen(var) ;

% alpha1 = atan(beta);   % angle in radians
% alpha2 = alpha1 + pi/2;
%  eof1 = [cos(alpha1), sin(alpha1)];
%  eof2 = [ cos(alpha2), sin(alpha2)];

%%      outputs
% alpha = alpha1;
% eofs  = [ eof1;eof2]'; 

%if alpha<0, alpha=pi/2-alpha; end
return