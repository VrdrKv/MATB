function MATB_Main
global MATB_DATA

EVENT=MATB_DATA.EVENT{MATB_DATA.ScenarioNumber};

%%%%%%%%%% section relative à la calibration de l'eye-tracker
% if MATB_DATA.GazepointEyeTracker
%     pop_waiter('Procédons à la calibration de l eye-tracker',1);
%     [MATB_DATA]=Calibrate(MATB_DATA,1);
% %     pop_waiter('Let s calibrate Pilot Monitoring',1);
% %     [MATB_DATA]=Calibrate(MATB_DATA,2);
% end

%pop_waiter("Appuyez sur 'ENTREE' lorsque vous etes pret(e)",1)


% if MATB_DATA.ScenarioType(MATB_DATA.ScenarioNumber)==0
%     pop_waiter('DONT COOPERATE',1)
% else
%     pop_waiter('COOPERATE',1)
% end

if MATB_DATA.GazepointEyeTracker
    LaunchEyeTrack()
end

Start = GetSecs;
fprintf(MATB_DATA.LogFileID,'%s\t\t %.4f \t\t\t %s \n',char(datetime('now','Format','HH:mm:ss')),0,['STARTING SCENARIO' num2str(MATB_DATA.ScenarioNumber)]);
if MATB_DATA.LSL_Streaming
    MATB_DATA.LSLoutlet.push_sample({0,'STARTING',[' SCENARIO ' num2str(MATB_DATA.ScenarioNumber)]});
end

% if MATB_DATA.ScenarioType(MATB_DATA.ScenarioNumber)==0
%     Int='OFF';
% else
%     Int='ON';
% end
% if MATB_DATA.ScenarioType(MATB_DATA.ScenarioNumber)==0
%     WL_PF='EASY';
% else
%     WL_PF='HARD';
% end
if MATB_DATA.ScenarioType(MATB_DATA.ScenarioNumber)==0
    WL_PM='EASY';
else
    WL_PM='HARD';
end
fprintf(MATB_DATA.LogFileID,'%s\t\t %.4f \t\t\t %s \n',char(datetime('now','Format','HH:mm:ss')),0,[ ' Difficulty : ' WL_PM]);

MATB_DATA.LastUpdate.RESMAN=Start;
MATB_DATA.LastUpdate.SYSMON=Start;
MATB_DATA.LastUpdate.TRACK=Start;
MATB_DATA.LastUpdate.EVENT=Start;
MATB_DATA.LastUpdate.KB=Start;
MATB_DATA.LastUpdate.JS=Start;
MATB_DATA.LastUpdate.LOG=Start;

MATB_DATA.TRACK.DATA{MATB_DATA.ScenarioNumber}=[];
MATB_DATA.RESMAN.DATA{MATB_DATA.ScenarioNumber}=[];
MATB_DATA.COMM.DATA{MATB_DATA.ScenarioNumber}=[];
MATB_DATA.SYSMON.DATA{MATB_DATA.ScenarioNumber}=[];
MATB_DATA.KeyboardAction{MATB_DATA.ScenarioNumber}=[];

deviceIndex=[];
KbQueueCreate(deviceIndex);
KbQueueStart(deviceIndex);

set(MATB_DATA.MainFigure,'position',MATB_DATA.MainFigurePosition)
MATB_DATA.ScenarioStartedAt=Start;

while true % Main GAME LOOP
    t=GetSecs;
    %     set(MATB_DATA.MainFigure,'name',['Elapsed Time ' num2str(t-Start)])
    
    % SET EVENTS
    if any(EVENT(:,1)==round(t-Start,1)) &&  t-MATB_DATA.LastUpdate.EVENT > 0.2 % Si jamais y'a un event et qu'il attend 200ms
        lE=EVENT(EVENT(:,1)==round(t-Start,1),2:19);
        send_log('EVENT VECTOR',num2str(lE))
        MATB_ProcessEvent(lE);
    end
    
    % UPDATE ALL TASKS
    %     if t-MATB_DATA.LastUpdate.KB >= 0.0
    Update_KEYBOARD()
    Send_EyeTRACK()

    
	if ~isempty(MATB_DATA.TRACK.JoystickID) && sum(button(MATB_DATA.TRACK.JoystickID)) && GetSecs-MATB_DATA.LastUpdate.JS>=0.25
        Update_JOYSTICKBUT()
    end
    
    if t-MATB_DATA.LastUpdate.TRACK >= 0.02
        Update_TRACK()
    end
    if t-MATB_DATA.LastUpdate.RESMAN >= 1
        Update_RESMAN()
    end
    if t-MATB_DATA.LastUpdate.SYSMON >= 0.2
        Update_SYSMON()
    end
    if t-MATB_DATA.LastUpdate.LOG >= 0.5
        x=MATB_DATA.TRACK.handleCible(2).XData; y=MATB_DATA.TRACK.handleCible(2).YData;
        send_log('RESMAN',num2str(MATB_DATA.RESMAN.NiveauxPompe));
        send_log('TRACKING',num2str([x y]))
        
        MATB_DATA.TRACK.DATA{MATB_DATA.ScenarioNumber}=cat(1,MATB_DATA.TRACK.DATA{MATB_DATA.ScenarioNumber},[x y]);
        
        MATB_DATA.LastUpdate.LOG=GetSecs;
    end
    
    if t-Start > MATB_DATA.ScenarioDuration(MATB_DATA.ScenarioNumber)
        fprintf(MATB_DATA.LogFileID,'%s\t\t %.4f \t\t\t %s \n',char(datetime('now','Format','HH:mm:ss')),t-Start,['STOPING SCENARIO ' num2str(MATB_DATA.ScenarioNumber)]);
        if MATB_DATA.LSL_Streaming
            MATB_DATA.LSLoutlet.push_sample({0,'STOPING',[' SCENARIO ' num2str(MATB_DATA.ScenarioNumber)]});
        end
        PsychPortAudio('Stop', MATB_DATA.handlePortAudio);
        
        ReInit_MATB()
        break
    end
    %     pause(0.0001)
    drawnow
end

if MATB_DATA.GazepointEyeTracker
    CloseEyeTrack(MATB_DATA)
end
    
KbQueueStop