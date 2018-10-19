%         [pmp,al,faulty_al,LastUpdate_KB]=Update_KEYBOARD(pmp,al,faulty_al);
function [MATB_DATA]=Update_KEYBOARD(MATB_DATA)
% Update_KeyBoard

AutreClavierF1F6={'w','x','c','v','b','n'};
ToucheF1F6=cat(2,AutreClavierF1F6,'F');

if IsLinux % Linux + Double Clavier
    [ keyIsDown1, ~, keyCode1 ] = KbCheck(7);
    [ keyIsDown2, ~, keyCode2 ] = KbCheck(6);
else % Windows
    %     [ keyIsDown1, ~, keyCode1 ] = KbCheck; keyIsDown2=0; keyCode2=keyCode1;
    [ keyIsDown1, firstPress]=KbQueueCheck([]); keyIsDown2=0;
end

% keyCode1 = find(keyCode1, 1);
% keyCode2 = find(keyCode2, 1);

if keyIsDown1 || keyIsDown2
    if keyIsDown1
        %         Kb=1; KeyName=KbName(keyCode1);
        Kb=1; KeyName=KbName(find(firstPress,1));
    else
        Kb=2; KeyName=KbName(keyCode2);
    end
    %     fprintf('"%s" typed at time %.3f seconds\n', KbName(keyCode), timeSecs - startSecs);
    
    if ~isempty(KeyName)
        %---------- Gestion Pompe Clavier
        if any(str2double(KeyName(1)) == 1:8)
            POMPE_Number=find(str2double(KeyName(1)) == 1:8);
            
            if size(KeyName,2)==2
                send_log(['KB' num2str(1) ' PMP'],KeyName(1))
            else
                send_log(['KB' num2str(2) ' PMP'],KeyName(1))
            end
            %         MATB_DATA.KeyboardAction{MATB_DATA.ScenarioNumber}=cat(1,MATB_DATA.KeyboardAction{MATB_DATA.ScenarioNumber},['KB '
            
            colorPMP=cell2mat(get(MATB_DATA.RESMAN.handlePompe,'backgroundcolor')); % Recherche l'Etat des pompes
            StatePMP_k(colorPMP(:,1)==0.94)=0; % Eteint
            StatePMP_k(colorPMP(:,1)==0)=1; % Allume
            StatePMP_k(colorPMP(:,1)==1)=2; % Panne (pas de flux)
            
            if StatePMP_k(POMPE_Number) == 0
                set(MATB_DATA.RESMAN.handlePompe(POMPE_Number),'backgroundColor',[0 1 0])
            else if StatePMP_k(POMPE_Number) == 1
                    set(MATB_DATA.RESMAN.handlePompe(POMPE_Number),'backgroundColor',[0.94 0.94 0.94])
                end
            end
            
        end
        
        %---------- Gestion Alarme Clavier
        if ismember(KeyName(1), ToucheF1F6 )
            
            if ismember(KeyName(1), AutreClavierF1F6)
                ALARM_Number = find(strcmp(AutreClavierF1F6,KeyName(1)));
                Kb=2;
            else
                ALARM_Number=str2double(KeyName(2));
                Kb=1;
            end
            
            if ALARM_Number < 7
                
                if ~any(MATB_DATA.SYSMON.EtatAlarm(:,1))
                    send_log(['KB' num2str(Kb) ' SYSM'],['False F' num2str(ALARM_Number)])
                end
                
                if any(ALARM_Number==1:4) && MATB_DATA.SYSMON.EtatAlarm(ALARM_Number,1)==1
                    MATB_DATA.SYSMON.EtatAlarm(ALARM_Number,1:2)=[0 0];
                    
                    tRep=GetSecs-MATB_DATA.SYSMON.EtatAlarm(ALARM_Number,3);
                    MATB_DATA.SYSMON.DATA{MATB_DATA.ScenarioNumber}=cat(1,MATB_DATA.SYSMON.DATA{MATB_DATA.ScenarioNumber},...
                        [ALARM_Number, tRep ]);
                    send_log(['KB' num2str(Kb) ' SYSM'],['F' num2str(ALARM_Number) ' - ' num2str(tRep) ' secs'])
                end
                
                if ALARM_Number == 5 &&  MATB_DATA.SYSMON.EtatAlarm(5,1)==1
                    set(MATB_DATA.SYSMON.Alarm(5),'FaceColor',[0 1 0])
                    MATB_DATA.SYSMON.EtatAlarm(5,1)=0;
                    
                    tRep=GetSecs-MATB_DATA.SYSMON.EtatAlarm(ALARM_Number,3);
                    MATB_DATA.SYSMON.DATA{MATB_DATA.ScenarioNumber}=cat(1,MATB_DATA.SYSMON.DATA{MATB_DATA.ScenarioNumber},...
                        [ALARM_Number, tRep ]);
                    send_log(['KB' num2str(Kb) ' SYSM'],['F' num2str(ALARM_Number) ' - ' num2str(tRep) ' secs'])
                end
                if  ALARM_Number == 6 && MATB_DATA.SYSMON.EtatAlarm(6,1)==1
                    set(MATB_DATA.SYSMON.Alarm(6),'FaceColor',[.94 .94 .94])
                    MATB_DATA.SYSMON.EtatAlarm(6,1)=0;
                    
                    tRep=GetSecs-MATB_DATA.SYSMON.EtatAlarm(ALARM_Number,3);
                    MATB_DATA.SYSMON.DATA{MATB_DATA.ScenarioNumber}=cat(1,MATB_DATA.SYSMON.DATA{MATB_DATA.ScenarioNumber},...
                        [ALARM_Number, tRep ]);
                    send_log(['KB' num2str(Kb) ' SYSM'],['F' num2str(ALARM_Number) ' - ' num2str(tRep) ' secs'])
                end
                
            end
        end
        
    end
    %     if IsLinux
    %     KbReleaseWait;
    %     end
end
MATB_DATA.LastUpdate.KB=GetSecs;
