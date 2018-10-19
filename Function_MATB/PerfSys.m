% PSfig=figure('position',[398   561   588   366],'menubar','none','numbertitle','off');
   
plot([1 3],[0 0],'k','linewidth',3); hold on
plot([3 5],[0 0],'Color',[1 0.6 0],'linewidth',3)
plot([5 7],[0 0],'r','linewidth',3)

PerfSysVal=max(min(mean(PS),7),1);
plot(PerfSysVal,0,'ok','markersize',10,'linewidth',2)

text(-.2,0.2,'\bf Alarm Mean Reaction Time','fontsize',20)

text(.5,0.07,'1sec','fontsize',20)
text(6,0.07,'7sec','fontsize',20,'color','r')
ttt=text(2.5,-.07,[num2str(round(mean(PS),2)) ' seconds'],'fontsize',20);


if mean(PS) <= 7 && mean(PS) > 4
    set(ttt,'color',[1 0.6 0])
else if mean(PS) <= 4
         set(ttt,'color','k')
    else
       set(ttt,'color','r')
    end

end

xlim([0 8])
ylim([-0.3 0.4])

axis off
% grid on