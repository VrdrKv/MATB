% function [al,faulty_al]=Init_SYSMON(f)
function [MATB_DATA]=Init_SYSMON(MATB_DATA)
%%
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

for i=1:10
    plot([1 2],[i i],'k')
    plot([3 4],[i i],'k')
    plot([5 6],[i i],'k')
    plot([7 8],[i i],'k')
end

MATB_DATA.SYSMON.Alarm(5)=fill([1 1 4 4],[12 14 14 12]-0.5,'g'); text(2,13-0.5,'F5','Fontsize',20)
MATB_DATA.SYSMON.Alarm(6)=fill([5 5 8 8],[12 14 14 12]-0.5,[.94 .94 .94]); text(6,13-0.5,'F6','Fontsize',20)
% pause(0.1)
% [MATB_DATA]=Button_SYSMON(MATB_DATA);

text(1.2,-0.5,'F1','fontsize',21,'color',Colorbar)
text(3.2,-0.5,'F2','fontsize',21,'color',Colorbar)
text(5.2,-0.5,'F3','fontsize',21,'color',Colorbar)
text(7.2,-0.5,'F4','fontsize',21,'color',Colorbar)

title('MONITORING','fontsize',21,'color',Colorbar)

faulty_al=zeros(6,3); % Etat 0:Ok 1:faulty   /   VAleur(F1F4) 1:haut -1 bas   / GetsActivation
MATB_DATA.SYSMON.EtatAlarm=faulty_al;