% PTfig=figure('position',[1004  563  588  366],'menubar','none','numbertitle','off');

x=2; y=0;
r=1.5;
th = 0:pi/50:2*pi;
xunit = r * cos(th) + x;
yunit = r * sin(th) + y;
h_cr=plot(xunit, yunit,'k','linewidth',3); hold on
h_cx=plot(x,y,'ok','linewidth',1,'markerfacecolor','k');
h_l1=plot([x x],[y+1.5 y+0.5],'k','linewidth',3);
h_l2=plot([x x],[y-1.5 y-0.5],'k','linewidth',3);
h_l3=plot([x+1.5 x+0.5],[y y],'k','linewidth',3);
h_l4=plot([x-1.5 x-0.5],[y y],'k','linewidth',3);
h_cible=[h_cr,h_cx,h_l1,h_l2,h_l3,h_l4];
text(1,-2.5,num2str(TempsPasseNoir),'fontsize',20)

x=6; y=0;
r=1.5;
th = 0:pi/50:2*pi;
xunit = r * cos(th) + x;
yunit = r * sin(th) + y;
h_cr=plot(xunit, yunit,'k','linewidth',3); hold on
h_cx=plot(x,y,'ok','linewidth',1,'markerfacecolor','k');
h_l1=plot([x x],[y+1.5 y+0.5],'k','linewidth',3);
h_l2=plot([x x],[y-1.5 y-0.5],'k','linewidth',3);
h_l3=plot([x+1.5 x+0.5],[y y],'k','linewidth',3);
h_l4=plot([x-1.5 x-0.5],[y y],'k','linewidth',3);
h_cible=[h_cr,h_cx,h_l1,h_l2,h_l3,h_l4];
set(h_cible,'Color',[1 0.6 0],'MarkerFaceColor',[1 0.6 0])
text(5,-2.5,num2str(TempsPasseOrange),'fontsize',20)

x=10; y=0;
r=1.5;
th = 0:pi/50:2*pi;
xunit = r * cos(th) + x;
yunit = r * sin(th) + y;
h_cr=plot(xunit, yunit,'k','linewidth',3); hold on
h_cx=plot(x,y,'ok','linewidth',1,'markerfacecolor','k');
h_l1=plot([x x],[y+1.5 y+0.5],'k','linewidth',3);
h_l2=plot([x x],[y-1.5 y-0.5],'k','linewidth',3);
h_l3=plot([x+1.5 x+0.5],[y y],'k','linewidth',3);
h_l4=plot([x-1.5 x-0.5],[y y],'k','linewidth',3);
h_cible=[h_cr,h_cx,h_l1,h_l2,h_l3,h_l4];
set(h_cible,'Color','r','MarkerFaceColor','r')
text(9,-2.5,num2str(TempsPasseRouge),'fontsize',20)

xlim([-1 13.5])
ylim([-7 4])

PerfTrackVal=min(mean(PT)*2,12);
plot([0 4],[-6 -6],'k','linewidth',3)
plot([4 8],[-6 -6],'Color',[1 0.6 0],'linewidth',3)
plot([8 12],[-6 -6],'r','linewidth',3)
plot(PerfTrackVal,-6,'ok','markersize',10,'linewidth',2)

text(-.5,-5,'Perfect','fontsize',20)
text(9.5,-5,'Far away','fontsize',20,'color','r')
text(3,-4,'\bf Mean distance','fontsize',20,'color','k')
text(1.3,3,'\bf Tracking Percentage','fontsize',20)

% text(0,-5,['Mean Distance : ' num2str(round(mean(PT),2)) ' / 10 '],'fontsize',20)

axis off
% grid on



