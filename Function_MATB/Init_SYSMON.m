function Init_SYSMON
global MATB_DATA

subplot('Position',[0.05,0.5+0.05,0.30,0.4])
% set(gca, 'DrawMode','fast'); % 'normal' is the default axes value

ColorBar2=[116/256 208/256 241/256];
Colorbar=[0 0.4470 0.7410];

fill([1 1 2 2],[0 11 11 0],ColorBar2); hold on
fill([3 3 4 4],[0 11 11 0],ColorBar2);
fill([5 5 6 6],[0 11 11 0],ColorBar2);
fill([7 7 8 8],[0 11 11 0],ColorBar2);

ylim([0 14])
axis off

MATB_DATA.SYSMON.Alarm(1)=fill([1 1 2 2],[2 5 5 2],Colorbar); hold on
MATB_DATA.SYSMON.Alarm(2)=fill([3 3 4 4],[2 5 5 2],Colorbar);
MATB_DATA.SYSMON.Alarm(3)=fill([5 5 6 6],[2 5 5 2],Colorbar);
MATB_DATA.SYSMON.Alarm(4)=fill([7 7 8 8],[2 5 5 2],Colorbar);

MATB_DATA.SYSMON.PointeurAlarm(1)=text(1.6,3.5,'>>','color',[1 1 0],'fontsize',10);
MATB_DATA.SYSMON.PointeurAlarm(2)=text(3.6,3.5,'>>','color',[1 1 0],'fontsize',10);
MATB_DATA.SYSMON.PointeurAlarm(3)=text(5.6,3.5,'>>','color',[1 1 0],'fontsize',10);
MATB_DATA.SYSMON.PointeurAlarm(4)=text(7.6,3.5,'>>','color',[1 1 0],'fontsize',10);

tit = title('MONITORING','fontsize',21,'color',Colorbar);

for i=1:10
    plot([1 2],[i i],'k')
    plot([3 4],[i i],'k')
    plot([5 6],[i i],'k')
    plot([7 8],[i i],'k')
end

MATB_DATA.SYSMON.Alarm(5)=fill([1 1 4 4],[12 14 14 12]-0.5,'g'); tF5=text(2,13-0.5,'F5','Fontsize',20);
MATB_DATA.SYSMON.Alarm(6)=fill([5 5 8 8],[12 14 14 12]-0.5,[.94 .94 .94]); tF6=text(6,13-0.5,'F6','Fontsize',20);
% pause(0.1)
% [MATB_DATA]=Button_SYSMON(MATB_DATA);

te(1)=text(1.2,-0.5,'F1','fontsize',21,'color',Colorbar);
te(2)=text(3.2,-0.5,'F2','fontsize',21,'color',Colorbar);
te(3)=text(5.2,-0.5,'F3','fontsize',21,'color',Colorbar);
te(4)=text(7.2,-0.5,'F4','fontsize',21,'color',Colorbar);

if MATB_DATA.Param.Retro
    set( get(gca,'children'), 'linewidth', 4)
    set(tit,'fontsize',30,'FontSmoothing','off');
    set([tF5 tF6 te],'fontsize',30,'FontSmoothing','off');
    set(te,'fontsize',25,'FontSmoothing','off');
    
    set(MATB_DATA.SYSMON.PointeurAlarm,'fontsize',21);
    
    MATB_DATA.SYSMON.PointeurAlarm(1).Position(1) = MATB_DATA.SYSMON.PointeurAlarm(1).Position(1) -0.4;
    MATB_DATA.SYSMON.PointeurAlarm(2).Position(1) = MATB_DATA.SYSMON.PointeurAlarm(2).Position(1) -0.4;
    MATB_DATA.SYSMON.PointeurAlarm(3).Position(1) = MATB_DATA.SYSMON.PointeurAlarm(3).Position(1) -0.4;
    MATB_DATA.SYSMON.PointeurAlarm(4).Position(1) = MATB_DATA.SYSMON.PointeurAlarm(4).Position(1) -0.4;
end

faulty_al=zeros(6,3); % Etat 0:Ok 1:faulty / Valeur(F1F4) 1:haut -1 bas / GetsActivation
MATB_DATA.SYSMON.EtatAlarm=faulty_al;


