function [new_rx new_ry cnt bet zin]=pnt2ellipse(x1,y1,cx,cy,rx,ry,alpha)
%% given a point (x1,y1) in a bivariate space
%%       we know its center [cx cy] and orientation (alpha)
%%       with the reference ellipse axis (rx,ry)

%% aim: to get the axis length (new_rx new_ry) that goes through (x1,y1)
%%      cnt is the ratio of new_rx/rx == new_ry/ry
%%      beta is the angle of (x1, y1) w.r.p. to x-coordinate
%%      zin is the zone index for beta
%%          1: [0 pi/2]
%%          2: [pi/2 pi]
%%          3: [pi 1.5*pi]
%%          4: [1.5*pi 2*pi]
%%         91: [0 xx]
%%         92: [xx pi/2]
%%         93: [pi xx]
%%         94: [xx 1.5*pi]
%%
c1=x1-cx;
c2=y1-cy;
m=rx/ry; m_2=m^2;

%=========get the angle: t
if c1==0 & c2==0; error('!! the given point is at the central point  !!'),end

b1=atan(c2/c1);
        if b1>=0 
        if c2>0; bet=b1;end
        if c2<0; bet=pi+b1;end
        if c2==0 & c1>0, bet=0; end
        if c2==0 & c1<0; bet=pi;end
    else
        if c2<=0; bet=2*pi+b1;end
        if c2>=0; bet=pi+b1;end
    end

%% relation with alpha
nrot=alpha*pi/180;

if nrot<0 | nrot>pi, error('---ellipse orientation not in range ---'),end

if nrot<=pi/2;
    t=bet-nrot;
    if t<0, t=2*pi+t;end
end
if nrot>pi/2
    t=bet-nrot;
    if t<0,2*pi+t;end
end

len_2=(c1^2+c2^2);
cost=cos(t);sint=sin(t);
new_ry=sqrt(len_2)*sqrt(cost^2/m_2+sint^2);
new_rx=m*new_ry;
cnt=new_rx/rx;


%% zin

if (bet>0 & bet<pi/2), zin=1;end
if (bet>pi/2 & bet<pi), zin=2; end
if (bet>pi & bet<1.5*pi), zin=3;end
if (bet<2*pi & bet>1.5*pi), zin=4; end
 
if mod(bet,pi/2)==0;
c0=pi/2;  
if floor(bet/c0)==0, zin=91; end  %% at x-coordinate (x>0: 0 )
if floor(bet/c0)==1; zin=92; end  %% at y-coordinate (y>0: pi/2)
if floor(bet/c0)==2; zin=93; end  %% at x-coordinate (x<0: pi)
if floor(bet/c0)==3; zin=94; end  %% at y-coordnate  (y<0: 1.5*pi)
end










return


