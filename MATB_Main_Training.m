function MATB_Main_Training

global fileID Start MATB_DATA outlet

EVENT=MATB_DATA.EVENT{MATB_DATA.ScenarioNumber};

Start = GetSecs;
fprintf(fileID,'%s\t\t %.4f \t\t\t %s \n',char(datetime('now','Format','HH:mm:ss')),0,'STARTING TRAINING');
outlet.push_sample({0,'STARTING TRAINING'});

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

while true
    t=GetSecs;
    set(MATB_DATA.MainFigure,'name',['Elapsed Time ' num2str(t-Start)])
    
    % SET EVENTS
    if any(EVENT(:,1)==round(t-Start,1)) &&  t-MATB_DATA.LastUpdate.EVENT > 0.2 % Si jamais y'a un event  et qu'il attend 200ms
        lE=EVENT(EVENT(:,1)==round(t-Start,1),2:19);
        send_log('EVENT VEC',num2str(lE))
        [MATB_DATA]=MATB_ProcessEvent(MATB_DATA,lE);
    end
    
    % UPDATE ALL TASKS
    if t-MATB_DATA.LastUpdate.KB >= 0.01
        [MATB_DATA]=Update_KEYBOARD(MATB_DATA);
    end
    
    if t-MATB_DATA.LastUpdate.TRACK >= 0.02
        [MATB_DATA]=Update_TRACK(MATB_DATA);
    end
    if t-MATB_DATA.LastUpdate.RESMAN >= 1
        [MATB_DATA]=Update_RESMAN(MATB_DATA);
    end
    if t-MATB_DATA.LastUpdate.SYSMON >= 0.2
        [MATB_DATA]=Update_SYSMON(MATB_DATA);
    end
    if t-MATB_DATA.LastUpdate.LOG >= 0.5
        x=MATB_DATA.TRACK.handleCible(2).XData; y=MATB_DATA.TRACK.handleCible(2).YData;
        send_log('RESMAN',num2str(MATB_DATA.RESMAN.NiveauxPompe));
        send_log('TRACKING',num2str([x y]))
        
        MATB_DATA.TRACK.DATA{MATB_DATA.ScenarioNumber}=cat(1,MATB_DATA.TRACK.DATA{MATB_DATA.ScenarioNumber},[x y]);
        
        MATB_DATA.LastUpdate.LOG=GetSecs;
    end
    
    if t-Start > MATB_DATA.TrainingDuration
        fprintf(fileID,'%s\t\t %.4f \t\t\t %s \n',char(datetime('now','Format','HH:mm:ss')),t-Start,['STOPING TRAINING']);
        outlet.push_sample({0,'STOPING TRAINING'});
        
        [MATB_DATA]=ReInit_MATB(MATB_DATA);
        break
    end
    %     pause(0.0001)
    drawnow
end
MATB_DATA.ScenarioNumber=MATB_DATA.ScenarioNumber+1;