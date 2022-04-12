function  [nxe nye]=plot_eofbstrp(varm0,vars0,m0,m1,mcx,mcy,ea,eb,eofs,n1,n2,iplot,mcol)
%       [nxe nye]=plot_eofbstrp(varm0,vars0,m0,m1,mcx,mcy,ea,eb,eofs,n1,n2,iplot,mcol)
%% samples in nx-ny (east-north) direction
% input:
%       [varm0 vars0]  : original means and stds
%       [m0 m1]  :    bootstrap samples in original space
%       [mcx mcy]:    center of ellipse in original space
%       [ea eb]:  [a b] ellipse parameters (x/a)?2 + (y/b)?2=1
%       eofs:         eofs
%       [n1 n2]:      given point given in original space
%        iplot:       1 - no plots 2--plotting
%        iplot==2:    iplot=[iplot hm], hm figure handle
%        mcol
% output:
%       [nxe nye]:     ref pnt of [n1 n2] at the ellipse in nx-ny (east-north) space 
%        iz:           iz=1: area filling || iz=2: bootstapping plotted
d91=m0(:); d92=m1(:);

% iz=2;    % with bootstrappoing shown
% iz=1;    % no bootstrappoing shown but colored zones
% iz=3;    % no bootstrappiing but colored zones in new coordinates-method1
% iz=4;    % no bootstrappiing but colored zones in new
%           coordinates-method2-decomposing zones


iz=4; 

%% plotting eofs
x1=[0 eofs(1,1)]; y1=[0 eofs(2,1)];
x2=[0 eofs(1,2)]; y2=[0 eofs(2,2)];

%subplot(224);
%% plotting eofs only
%quiver(x1,y1); hold on; quiver(x2,y2,'color','r'); hold off;
%axis equal;grid on;
%
%%
[nx ny mmx0 mmy0]=ellipse_xy(eofs,mcx,mcy,ea,eb);
%% the ellipse ()

%% plot EOFs
% set up axis limits
xt=linspace(min(d91)-0.2,max(d91)+0.2,5000);


if iz==3
    xt=linspace(mmx0(2),mmx0(1),5000);
end
%% specify axes for eof1 & eof2
rslp=eofs(2,1)/eofs(1,1);
y=rslp*(xt-mcx)+mcy;    %% eof1

rslp2=tan(atan(rslp) + pi/2); 
y2=rslp2*(xt-mcx)+mcy;  %% eof2

%% plot axes for eof1 & eof2

%% plot monte carlo simulations
    ghandle=iplot(2);   iplot=iplot(1);

if iplot==2; 
    col=0.88*ones(1,3);
    
    if ishandle(ghandle),  %% a figure window open    
    else             %% if no figure windown open
    
        subplot(221);  
        if iz==1            % area filling
            z1x=[mcx mcx+2 mcx+2 mcx];     z1y=[mcy mcy mcy+2 mcy+2];
            z2x=[mcx mcx-2 mcx-2 mcx];     z2y=[mcy mcy mcy+2 mcy+2];         
            z3x=[mcx mcx-2 mcx-2 mcx];     z3y=[mcy mcy mcy-2 mcy-2];            
            z4x=[mcx mcx+2 mcx+2 mcx];     z4y=[mcy mcy mcy-2 mcy-2];
            zcol=[0.8 0.6 0.6; 0.5 0.5 0.8; 0.5 .5 0.7 ;  0.7 0.5 0.5];
           
            hold on;         fill(z1x,z1y,zcol(1,:));
            hold on;         fill(z2x,z2y,zcol(2,:));
            hold on;         fill(z3x,z3y,zcol(3,:));
            hold on;         fill(z4x,z4y,zcol(4,:));
            
        end
        
        if iz==2    % scatter of mc samples
            hold on;  h=scatter(d91,d92); set(h,'markeredgecolor',col,'markerfacecolor','none');
        end
        
        if iz==3    % colored zones in inew coordinates         
        
         % zone 1
         z11x=[mmx0(1) mmx0(1)+2 mmx0(1)+2 mmx0(1)];    
         z11y=[mmy0(1) mmy0(1) mmy0(2) mmy0(2)];
         
         z12x=[mmx0(2) mmx0(2)-2 mmx0(2)-2 mmx0(2)];    
         z12y=[mmy0(1) mmy0(1) mmy0(2) mmy0(2)];
         % zone 2
         z21x=[mmx0(1)  mmx0(1) mmx0(2) mmx0(2)];    
         z21y=[mmy0(1) mmy0(1)+2 mmy0(1)+2 mmy0(1)];
         
         z22x=[mmx0(1)  mmx0(1) mmx0(2) mmx0(2)];    
         z22y=[mmy0(2) mmy0(2)-2 mmy0(2)-2 mmy0(2)];
         % zone 3
         z31x=[mmx0(1)  mmx0(1)+2 mmx0(1)+2 mmx0(1)];    
         z31y=[mmy0(1)  mmy0(1)   mmy0(1)+2 mmy0(1)+2];
         
         z32x=[mmx0(2) mmx0(2)-2 mmx0(2)-2 mmx0(2) ];    
         z32y=[mmy0(2) mmy0(2)   mmy0(2)-2 mmy0(2)-2 ];
         
         % zone 4 
         z41x=[mmx0(2)  mmx0(2)-2 mmx0(2)-2 mmx0(2)];    
         z41y=[mmy0(1)  mmy0(1)   mmy0(1)+2 mmy0(1)+2];
         
         z42x=[mmx0(1) mmx0(1)+2 mmx0(1)+2 mmx0(1) ];    
         z42y=[mmy0(2) mmy0(2)   mmy0(2)-2 mmy0(2)-2 ];
                 
            zcol=[0.9 0.8 0.9; 0.5 0.5 0.9; 0.5 .7 0.5 ;  0.9 0.8 0];
            hold on;         fill(z11x,z11y,zcol(1,:));  % zone 11
            hold on;         fill(z12x,z12y,zcol(1,:));  % zone 12
            
            hold on;         fill(z21x,z21y,zcol(2,:));  % zone 21
            hold on;         fill(z22x,z22y,zcol(2,:));  % zone 22
            
            hold on;         fill(z31x,z31y,zcol(3,:));  % zone 31
            hold on;         fill(z32x,z32y,zcol(3,:));  % zone 32
            
            hold on;         fill(z41x,z41y,zcol(4,:));  % zone 41
            hold on;         fill(z42x,z42y,zcol(4,:));  % zone 42
        end  
            
            if iz==4    % colored zones in inew coordinates -- method 2
                % zone 1
                z11x=[mmx0(1) mmx0(1)+2 mmx0(1)+2 mmx0(1)];      
                z11y=[mmy0(1) mmy0(1) mmy0(2) mmy0(2)];
                
                z12x=[mmx0(2) mmx0(2)-2 mmx0(2)-2 mmx0(2)]; 
                z12y=[mmy0(1) mmy0(1) mmy0(2) mmy0(2)];
                % zone 2
                z21x=[mmx0(1)  mmx0(1) mmx0(2) mmx0(2)];    
                z21y=[mmy0(1) mmy0(1)+2 mmy0(1)+2 mmy0(1)];
         
               z22x=[mmx0(1)  mmx0(1) mmx0(2) mmx0(2)];    
                z22y=[mmy0(2) mmy0(2)-2 mmy0(2)-2 mmy0(2)];
                % zone 3
                z31x=[mmx0(1)  mmx0(1)+2 mmx0(1)+2 mmx0(1)];    
                z31y=[mmy0(1)  mmy0(1)   mmy0(1)+2 mmy0(1)+2];
         
                z32x=[mmx0(2) mmx0(2)-2 mmx0(2)-2 mmx0(2) ];    
                z32y=[mmy0(2) mmy0(2)   mmy0(2)-2 mmy0(2)-2 ];
         
                % zone 4 
                z41x=[mmx0(2)  mmx0(2)-2 mmx0(2)-2 mmx0(2)];    
                z41y=[mmy0(1)  mmy0(1)   mmy0(1)+2 mmy0(1)+2];
         
                z42x=[mmx0(1) mmx0(1)+2 mmx0(1)+2 mmx0(1) ];    
                z42y=[mmy0(2) mmy0(2)   mmy0(2)-2 mmy0(2)-2 ];
         
                z41x=[mmx0(2)  mmx0(2)-2 mmx0(2)-2 mmx0(2)];    
                z41y=[mmy0(1)  mmy0(1)   mmy0(1)+2 mmy0(1)+2];
         
                z42x=[mmx0(1) mmx0(1)+2 mmx0(1)+2 mmx0(1) ];    
                z42y=[mmy0(2) mmy0(2)   mmy0(2)-2 mmy0(2)-2 ];
        
          
                 % zone 5 
                 %---[nx ny mmx0 mmy0]=ellipse_xy(eofs,mcx,mcy,ea,eb);
          
                pp=abs(nx-mmx0(1));  id1=find(pp==min(pp)); ap1=[nx(id1) ny(id1)];
                pp=abs(nx-mmx0(2));  id2=find(pp==min(pp)); ap2=[nx(id2) ny(id2)];
                pp=abs(ny-mmy0(1));  id3=find(pp==min(pp)); ap3=[nx(id3) ny(id3)];
                pp=abs(ny-mmy0(2));  id4=find(pp==min(pp)); ap4=[nx(id4) ny(id4)];
                if rslp>0
                    pz1x=[nx(id1)  nx(id1:-1:id4)   nx(id1)];               pz1y=[ny(id1)  ny(id1:-1:id4)   ny(id4)];   
                    pz2x=[nx(id3)  nx(id3:id2)      nx(id2)];               pz2y=[ny(id3)  ny(id3:id2)   ny(id3)];
                    pz3x=[nx(id1)  nx(id1:end) nx(1:id3)   nx(id1)];        pz3y=[ny(id1)  ny(id1:end) ny(1:id3)   ny(id3)];
                    pz4x=[nx(id2)  nx(id2:id4)   nx(id2)];                  pz4y=[ny(id2)  ny(id2:id4)   ny(id4)];
                else
            
                    pz1x=[nx(id1)  nx(id1:id3)   nx(id1)];               pz1y=[ny(id1)  ny(id1:id3)   ny(id3)];   
                    pz2x=[nx(id2)  nx(id2:id4)   nx(id2)];               pz2y=[ny(id2)  ny(id2:id4)   ny(id4)];
                    pz3x=[nx(id4)  nx(id4:end) nx(1:id1)   nx(id1)];     pz3y=[ny(id4)  ny(id4:end) ny(1:id1)   ny(id4)];
                    pz4x=[nx(id3)  nx(id3:id2)   nx(id2)];               pz4y=[ny(id3)  ny(id3:id2)   ny(id3)];
              
                end
                
            zcol=[0.9 0.8 0.9; 0.5 0.5 0.9; 0.5 .7 0.5 ;  0.9 0.8 0];
            hold on;         fill(z11x,z11y,zcol(1,:));  % zone 11
            hold on;         fill(z12x,z12y,zcol(1,:));  % zone 12
            
            hold on;         fill(z21x,z21y,zcol(2,:));  % zone 21
            hold on;         fill(z22x,z22y,zcol(2,:));  % zone 22
            
            hold on;         fill(z31x,z31y,zcol(3,:));  % zone 31
            hold on;         fill(z32x,z32y,zcol(3,:));  % zone 32
            
            hold on;         fill(z41x,z41y,zcol(4,:));  % zone 41
            hold on;         fill(z42x,z42y,zcol(4,:));  % zone 42
            
           if rslp>0
            hold on;         fill(pz1x, pz1y,[1 1 0]);
            hold on;         fill(pz2x, pz2y,[1 1 0]);
            hold on;         fill(pz3x, pz3y,[ 0.5 1 0.5]);
            hold on;         fill(pz4x, pz4y,[ 0.5 1 0.5]);
           else
            hold on;         fill(pz1x, pz1y,[0.5 1 0.5]);
            hold on;         fill(pz2x, pz2y,[0.5 1 0.5]);
            hold on;         fill(pz3x, pz3y,[ 1 1 0]);
            hold on;         fill(pz4x, pz4y,[1 1 0]);
           end
           
            end     % iz==4
  
    
 
    end    % ishandle
    axis equal;
  
end        % iplot==2

%sh1=0.4; sh2=0.02;
sh1=0.1; sh2=0.02;


cx1=median(d91)-range(d91)/2;  cx2=median(d91)+range(d91)/2;
set(gca,'xlim',[cx1-sh1 cx1+sh1]); %, ...
cy1=median(d92)-range(d92)/2;  cy2=median(d92)+range(d92)/2;
set(gca, 'ylim',[cy1-sh2  cy2+sh2]);


%%
     
  % new axes
subplot(221);
if iplot==2;
    if iz==1
        hold on; fill(nx,ny,[0.5 0.5 0.5]);       % fill up ellipse 
        hold on; plot(xt,y,'b-.');    % eof1
        hold on; plot(xt,y2,'b-.');   % eof2
    end
    if iz==2 
        hold on; plot(nx,ny,'b','linewidth',1);   % ellipse profile 
        hold on; plot(xt,y,'b-.');    % eof1
        hold on; plot(xt,y2,'b-.');   % eof2
        hold on; scatter(varm0,vars0,'ko');   % original means and stds
    end
    if iz==3
        hold on; plot(nx,ny,'b','linewidth',1);   % ellipse profile 
        id=find(y<=mmy0(1) & y>=mmy0(2));
        hold on; plot(xt(id),y(id),'b-.');    %eof1
        
        id=find(y2<=mmy0(1) & y2>=mmy0(2));
        hold on; plot(xt,y2,'b-.');   %eof2
        %hold on; scatter(varm0,vars0,'ko');   % original means and stds       
    end
    
    if iz==4
        hold on; plot(nx,ny,'b','linewidth',1);   % ellipse profile 
        id=find(y<=mmy0(1) & y>=mmy0(2));
        hold on; plot(xt(id),y(id),'b-.');    %eof1
        
        id=find(y2<=mmy0(1) & y2>=mmy0(2));
        hold on; plot(xt,y2,'b-.');   %eof2
        hold on; scatter(varm0,vars0,'ko');   % original means and stds
       
       
    end
%% given point (in original coordiates)
hold on; plot(n1,n2,'o','markersize',6,'markerfacecolor',mcol,'markeredgecolor','none');
axis equal;

end

%==================================
% project one pnt to EOF space 

[nxe nye ]=ellipse_xy_ref(n1,n2,eofs,mcx,mcy,ea,eb);

%% ref. pnt at ellipse
if iplot==2;

subplot(221)
hold on; plot(nxe,nye,'b','marker','o','markerfacecolor', 'b','markersize',6);    % green circles at the ellipse
hold on; line([mcx n1],[mcy n2],'color','r','linewidth', 2);                      % center to point 
hold on; line([mcx nxe],[mcy nye],'color','b','linestyle','-.','linewidth', 2);   % center to ellipse point
%% add original axi
if iz==3 | iz==4
%ax=mmx0(2):range(mmx0)/100:mmx0(1);  hold on; plot(ax,ones(size(ax))*mcy,'k');
%y=mmy0(2):range(mmy0)/100:mmy0(1);  hold on; plot(ones(size(ax))*mcx,ay,'k');
else
ax=mcx-10:0.3:mcx+10;  hold on; plot(ax,ones(size(ax))*mcy,'k');
ay=mcy-10:0.3:mcy+10;  hold on; plot(ones(size(ax))*mcx,ay,'k');
end


%% 
if iz==1
set(gca,'xlim',[mcx-0.3 mcx+0.3]); %, ..
set(gca,'ylim',[mcy-0.2 mcy+0.2]); %, ..


set(gca,'xlim',[mcx-0.4 mcx+0.4]); %, ..
set(gca,'ylim',[mcy-0.2 mcy+0.2]); %, .
end


if iz==2
set(gca,'xlim',[mcx-1 mcx+1]); %, ..
set(gca,'ylim',[mcy-0.6 mcy+0.6]); %, .
end
%grid on;
%subplot(222);
%plot(mcx, mcy,'b*');
%hold on; plot(n1,n2,'ro');
%hold on; plot(nxe,nye,'ks');
%hold on;line([mcx n1],[mcy n2],'color','k');
%hold on; line([n1 nxe],[n2 nye],'color','m','linewidth',2);
%hold on; grid on;
end

return