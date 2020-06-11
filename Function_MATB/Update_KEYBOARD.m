function Update_KEYBOARD(~,eventdata)
global MATB_DATA
% Update_KeyBoard

% KEY CONFIG
% AutreClavierF1F6={'z','e','r','t','y','u'};
AutreClavierF1F6={};
ToucheF1F6=cat(2,AutreClavierF1F6,'f');

TouchePompeKb1={'1','2','3','4','5','6','7','8'}; % pour utiliser le clavier de COCPIT pour les pompes. Attention, les touches ...
% devraient normalement etre les caractères speciaux de la premiere ligne du clavier comme ci-apres TouchePompeKb1={'1!','2@',"3#",'4$','6^','7&','8*','9('};
% mais la fonction ismember(KeyName(1), TouchePompe) ne considere que le premier terme du keyname. nousa avons donc simplement garde les premiers
% caracteres

%TouchePompeKb1={'1','2','3','4','5','6','7','8'}; %  pour utiliser les touches du pave numerique (i.e., comme initialement programme)
%TouchePompeKb2={'w','x','c','v','b','n',',','.'};
TouchePompeKb2={};
TouchePompe=cat(2,TouchePompeKb1,TouchePompeKb2);

% if IsLinux % % Linux + Double Clavier
%     [ keyIsDown1, ~, keyCode1 ] = KbCheck(7);
%     [ keyIsDown2, ~, keyCode2 ] = KbCheck(6);
% else % Windows
%     %     [ keyIsDown1, ~, keyCode1 ] = KbCheck; keyIsDown2=0; keyCode2=keyCode1;
%     [ keyIsDown1, firstPress]=KbQueueCheck([]); keyIsDown2=0;
% end

% keyCode1 = find(keyCode1, 1);
% keyCode2 = find(keyCode2, 1);

% if keyIsDown1 || keyIsDown2
%     if keyIsDown1
% % %           Kb=1; KeyName=KbName(keyCode1);
%         Kb=1; KeyName=KbName(find(firstPress,1));
%     else
%         Kb=2; KeyName=keyCode2;
%         %Kb=2; KeyName=KbName(keyCode2);
%     end
%     %     fprintf('"%s" typed at time %.3f seconds\n', KbName(keyCode), timeSecs - startSecs);
KeyName = eventdata.Key;
%     if ~isempty(KeyName)
%---------- Gestion Pompe Clavier
if ismember(KeyName(1), TouchePompe)
    
    if ismember(KeyName(1), TouchePompeKb1)
        POMPE_Number=find(strcmp( KeyName(1),TouchePompeKb1));
        send_log(['KB' num2str(1) ' PMP'],num2str(POMPE_Number))
    else %ismember(KeyName(1), TouchePompeKb2)
        POMPE_Number=find(strcmp( KeyName(1),TouchePompeKb2  ));
        send_log(['KB' num2str(2) ' PMP'],num2str(POMPE_Number))
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
            
            tRep=hat-MATB_DATA.SYSMON.EtatAlarm(ALARM_Number,3);
            MATB_DATA.SYSMON.DATA{MATB_DATA.ScenarioNumber}=cat(1,MATB_DATA.SYSMON.DATA{MATB_DATA.ScenarioNumber},...
                [ALARM_Number, tRep ]);
            send_log(['KB' num2str(Kb) ' SYSM'],['F' num2str(ALARM_Number) ' - ' num2str(tRep) ' secs'])
        end
        
        if ALARM_Number == 5 &&  MATB_DATA.SYSMON.EtatAlarm(5,1)==1
            set(MATB_DATA.SYSMON.Alarm(5),'FaceColor',[0 1 0])
            MATB_DATA.SYSMON.EtatAlarm(5,1)=0;
            
            tRep=hat-MATB_DATA.SYSMON.EtatAlarm(ALARM_Number,3);
            MATB_DATA.SYSMON.DATA{MATB_DATA.ScenarioNumber}=cat(1,MATB_DATA.SYSMON.DATA{MATB_DATA.ScenarioNumber},...
                [ALARM_Number, tRep ]);
            send_log(['KB' num2str(Kb) ' SYSM'],['F' num2str(ALARM_Number) ' - ' num2str(tRep) ' secs'])
        end
        if  ALARM_Number == 6 && MATB_DATA.SYSMON.EtatAlarm(6,1)==1
            set(MATB_DATA.SYSMON.Alarm(6),'FaceColor',[.94 .94 .94])
            MATB_DATA.SYSMON.EtatAlarm(6,1)=0;
            
            tRep=hat-MATB_DATA.SYSMON.EtatAlarm(ALARM_Number,3);
            MATB_DATA.SYSMON.DATA{MATB_DATA.ScenarioNumber}=cat(1,MATB_DATA.SYSMON.DATA{MATB_DATA.ScenarioNumber},...
                [ALARM_Number, tRep ]);
            send_log(['KB' num2str(Kb) ' SYSM'],['F' num2str(ALARM_Number) ' - ' num2str(tRep) ' secs'])
        end
        
    end
    %         end
    
    %     end
    %     if IsLinux
    %     KbReleaseWait;
    %     end
end
% MATB_DATA.LastUpdate.KB=hat;
