function [MATB_DATA]=Init_MATB(MATB_DATA)

% figure('windowstate','fullscreen','color','k','menubar','none')

%--- MATB main figure -------
% MATB_DATA.MainFigurePosition=[ 428 32   1100  1020];
MATB_DATA.MainFigurePosition=[1921         481         480         577];

f=figure('position',MATB_DATA.MainFigurePosition,...
    'menubar','none','numbertitle','off','resize','on');
% f=figure('position',[425         20        1100        1020],...
%     'menubar','none','numbertitle','off','resize','off');
MATB_DATA.MainFigure=f;
f.Color=[1 1 1];

%--------- Initialize the COMMUNICATION task -------------
[MATB_DATA]=Init_COMM(MATB_DATA);

InitializePsychSound
if IsLinux
    pahandle = PsychPortAudio('Open');
else
    pahandle = PsychPortAudio('Open',[],[],0,[],2);
end


MATB_DATA.handlePortAudio=pahandle;
drawnow
KbName('UnifyKeyNames');
