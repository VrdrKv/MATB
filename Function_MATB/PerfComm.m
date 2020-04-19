% PCfig=figure('position',[386    81   588   366],'menubar','none','numbertitle','off');

%paramètres d'origine (Kevin)
% plot([0 3],[0 0],'k','linewidth',3); hold on
% plot([3 6],[0 0],'Color',[1 0.6 0],'linewidth',3)
% plot([6 9],[0 0],'r','linewidth',3)

% text(-1.5,0.5,'\bf Communication Exactitude','fontsize',20)

% text(0,0.07,'10/10','fontsize',20)
% text(3,0.07,'7/10','fontsize',20,'color',[1 0.6 0])
% text(6,0.07,'4/10','fontsize',20,'color','r')
% 
% if PC < 8  && PC > 4
%       text(3.5,0.3,[ num2str(PC) ' / 10 '],'fontsize',27,'color',[1 0.6 0])
% else if PC < 6
%         text(3.5,0.3,[ num2str(PC) ' / 10 '],'fontsize',27,'color','r')
%     else
%         text(3.5,0.3,[ num2str(PC) ' / 10 '],'fontsize',27)
%     end
% end
% 
% 
% PC=max(PC,1);
% plot(10-PC,0,'ok','markersize',10,'linewidth',2)
% 
% 
% xlim([-1 10])
% ylim([-0.2 0.7])

%modifications d'affichage en fonction du block expérimental (AL)----------

if MATB_DATA.ScenarioNumber <= 2
    
    plot([0 1],[0 0],'k','linewidth',3); hold on
    plot([1 2],[0 0],'r','linewidth',3)
    text(0.15,0.5,'\bf Communication Exactitude','fontsize',20)
    text(-0.1,0.07,'2/2','fontsize',20)
    text(0.95,0.07,'1/2','fontsize',20,'color','r')
    text(1.95,0.07,'0/2','fontsize',20,'color','r')
    
    if PC <= 1
        text(0.9,0.3,[ num2str(PC) ' / 2'],'fontsize',27,'color','r')
        plot(2-PC,0,'ok','markersize',10,'linewidth',2)
    
    else
        text(0.9,0.3,[ num2str(PC) ' / 2 '],'fontsize',27)
        plot(2-PC,0,'ok','markersize',10,'linewidth',2)
    
    end
    
    xlim([-0.1 2.1])
    ylim([-0.2 0.7])
  
    
else
    
    plot([0 3],[0 0],'k','linewidth',3); hold on
    plot([3 6],[0 0],'Color',[1 0.6 0],'linewidth',3)
    plot([6 9],[0 0],'r','linewidth',3)
    text(-1.5,0.5,'\bf Communication Exactitude','fontsize',20)
    text(1,0.07,'5/5','fontsize',20)
    text(3.8,0.07,'3/5','fontsize',20,'color',[1 0.6 0])
    text(7,0.07,'1/5','fontsize',20,'color','r')
    
    if PC == 3
        text(3.5,0.3,[ num2str(PC) ' / 5 '],'fontsize',27,'color',[1 0.6 0])
        PC=max(PC,1);
        plot(10-2*PC,0,'ok','markersize',10,'linewidth',2)
    
    elseif PC <= 2
        text(3.5,0.3,[ num2str(PC) ' / 5 '],'fontsize',27,'color','r')
        PC=max(PC,1);
        plot(10-2*PC,0,'ok','markersize',10,'linewidth',2)
   
    else
        text(3.5,0.3,[ num2str(PC) ' / 5 '],'fontsize',27)
        PC=max(PC,1);
        plot(10-2*PC,0,'ok','markersize',10,'linewidth',2)
        
    end

xlim([-1 10])
ylim([-0.2 0.7])  

end

%------------------------------------------------------------------------


axis off
% grid on
