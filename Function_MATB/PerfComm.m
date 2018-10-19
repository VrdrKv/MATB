% PCfig=figure('position',[386    81   588   366],'menubar','none','numbertitle','off');


plot([0 3],[0 0],'k','linewidth',3); hold on
plot([3 6],[0 0],'Color',[1 0.6 0],'linewidth',3)
plot([6 9],[0 0],'r','linewidth',3)

text(-1.5,0.5,'\bf Communication Exactitude','fontsize',20)

text(0,0.07,'10/10','fontsize',20)
text(3,0.07,'7/10','fontsize',20,'color',[1 0.6 0])
text(6,0.07,'4/10','fontsize',20,'color','r')



if PC < 8  && PC > 4
    text(3.5,0.3,[ num2str(PC) ' / 10 '],'fontsize',27,'color',[1 0.6 0])
else if PC < 6
        text(3.5,0.3,[ num2str(PC) ' / 10 '],'fontsize',27,'color','r')
    else
        text(3.5,0.3,[ num2str(PC) ' / 10 '],'fontsize',27)
    end
    
end
PC=max(PC,1);
plot(10-PC,0,'ok','markersize',10,'linewidth',2)


xlim([-1 10])
ylim([-0.2 0.7])

axis off
% grid on
