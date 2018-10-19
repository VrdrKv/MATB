function [MATB_DATA]=Init_MATB(MATB_DATA)

% BlackScreen
figure('position',get(0,'Screensize')+[-1 -1 1 1]*10,'menubar','none','numbertitle','off','color','k','windowstyle','modal');
% ScrSize=get(0,'ScreenSize');
% f=figure('position',[(ScrSize(3)/2)-(ScrSize(4)/2) 0 ScrSize(4) (ScrSize(3)/2)+(ScrSize(4)/2)],...
%     'menubar','none','numbertitle','off','resize','on');
% % set(gcf,'position',[425         20        1100        1040]);
f=figure('position',[425         20        1100        1020],...
    'menubar','none','numbertitle','off','resize','off','windowstyle','modal');
% f=figure('position',[425         20        1100        1020],...
%     'menubar','none','numbertitle','off','resize','off');
MATB_DATA.MainFigure=f;

subplot('Position',[0.48,0.53,0.4,0.4])
[MATB_DATA]=Init_TRACK(MATB_DATA);

subplot('Position',[0.05,0.5+0.05,0.30,0.4])
[MATB_DATA]=Init_SYSMON(MATB_DATA);

subplot('Position',[0.35,0.05,0.6,0.4])
[MATB_DATA]=Init_RESMAN(MATB_DATA);

subplot('Position',[0.17,0.4,0.05,0.05])
[MATB_DATA]=Init_COMM(MATB_DATA);

InitializePsychSound
if IsLinux
    pahandle = PsychPortAudio('Open');
else
    pahandle = PsychPortAudio('Open',[],[],0,[],2);
end

% [y,Fs] = audioread('Audio/OWN_TESTFILE.wav');
% y2=resample(y,44100,Fs);
% PsychPortAudio('FillBuffer', pahandle, [y2' ; y2']);
% PsychPortAudio('Start', pahandle,1,0,1);

% PsychPortAudio('FillBuffer', pahandle, [MATB_DATA.COMM.ListFichierAudio{1}' ; MATB_DATA.COMM.ListFichierAudio{1}']);
% PsychPortAudio('Start', pahandle,1,0,1);

MATB_DATA.handlePortAudio=pahandle;
drawnow
KbName('UnifyKeyNames');
