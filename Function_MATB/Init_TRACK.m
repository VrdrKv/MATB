% function [h_cible,THETA_Force,joy]=Init_TRACK(f)
function [MATB_DATA]=Init_TRACK(MATB_DATA)

ColorBar=[0 0.4470 0.7410];
% Grande Transverse
plot(-10:10,zeros(21,1),'color',ColorBar); hold on
plot(zeros(21,1),-10:10,'color',ColorBar)
% Carre Centrale et Granc carre
% plot([-2 -2 2 2 -2],[-2 2 2 -2 -2],'--','color',[0 0.4470 0.7410])
plot([-1 -1 1 1 -1]*2,[-1 1 1 -1 -1]*2,'--','color',[0 0.4470 0.7410])
plot([-1 -1 1 1 -1]*4,[-1 1 1 -1 -1]*4,'--','color',[0 0.4470 0.7410])

% Petite Barre
plot([-2 2],[10 10],'color',ColorBar)
plot([-2 2],[6 6],'color',ColorBar)
plot([-2 2],[-6 -6],'color',ColorBar)
plot([-2 2],[-10 -10],'color',ColorBar)

plot([-1 1],[8 8],'color',ColorBar)
plot([-1 1],[4 4],'color',ColorBar)
plot([-1 1],[-4 -4],'color',ColorBar)
plot([-1 1],[-8 -8],'color',ColorBar)

plot([10 10],[-2 2],'color',ColorBar)
plot([6 6],[-2 2],'color',ColorBar)
plot([-6 -6],[-2 2],'color',ColorBar)
plot([-10 -10],[-2 2],'color',ColorBar)

plot([8 8],[-1 1],'color',ColorBar)
plot([4 4],[-1 1],'color',ColorBar)
plot([-4 -4],[-1 1],'color',ColorBar)
plot([-8 -8],[-1 1],'color',ColorBar)

plot([-10 -10 -8],[8 10 10],'color',ColorBar)
plot([-10 -10 -8],[-8 -10 -10],'color',ColorBar)
plot([10 10 8],[8 10 10],'color',ColorBar)
plot([10 10 8],[-8 -10 -10],'color',ColorBar)

% set(gcf,'position',[   866   284   728   677])
% grid on
axis off
set(gca,'XLimMode','Manual','YLimMode','Manual')

x=0; y=0;
r=1.5;
th = 0:pi/50:2*pi;
xunit = r * cos(th) + x;
yunit = r * sin(th) + y;
h_cr=plot(xunit, yunit,'k','linewidth',3);
h_cx=plot(x,y,'ok','linewidth',1,'markerfacecolor','k');
h_l1=plot([x x],[y+1.5 y+0.5],'k','linewidth',3);
h_l2=plot([x x],[y-1.5 y-0.5],'k','linewidth',3);
h_l3=plot([x+1.5 x+0.5],[y y],'k','linewidth',3);
h_l4=plot([x-1.5 x-0.5],[y y],'k','linewidth',3);
h_cible=[h_cr,h_cx,h_l1,h_l2,h_l3,h_l4];

title('TRACKING','fontsize',21,'color',ColorBar)

% Create joystick variable
ID = 1;
try
    joy=vrjoystick(ID);
catch
    warning('Problem Loading Joystick, be sure 1) its connected and ... 2) that you have the Simulink 3D Animation Toolbox');
    joy=[];
end

MATB_DATA.TRACK.JoystickID=joy;
MATB_DATA.TRACK.ThetaForce=0;
MATB_DATA.TRACK.handleCible=h_cible;







