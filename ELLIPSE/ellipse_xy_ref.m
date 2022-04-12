function  [ nxe nye ]=ellipse_xy_ref(n1,n2,eofs,mcx,mcy,ea,eb)
% [ nxe nye ]=ellipse_xy_ref(n1,n2,eofs,mcx,mcy,ea,eb)
% get ellipse function from eofs & shape parameters of ellipse
% input: 
%       [n1 n2]: to be determined point
%       eofs: fix the direction of two axes
%       [mcx mcy]: center in the east-north direction
%       [ea eb]: length of axes (a & b)
%  output:
%       [nxe nye]: ref pnt at east-north point

%%
[ex0 ey0 rt]=nxny2eof_pnt(n1,n2,eofs,mcx,mcy,ea,eb);

% determin angle of the eofs
slp=eofs(2,1)/eofs(1,1);     % w.r.p. to (0 0)
%% 
cnt=1e-2;
if abs(eofs(1,1))<=cnt;      %% at the eof2 axis
    nrot=pi/2; 
else
    nrot=atan(slp);
end

%% 
ax=ea; ay=eb;
t=linspace(0,2*pi,10000); 
%% pnt===
par=(t-rt)*180/pi;
ii=find(abs(par)==min(abs(par)),1); 

x0=ax*cos(t(ii)); y0=ay*sin(t(ii));    %% ref--point in ellipse space (x0, y0)
x=ax*cos(t); y=ay*sin(t);

if nrot<0
    %display(' negative ')
    nrot = - nrot;
    nx =  y*sin(nrot) + x*cos(nrot) + mcx;
    ny =  y*cos(nrot) - x*sin(nrot) + mcy;
    
    nx0 =  y0*sin(nrot) + x0*cos(nrot) + mcx;
    ny0 =  y0*cos(nrot) - x0*sin(nrot) + mcy;
    
    
else
    %display(' positive ')
    nx = - y*sin(nrot) + x*cos(nrot) + mcx;
    ny =   y*cos(nrot) + x*sin(nrot) + mcy;   
    
    nx0 = - y0*sin(nrot) + x0*cos(nrot) + mcx;
    ny0 =   y0*cos(nrot) + x0*sin(nrot) + mcy;   
end

nxe=nx0; nye=ny0;


return


