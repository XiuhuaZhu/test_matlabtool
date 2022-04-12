function [nex,ney]=funecllipse(cx,cy,rx,ry,alpha,xs);
   %% given an ecclipse function
   %% give x-coordinate
   %% to get ys
   %%
  
  t=xs;
  %%
  x=rx*cos(t); y=ry*sin(t);
  nrot=alpha*pi/180;
  
  nex=x*cos(nrot)-y*sin(nrot)+cx;
  ney=x*sin(nrot)+y*cos(nrot)+cy;
  return
  %%----xs: if nex==xs
  c1=rx*cos(nrot); c2=ry*sin(nrot);
  c3=rx*sin(nrot); c4=ry*cos(nrot);
  return
  %%
  %% c1^2+c3^2=rx^2;
  %% c2^2+c4^2=ry^2;
  %% c1/c4=c3/c2=rx/ry;
  %% c3/c1=c2/c4=tan(nrot);
  %%
  %%== nex=c1*cos(t)-c2*sin(t)+cx;
  %%== ney=c3*cos(t)+c4*sin(t)+cy;
  %% 
  
  %% return
                   