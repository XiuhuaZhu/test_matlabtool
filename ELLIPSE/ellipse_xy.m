function [nx ny mmx0 mmy0]=ellipse_xy(eofs,mcx,mcy,ea,eb)
% get ellipse function from eofs & shape parameters of ellipse
% input: 
%        eofs: fix the direction of two axes
%       [mcx mcy]: center in the east-north direction
%       [ea eb]: length of axes (a & b)
%  output:
%       [nx ny]: in east-west direction
%       mmx0:  [max(nx) min(nx)]
%       mmy0:  [max(ny) min(ny)]
%%
% determin angle of the eofs
slp=eofs(2,1)/eofs(1,1);     % w.r.p. to (0 0)
%% 
cnt=0.001;
if abs(eofs(1,1))<=cnt;      %% at the eof2 axis
    nrot=pi/2; 
else
    nrot=atan(slp);
end

%% 
t=linspace(0,2*pi,5000); 

ax=ea; ay=eb; 

 x=ax*cos(t); y=ay*sin(t);
  refp=2;
  if refp==1, cr=[0 pi/4 pi/2]; x0=ax*cos(cr); y0=ay*sin(cr);end

if nrot<0
    %display(' negative ')
    nrot = - nrot;
    nx =  y*sin(nrot) + x*cos(nrot) + mcx;
    ny =  y*cos(nrot) - x*sin(nrot) + mcy;
    if refp==1    %% reference pooint for orientation
    nx0 =  y0*sin(nrot) + x0*cos(nrot) + mcx;
    ny0 =  y0*cos(nrot) - x0*sin(nrot) + mcy;
    end
else
    %display(' positive ')
    nx = - y*sin(nrot) + x*cos(nrot) + mcx;
    ny =   y*cos(nrot) + x*sin(nrot) + mcy;  
     if refp==1    %% reference pooint for orientation
    nx0 = - y0*sin(nrot) + x0*cos(nrot) + mcx;
    ny0 =   y0*cos(nrot) + x0*sin(nrot) + mcy;  
     end
    
end

if refp==1
figure(99);
plot(nx,ny); hold on; plot(nx0,ny0,'ro'); hold off;axis equal
end

mmx0=[max(nx) min(nx)];
mmy0=[max(ny) min(ny)];

return

