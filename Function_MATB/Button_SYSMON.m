function Button_SYSMON
global MATB_DATA
f=MATB_DATA.MainFigure;
% FigPos=get(f,'position');
% LargeurFig=FigPos(3);
% HauteurFig=FigPos(4);
MATB_DATA.SYSMON.Alarm(5) = uicontrol(f,'Style','pushbutton','String','F5',...
     'Position',[110 900 100 60],'Fontsize',18,'BackgroundColor',[0 1 0],'Callback', @resetF5);
%     'Position',[LargeurFig*0.15 HauteurFig*0.605 100 60],'Fontsize',18,'BackgroundColor',[0 1 0],'Callback', @resetF5);
   
MATB_DATA.SYSMON.Alarm(6) = uicontrol(f,'Style','pushbutton','String','F6',...
    'Position',[270 900 100 60],'Fontsize',18,'BackgroundColor',[0.94 0.94 0.94],'Callback',@resetF6);
%     'Position',[LargeurFig*0.30 HauteurFig*0.605 100 60],'Fontsize',18,'BackgroundColor',[0.94 0.94 0.94],'Callback',@resetF6);

    function resetF5(source,event)
        set(source,'BackgroundColor',[0 1 0])
        evalin('base','MATB_DATA.SYSMON.EtatAlarm(5,1)=0');
        send_log('MS F5','')
    end

    function resetF6(source,event)
        set(source,'BackgroundColor',[0.94 0.94 0.94])
        evalin('base','MATB_DATA.SYSMON.EtatAlarm(6,1)=0');
        send_log('MS F6','')
    end
end
