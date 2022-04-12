function [ex0 ey0 rt]=nxny2eof_pnt(n1,n2,eofs,mcx,mcy,ea,eb)
% [ex0 ey0 rt]=nxny2eof_pnt(n1,n2,eofs,mcx,mcy,ea,eb)
%   get parameters of pnt(n1 n2) at new EOF space and its angle to the pos eof1 axis
% input: 
%       [n1 n2]:        givne point in east-north space
%        eofs:           fix the direction of two axes
%       [mcx mcy]:      center in the east-north direction
%       [ea eb]:        ellipse axis length
%  output:
%       [ex0 ey0]:        coordinates of (n1,n2) in EOF space
%        rt:              angles wrp the semimajor axis

%%
[ex0, ey0]=nxny2eof_space(n1,n2,mcx,mcy,eofs);
%        [nx0 ny0] w.r.p. to (0 0)-->(mcx,mcy) in east-north space
%
vpnt=[0 0; ex0 ey0];   pnt_dist=pdist(vpnt,'euclidean');

cnt=1e-2;
if pnt_dist<=cnt; 
    ex0=0; ey0=0; rt=0;
else
    if pnt_dist==abs(ex0); 
        if ex0>0; 
            rt=0;
        else
            rt=pi;
        end
    end
    
    if pnt_dist==abs(ey0); 
        if ey0>0; 
            rt=pi/2;
        else
            rt=3/2*pi;
        end
    end
   
    if  pnt_dist~=abs(ey0)  & pnt_dist~=abs(ex0) ; 
        
        rt=atan(ey0/ex0 * (ea/eb));
        if rt>0
            if ex0<0; rt=pi+rt;end
        else
            if ex0>0
                rt=2*pi+rt;
            else
                rt=pi+rt;
            end
        end
    end
end
    
return

