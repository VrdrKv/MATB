function Init_MATB
global MATB_DATA
%--------- Generate full screen black window behind
% figure('position',get(0,'Screensize')+[-1 -1 1 1]*10,'menubar','none','numbertitle','off','color','k');
% ScrSize=get(0,'ScreenSize');
% f=figure('position',[(ScrSize(3)/2)-(ScrSize(4)/2) 0 ScrSize(4) (ScrSize(3)/2)+(ScrSize(4)/2)],...,'windowstate','fullscreen'
%     'menubar','none','numbertitle','off','resize','on');
% % set(gcf,'position',[425         20        1100        1040]);
figure('windowstate','fullscreen','color','k','menubar','none',...
    'CloseRequestFcn',@CloseFigEmpty)

%--------- MATB main figure -------
MATB_DATA.MainFigurePosition=[ 428 32   1100  1020];
f=figure('position',MATB_DATA.MainFigurePosition,...
    'menubar','none','numbertitle','off','resize','off',...
    'visible','off','CloseRequestFcn',@CloseFigEmpty,...
    'WindowKeyPressFcn',@Update_KEYBOARD);
% f=figure('position',[425         20        1100        1020],...
%     'menubar','none','numbertitle','off','resize','off');
MATB_DATA.MainFigure=f;
% f.Color=[1 1 1];

set(f, 'Renderer','painters'); % Note: this is a figure property

%--------- Initialize all the Subtasks
Init_TRACK()
Init_SYSMON()
Init_RESMAN()
Init_COMM()

drawnow; set(f,'visible','on');
% KbName('UnifyKeyNames');
