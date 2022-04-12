function [yflag ratio loc_flag]=in_out(n1,n2,m0,m1,mcx,mcy,ea,eb,eofs,ichi);
%++++++++++++++++
%[yflag ratio loc_flag]=in_out(n1,n2,m0,m1,mcx,mcy,ea,eb,eofs,ichi);
%
%        determine one point in/ outside of an ellipse
% input:
%        [n1 n2]:   coordiates of a point in east-north space
%        [m0 m1]:   data clouds defining ellipse
%        [mcx mcy]: center of ellipse in east-north space
%        [ea eb]:   long and short axis in EOF space(=a/b)
%        eofs:
%        ichi:   =1 euclidean distance // =2 mahalanobis distance
% output:
%        yflag:  10-center/1-inside/0-outside/11-at the ellipse
%        ratio:  = pnt_dist / ref_dist
%        loc_flag: at (=1234) quater in east-north space 
% loc_flag:
% loc_flag=1.5 : northward (y-axis)
% loc_flag=2.5 : westward (x-axis)
% loc_flag=3.5 : soutwhard (y-axis)
% loc_flag=4.5 : eastward  (x-axis)
% loc_flag=1234: collapse to the center
% yflag:
% yflag=10;  collapse to the center
% yflag=9;   in the ellipse
% yflag=11   at the ellipse
% yflag=0;   outside of the ellipse

%% ellipse
% angle
%% project [n1 n2] to the EOF space
[e1, e2, rt]=nxny2eof_pnt(n1,n2,eofs,mcx,mcy,ea,eb);

 % euclidean distance
if ichi==1;  
%% distance between center and [e1 e2] <-- [n1 n2]
vpnt=[0 0;e1 e2];   pnt_dist=pdist(vpnt,'euclidean');

%% get the reference point at the ellipse with the same angle

x=ea*cos(rt); y=eb*sin(rt);
vpnt0=[0 0;x y]; ref_dist=pdist(vpnt0,'euclidean');
end

% mahalanobis distance
if ichi==2
new_var = [m0(:), m1(:)]; 
y  = [n1 n2];          pnt_dist  = mahal(y, new_var);
[nxe nye] = ellipse_xy_ref(n1,n2,eofs,mcx,mcy,ea,eb);    
y0 = [nxe nye];        ref_dist = mahal(y0, new_var);     
end

cnt=1e-2;
if pnt_dist<=cnt;                        %% collapse to the center
    yflag=10;
else
    if abs(ref_dist-pnt_dist)<=cnt,      %% at the ellipse
        yflag=11;
    else
        if pnt_dist<ref_dist             %% within the ellipse
            yflag=9;
        end
        %
        if pnt_dist>ref_dist
            yflag=0;                     %% outside of the ellipse
           
        end
    end
end

%% get the loc_flag
% do it in east-north space
%       [n1 n2] & [mcx mcy]    %% east-north space
%       [e1 e2] & [ 0   0]     %% EOF space

vdist = pnt_dist  ;


if vdist<=cnt; 
   
    loc_flag=1234;           %% collapse into the center
else
    if vdist==abs(n2-mcy);   %% along y-axis (northward)
        if n2>mcy; loc_flag=1.5; end
        if n2<mcy; loc_flag=3.5; end      
    end
 %   
    if vdist==abs(n1-mcx);   %% along x-axis (eastward);
        if n1>mcx, loc_flag=4.5;end
        if n1<mcx, loc_flag=2.5;end
    end
 %  
 if vdist>abs(n2-mcy) | vdist>abs(n1-mcx)  
     if n1>mcx
      if n2>mcy; loc_flag=1;end
      if n2<mcy; loc_flag=4;end
     else
      if n2>mcy; loc_flag=2;end
      if n2<mcy; loc_flag=3;end
     end
 end
 
end

%% get the ratio
ratio=pnt_dist/ref_dist;


return