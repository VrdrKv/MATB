function [pmp]=Button_RESMAN(f)
global MATB_DATA

% FigPos=get(f,'position');
% LargeurFig=FigPos(3);
% HauteurFig=FigPos(4);
LargeurFig=1100;
HauteurFig=1450;

if MATB_DATA.Param.Retro 
    FtSiz = 18;
else
    FtSiz = 13;
end

pmp(7) = uicontrol(f,'Style','pushbutton','String','> 7 ',...
    'Position',[LargeurFig*0.62 HauteurFig*0.28 70 30],'Fontsize',FtSiz,'BackgroundColor',[0.94 0.94 0.94],'Callback',{@changeState});
pmp(8) = uicontrol(f,'Style','pushbutton','String','< 8',...
    'Position',[LargeurFig*0.62 HauteurFig*0.22 70 30],'Fontsize',FtSiz,'BackgroundColor',[0.94 0.94 0.94],'Callback',{@changeState});
pmp(1) = uicontrol(f,'Style','pushbutton','String','^ 1',...
    'Position',[LargeurFig*0.39 HauteurFig*0.15 70 30],'Fontsize',FtSiz,'BackgroundColor',[0.94 0.94 0.94],'Callback',{@changeState});
pmp(2) = uicontrol(f,'Style','pushbutton','String','^ 2',...
    'Position',[LargeurFig*0.57 HauteurFig*0.15 70 30],'Fontsize',FtSiz,'BackgroundColor',[0.94 0.94 0.94],'Callback',{@changeState});
pmp(3) = uicontrol(f,'Style','pushbutton','String','^ 3',...
    'Position',[LargeurFig*0.69 HauteurFig*0.15 70 30],'Fontsize',FtSiz,'BackgroundColor',[0.94 0.94 0.94],'Callback',{@changeState});
pmp(4) = uicontrol(f,'Style','pushbutton','String','^ 4',...
    'Position',[LargeurFig*0.87 HauteurFig*0.15 70 30],'Fontsize',FtSiz,'BackgroundColor',[0.94 0.94 0.94],'Callback',{@changeState});
pmp(5) = uicontrol(f,'Style','pushbutton','String','< 5',...
    'Position',[LargeurFig*0.46 HauteurFig*0.07 70 30],'Fontsize',FtSiz,'BackgroundColor',[0.94 0.94 0.94],'Callback',{@changeState});
pmp(6) = uicontrol(f,'Style','pushbutton','String','< 6',...
    'Position',[LargeurFig*0.76 HauteurFig*0.07 70 30],'Fontsize',FtSiz,'BackgroundColor',[0.94 0.94 0.94],'Callback',{@changeState});

function changeState(source,~)
% StatePMP(NumPmp) 
%     set(source,'backgroundColor',[0 1 0]); StatePMP(NumPmp)=1
% if StatePMP(NumPmp)==0
%     set(source,'backgroundColor',[0 1 0]); evalin('base','StatePMP(NumPmp) = 1')
% else if StatePMP(NumPmp)==1
%         set(source,'backgroundColor',[0.94 0.94 0.94]); StatePMP(NumPmp)=0;
%     else if StatePMP(NumPmp)==2
%             set(source,'backgroundColor',[1 0 0]);
%         end
%     end
% end

%% Fonctionel
C=get(source,'backgroundcolor');
if all(C==[0.94 0.94 0.94])
    set(source,'backgroundColor',[0 1 0])
else if all(C==[0 1 0])
        set(source,'backgroundColor',[0.94 0.94 0.94])
    end
end
S=get(source,'String');
send_log('MS PMP',S(3))

