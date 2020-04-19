function MATB_Main_Simu23_09

global fileID Start outlet outlet3 MATB_DATA

%--------------------partie dédiee à la réception du booléen provenant du script COCPIT--------------------
lib = lsl_loadlib(); % Charge la librairie LSL
Start_COMM_bool = {};
Start_COMM_bool_perf = {};
tic
while isempty(Start_COMM_bool)
    Start_COMM_bool = lsl_resolve_byprop(lib,'name','Booleen_COMM'); % Attend que le booléen soit envoyé sur LSL
    Start_COMM_bool_perf = lsl_resolve_byprop(lib,'name','Booleen_perf'); % Attend que le booléen des perf soit envoyé sur LSL
end
t = toc;
disp(['boucle xhilme ', num2str(t)])

% create a new inlet
inletA = lsl_inlet(Start_COMM_bool{1}); % Pour collecter le booléen via LSL

% % create a new inlet
% inletB = lsl_inlet(Start_COMM_bool_perf{1}); % Pour collecter le booléen des perf via LSL
% disp('Début de la tâche ')

% Bool_comm = inletA.pull_chunk();
% disp(Bool_comm)
% Bool_comm = inletA.pull_sample();
% disp(Bool_comm)
Bool_comm = 1;
% Bool_perf = 0;
%---------------------------------------------------------------------------------------------------------

EVENT=MATB_DATA.EVENT{MATB_DATA.ScenarioNumber};

Start = GetSecs;
fprintf(fileID,'%s\t\t %.4f \t\t\t %s \n',char(datetime('now','Format','HH:mm:ss')),0,['STARTING SCENARIO' num2str(MATB_DATA.ScenarioNumber)]);
if MATB_DATA.LSL_Streaming
    outlet.push_sample({0,'STARTING',[' SCENARIO ' num2str(MATB_DATA.ScenarioNumber)]});
    outlet3.push_sample(20);% ------- valeur 20 pour ne pas que le stream soit vide au départ quand il va etre recu par le script COCPIT
end

if MATB_DATA.ScenarioType(MATB_DATA.ScenarioNumber,1)==0
    WL_PM='EASY';
else
    WL_PM='HARD';
end
fprintf(fileID,'%s\t\t %.4f \t\t\t %s \n',char(datetime('now','Format','HH:mm:ss')),0,[ ' Difficulty : ' WL_PM]);

MATB_DATA.LastUpdate.EVENT=Start;
MATB_DATA.LastUpdate.KB=Start;
% MATB_DATA.LastUpdate.JS=Start;
MATB_DATA.LastUpdate.LOG=Start;
MATB_DATA.COMM.DATA{MATB_DATA.ScenarioNumber}=[];
MATB_DATA.KeyboardAction{MATB_DATA.ScenarioNumber}=[];

deviceIndex=[];
KbQueueCreate(deviceIndex);
KbQueueStart(deviceIndex);

set(MATB_DATA.MainFigure,'position',MATB_DATA.MainFigurePosition)

Flag = 0; % Variable utilisée pour créer un stream continu des perf de comm


while true % Main GAME LOOP
    
    Flag = 0;
    
    t=GetSecs;
    set(MATB_DATA.MainFigure,'name',['Elapsed Time ' num2str(t-Start)])
    
        
%     disp(round(t-Start))
%     disp(['Bool_comm : ', num2str(Bool_comm),'    Bool_perf : ', num2str(Bool_perf)])
    disp(Bool_comm)
    % SET EVENTS
    
%     if Bool_comm ~= 0 && any(EVENT(:,1)==round(t-Start)) && t-MATB_DATA.LastUpdate.EVENT > 0.2 %------partie rajoutée pour contrôler la tâche de COMM depuis le script COCPIT------Initialement any(EVENT(:,1)==round(t-Start,1))&& t-MATB_DATA.LastUpdate.EVENT > 0.2 % Si jamais y'a un event et qu'il attend 200ms
    
    if find(Bool_comm == 1)

        if any(EVENT(:,1)==round(t-Start)) && t-MATB_DATA.LastUpdate.EVENT > 0.2 %------partie rajoutée pour contrôler la tâche de COMM depuis le script COCPIT------Initialement any(EVENT(:,1)==round(t-Start,1))&& t-MATB_DATA.LastUpdate.EVENT > 0.2 % Si jamais y'a un event et qu'il attend 200ms


            lE=EVENT(EVENT(:,1)==round(t-Start),2:19); % initialement 1E = EVENT(EVENT(:,1) == round(t-Start,1),2:19);
%             send_log('EVENT VEC',num2str(lE))
            send_log('EVENT VEC',num2str(lE),Bool_comm)
%             send_log('EVENT VEC',num2str(lE),Bool_comm,Bool_perf)
            [MATB_DATA]=MATB_ProcessEvent_Simu23_09(MATB_DATA,lE);
%             [MATB_DATA]=MATB_ProcessEvent_Simu23_09(MATB_DATA,lE,Bool_perf);
            % outlet.push_sample(MATB_DATA.COMM.DATA);
            Flag = 1;

        end
        
    elseif find(Bool_comm == 0)
            MATB_DATA.COMM.DATA{MATB_DATA.ScenarioNumber} = send_log('EVENT VEC',num2str(lE),Bool_comm);
%              send_log('EVENT VEC',num2str(lE),Bool_comm,Bool_perf);
    end
    
    
    
    % UPDATE TASK
    [MATB_DATA]=Update_KEYBOARD(MATB_DATA);
    if t-MATB_DATA.LastUpdate.LOG >= 0.5
        MATB_DATA.LastUpdate.LOG=GetSecs;
    end
    
    if t-Start > MATB_DATA.ScenarioDuration(MATB_DATA.ScenarioNumber)
        fprintf(fileID,'%s\t\t %.4f \t\t\t %s \n',char(datetime('now','Format','HH:mm:ss')),t-Start,['STOPING SCENARIO ' num2str(MATB_DATA.ScenarioNumber)]);
        
        if MATB_DATA.LSL_Streaming
            outlet.push_sample({0,'STOPING',[' SCENARIO ' num2str(MATB_DATA.ScenarioNumber)]});
            outlet3.push_sample(30);% valeur pour indiquer la fin du stream
        end
        PsychPortAudio('Stop', MATB_DATA.handlePortAudio);
        
        %         [MATB_DATA]=ReInit_MATB(MATB_DATA);
                break
    end
    
%     pause(1)
    %     pause(0.0001)
    drawnow
    
    %------------partie utilisée pour créer un stream continue sur LSL---------
    if Flag == 0
%         outlet3.push_chunk(100);
        outlet3.push_sample(100);

        
    end
    %--------------------------------------------------------------------------
    
    Bool_comm = inletA.pull_chunk(); %----------- permet de récupérer un nouveau booléen
%     Bool_comm = inletA.pull_sample(); %----------- permet de récupérer un nouveau booléen
%     Bool_perf = inletB.pull_chunk();


% tic
% while true
%     if ~isempty(inletA.pull_chunk())
%         break
%     end
% end
% t_fin=toc;
% 
% disp(t_fin);

    pause(1)
    
    % idée: enlever le pause et faire un xhile qui attend qu'un booléen
    % soit envoyé par cocpit. du coup tester si la taille du vecteur LSL
    % augmente . S
    %idee, faire un while size vecteur LSL == size vecteur LSL: tester si
    %la taille du vecteur LSL augmente. et si c'est le cas, on récupère un
    %nouveau booléen. ce qui permet que le script MATB attende le script
    %COCPIT
    

%     
% if Bool_comm == 1
%     disp('GO ON')
% elseif Bool_comm == 0
%     disp('STOOOOP')    
% elseif Bool_comm == 2
%     disp('TEST')   
% end
    % end
end

   
KbQueueStop