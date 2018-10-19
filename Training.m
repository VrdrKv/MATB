global Start MATB_DATA fileID outlet

deviceIndex=[];
KbQueueCreate(deviceIndex);
KbQueueStart(deviceIndex);
Start = GetSecs;
yesKeys = KbName('Return');

MATB_DATA.LastUpdate.RESMAN=Start;
MATB_DATA.LastUpdate.SYSMON=Start;
MATB_DATA.LastUpdate.TRACK=Start;
MATB_DATA.LastUpdate.EVENT=Start;
MATB_DATA.LastUpdate.KB=Start;
MATB_DATA.LastUpdate.LOG=Start;

MATB_DATA.TRACK.DATA{MATB_DATA.ScenarioNumber}=[];
MATB_DATA.RESMAN.DATA{MATB_DATA.ScenarioNumber}=[];
MATB_DATA.COMM.DATA{MATB_DATA.ScenarioNumber}=[];
MATB_DATA.SYSMON.DATA{MATB_DATA.ScenarioNumber}=[];
MATB_DATA.KeyboardAction{MATB_DATA.ScenarioNumber}=[];

%-------------------------------------------------------
%                   SYSMON
%-------------------------------------------------------
fprintf(fileID,'%s\t\t %.4f \t\t\t %s \n',char(datetime('now','Format','HH:mm:ss')),0,'TRAINING SYSMON');
outlet.push_sample({0,'TRAINING SYSMON',''});

pop_waiter('Let s try SYSMON Player 1',1)
pop=dialog('position',[1035  519  605 200]);
txt = uicontrol('Parent',pop,...
    'Style','text',...
    'Position', [-100 -100 850 250],...
    'String','For now everything is normal',...
    'Fontsize',18);

a=[ones(10,1) ; -ones(10,1)];
Ev=[randi(35,20,1)+15 randi(6,20,1) a(randperm(20))];

Start = GetSecs;
while true
    t=GetSecs;

    % SET EVENTS
    if round(t-Start,1)==10 &&  t-MATB_DATA.LastUpdate.EVENT > 0.2 % Si jamais y'a un event et qu'il attend 200ms
        close(pop)
        pop=dialog('position',[1035  519  605 200]);
        txt = uicontrol('Parent',pop,...
            'Style','text',...
            'Position', [-100 -100 850 250],...
            'String','Try to respond to alarms now',...
            'Fontsize',18);
        MATB_DATA.LastUpdate.EVENT=GetSecs;
    end

    if any(Ev(:,1)==round(t-Start,1))&&  t-MATB_DATA.LastUpdate.EVENT > 0.2 % Si jamais y'a un event et qu'il attend 200ms
        N_Ev=find(Ev(:,1)==round(t-Start,1));

        MATB_DATA.SYSMON.EtatAlarm(Ev(N_Ev,2),1)=1;
        MATB_DATA.SYSMON.EtatAlarm(Ev(N_Ev,2),2)=Ev(N_Ev,3);
        MATB_DATA.SYSMON.EtatAlarm(Ev(N_Ev,2),3)=GetSecs;
        MATB_DATA.LastUpdate.EVENT=GetSecs;
    end

    % UPDATE ALL TASKS
    if t-MATB_DATA.LastUpdate.KB >= 0.0
        [MATB_DATA]=Update_KEYBOARD(MATB_DATA);
    end

    if t-MATB_DATA.LastUpdate.SYSMON >= 0.2
        [MATB_DATA]=Update_SYSMON(MATB_DATA);
    end

    if t-Start > 60
        close(pop)
        break
    end
    drawnow
end


%-------------------------------------------------------
%                   TRACK
%-------------------------------------------------------
fprintf(fileID,'%s\t\t %.4f \t\t\t %s \n',char(datetime('now','Format','HH:mm:ss')),0,'TRAINING TRACK');
outlet.push_sample({0,'TRAINING TRACK',''});

pop_waiter('Let s try TRACK Player 1',1)
pop=dialog('position',[240 623 560 259]);
txt = uicontrol('Parent',pop,...
    'Style','text',...
    'Position', [-100 -100 850 250],...
    'String','Keep the Circle in the middle',...
    'Fontsize',18);
MATB_DATA.TRACK.Difficulty{1}=0;
Start = GetSecs;
while true
    t=GetSecs;

    % SET EVENTS
    if round(t-Start,1)==20 &&  t-MATB_DATA.LastUpdate.EVENT > 0.2 % Si jamais y'a un event et qu'il attend 200ms
        close(pop)
        pop=dialog('position',[240 623 560 259]);
        txt = uicontrol('Parent',pop,...
            'Style','text',...
            'Position', [-100 -100 850 250],...
            'String','It is going to be harder',...
            'Fontsize',18);
        MATB_DATA.LastUpdate.EVENT=GetSecs;
    end
    if round(t-Start,1)==25 &&  t-MATB_DATA.LastUpdate.EVENT > 0.2 % Si jamais y'a un event et qu'il attend 200ms
        MATB_DATA.TRACK.Difficulty{1}=1;
        MATB_DATA.LastUpdate.EVENT=GetSecs;
    end

    % UPDATE ALL TASKS
    if t-MATB_DATA.LastUpdate.KB >= 0.0
        [MATB_DATA]=Update_KEYBOARD(MATB_DATA);
    end

    if t-MATB_DATA.LastUpdate.TRACK >= 0.02
        [MATB_DATA]=Update_TRACK(MATB_DATA);
    end

    if t-Start > 60
        close(pop)
        break
    end
    drawnow
end


%-------------------------------------------------------
%                   RESMAN
%-------------------------------------------------------
fprintf(fileID,'%s\t\t %.4f \t\t\t %s \n',char(datetime('now','Format','HH:mm:ss')),0,'TRAINING RESMAN');
outlet.push_sample({0,'TRAINING RESMAN',''});

pop_waiter('Let s try RESMAN Player 2',1)

pop_nowait('The objective here is to keep the level in Tank A and B as close to 2500 as possible',yesKeys)
pop_nowait('2500 is symbolize by a line, and the blue level represents the critical level (between 2000 and 3000)',yesKeys)
pop_nowait('It is important to keep the level between 2000 and 3000, if not the levels numbers will become orange and the TRACKING task will become really harder',yesKeys)
pop_nowait('We will start soon. Remember, when a pump is gray its deactivated, green means activated and red means failed.',yesKeys)
pop_nowait('When a pump is failed, you cannot repair it, you just have to wait until its functional again',yesKeys)
pop_nowait('To activate a pump, just click on it or press the number on the keyboard one time, it will become green',yesKeys)
pop_nowait('When we will start, all pumps will be deactivated and Tank A & B will be emptying. So you will have to activate the pumps !',yesKeys)
pop_nowait('Alright, lets start, stay close to 2500, not less not more, 2500 ! Press ENTER when READY',yesKeys)

Start = GetSecs;
while true
    t=GetSecs;
    
    % SET EVENTS
    if round(t-Start,1)==20 &&  t-MATB_DATA.LastUpdate.EVENT > 0.2 % Si jamais y'a un event et qu'il attend 200ms
        pop1=dialog('position',[  30   403   746   276]);
        txt = uicontrol('Parent',pop1,...
            'Style','text',...
            'Position', [-50 -100 850 250],...
            'String','Pumps 1, 2, 3 and 4 are the most important',...
            'Fontsize',18);
        MATB_DATA.LastUpdate.EVENT=GetSecs;
    end
    if round(t-Start,1)==25 &&  t-MATB_DATA.LastUpdate.EVENT > 0.2 % Si jamais y'a un event et qu'il attend 200ms
        pop=dialog('position',[26    56   745   254]);
        txt = uicontrol('Parent',pop,...
            'Style','text',...
            'Position', [100 -100 600 250],...
            'String','Pumps 5 and 6 should be activate anytime to keep auxiliary tank (C and D) full. Tank E and F are unlimited.',...
            'Fontsize',18);
        MATB_DATA.LastUpdate.EVENT=GetSecs;
    end
    
    if round(t-Start,1)==40 &&  t-MATB_DATA.LastUpdate.EVENT > 0.2 % Si jamais y'a un event et qu'il attend 200ms
        close(pop); close(pop1)
        set(MATB_DATA.RESMAN.handlePompe([1 2]),'backgroundcolor',[1 0 0])
        pop1=dialog('position',[30  403  746  276]);
        txt = uicontrol('Parent',pop1,...
            'Style','text',...
            'Position', [100 -100 600 250],...
            'String','Now pumps 1 and 2 ar failed, they are not working anymore. You can only wait till their functional',...
            'Fontsize',18);
        MATB_DATA.LastUpdate.EVENT=GetSecs;
    end
    if round(t-Start,1)==45 &&  t-MATB_DATA.LastUpdate.EVENT > 0.2 % Si jamais y'a un event et qu'il attend 200ms
        pop=dialog('position',[26    56   745   254]);
        txt = uicontrol('Parent',pop,...
            'Style','text',...
            'Position', [100 -100 600 250],...
            'String','While waiting for pumps 1 and 2 you can activate pumps 8 to keep level in tank A stable',...
            'Fontsize',18);
        MATB_DATA.LastUpdate.EVENT=GetSecs;
    end
    
    % UPDATE ALL TASKS
    if t-MATB_DATA.LastUpdate.KB >= 0.0
        [MATB_DATA]=Update_KEYBOARD(MATB_DATA);
    end
    
    if t-MATB_DATA.LastUpdate.RESMAN >= 1
        [MATB_DATA]=Update_RESMAN(MATB_DATA);
    end
    
    if t-MATB_DATA.LastUpdate.LOG >= 0.5
        send_log('RESMAN',num2str(MATB_DATA.RESMAN.NiveauxPompe));
        MATB_DATA.LastUpdate.LOG=GetSecs;
    end
    
    if t-Start > 60
        close(pop); close(pop1);
        break
    end
    drawnow
end

% -------------------------------------------------------
%                   COMM
% -------------------------------------------------------
fprintf(fileID,'%s\t\t %.4f \t\t\t %s \n',char(datetime('now','Format','HH:mm:ss')),0,'TRAINING COMM');
outlet.push_sample({0,'TRAINING COMM',''});

pop_waiter('Let s try COMM Player 2',1)
pop=dialog('position',[937   177   560   299]);
txt = uicontrol('Parent',pop,...
    'Style','text',...
    'Position', [-150 -100 850 250],...
    'String','Listen...',...
    'Fontsize',18);
drawnow;

Start = GetSecs;
while true
    t=GetSecs;

    % SET EVENTS
    if round(t-Start,1)==1 &&  t-MATB_DATA.LastUpdate.EVENT > 0.2 % Si jamais y'a un event et qu'il attend 200ms
        TypeOwnOth=1; TypeCOMM=1;
        IdFichier=find(MATB_DATA.COMM.IdxCOMM(:,1)==TypeOwnOth & MATB_DATA.COMM.IdxCOMM(:,2)==TypeCOMM);
        PsychPortAudio('FillBuffer', MATB_DATA.handlePortAudio,...
            [MATB_DATA.COMM.ListFichierAudio{IdFichier(1)}' ; MATB_DATA.COMM.ListFichierAudio{IdFichier(1)}']);
        PsychPortAudio('Start', MATB_DATA.handlePortAudio,1,0,1);

        MATB_DATA.LastUpdate.EVENT=GetSecs;
    end
    if round(t-Start,1)==3 &&  t-MATB_DATA.LastUpdate.EVENT > 0.2 % Si jamais y'a un event et qu'il attend 200ms
        f1=figure('position',[10 487 414 121],'menubar','none','numbertitle','off');
        text(0,1,'This is for you NASA 504','fontsize',18);
        set(gca,'xlim',[0 2],'ylim',[0 2]); axis off
    end
    if round(t-Start,1)==8 &&  t-MATB_DATA.LastUpdate.EVENT > 0.2 % Si jamais y'a un event et qu'il attend 200ms
        close(pop)
        f2=figure('position',[10 330 414 121],'menubar','none','numbertitle','off');
        text(0,1,'Select NAV1 and put 110.650','fontsize',18);
        set(gca,'xlim',[0 2],'ylim',[0 2]); axis off
        MATB_DATA.LastUpdate.EVENT=GetSecs;
    end
    if round(t-Start,1)==12 &&  t-MATB_DATA.LastUpdate.EVENT > 0.2 % Si jamais y'a un event et qu'il attend 200ms
        f3=figure('position',[10 165 414 121],'menubar','none','numbertitle','off');
        text(0,1,'then press APPLY','fontsize',18);
        set(gca,'xlim',[0 2],'ylim',[0 2]); axis off
        MATB_DATA.LastUpdate.EVENT=GetSecs;
    end

    if round(t-Start,1)==17 &&  t-MATB_DATA.LastUpdate.EVENT > 0.2 % Si jamais y'a un event et qu'il attend 200ms
        close([f1 f2 f3])

        TypeOwnOth=-1; TypeCOMM=3;
        IdFichier=find(MATB_DATA.COMM.IdxCOMM(:,1)==TypeOwnOth & MATB_DATA.COMM.IdxCOMM(:,2)==TypeCOMM);
        PsychPortAudio('FillBuffer', MATB_DATA.handlePortAudio,...
            [MATB_DATA.COMM.ListFichierAudio{IdFichier(1)}' ; MATB_DATA.COMM.ListFichierAudio{IdFichier(1)}']);
        PsychPortAudio('Start', MATB_DATA.handlePortAudio,1,0,1);

        MATB_DATA.LastUpdate.EVENT=GetSecs;
    end
    if round(t-Start,1)==20 &&  t-MATB_DATA.LastUpdate.EVENT > 0.2 % Si jamais y'a un event et qu'il attend 200ms
        f4=figure('position',[10 487 414 121],'menubar','none','numbertitle','off');
        text(0,1,'This one is not for you','fontsize',18);
        set(gca,'xlim',[0 2],'ylim',[0 2]); axis off

        MATB_DATA.LastUpdate.EVENT=GetSecs;
    end
    if round(t-Start,1)==22 &&  t-MATB_DATA.LastUpdate.EVENT > 0.2 % Si jamais y'a un event et qu'il attend 200ms
        f5=figure('position',[10 330 414 121],'menubar','none','numbertitle','off');
        text(0,1,'So you don t care :)','fontsize',18);
        set(gca,'xlim',[0 2],'ylim',[0 2]); axis off
        MATB_DATA.LastUpdate.EVENT=GetSecs;
    end

    if t-Start > 30
        close([f4 f5])
        break
    end
    drawnow
end

[MATB_DATA]=ReInit_MATB(MATB_DATA);
PsychPortAudio('Stop', MATB_DATA.handlePortAudio);
KbQueueStop


function pop_nowait(texte,yesKeys)
pop=dialog('position',[ 30   403   746   276]);
txt = uicontrol('Parent',pop,...
    'Style','text',...
    'Position', [100 -100 600 250],...
    'String',texte,...
    'Fontsize',18);
drawnow; pause(0.5)
while true
    [~,~,keyCode] = KbCheck;
    if any(keyCode(yesKeys))
        break
    end
end
close(pop)
end