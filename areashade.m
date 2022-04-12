function areashade(xx,y1,y2,color);
% shade between two lines y1 & y2
%  xx: the interval for x-axis
%  y1 & y2: two curves
%  color: either as 'k','w', and so on, or a color array following [ r g b]


nn=length(xx);
xx=xx(:)'; y1=y1(:)'; y2=y2(:)';

%% making plot
%plot(xx,y1);hold on;plot(xx,y2);
%hold on;
xdata=[xx(1) xx(1) xx(1:nn) xx(nn:-1:1)]; ydata=[y1(1) y2(1) y1(1:nn) y2(nn:-1:1)];
hh=fill(xdata,ydata,color); hold off;set(hh,'edgecolor','w'); 
return


