% ------------------------------INFOS--------------------------------------
% Script tâche de COMMUNICATION de la MATB. Script permettant de faire
% uniquement tourner la tâche de communication de la MATB et de calculer
% les performances en temps réel sur cette tâche. Envoie un stream LSL
% 'COMM' pour utiliser les perf de comm sur d'autres scripts


% Script initialement crée par Kevin Verdière. Modifié par Alex Lafont
% You'll absolutely need :
% --> Simulink 3D Animation toolbox : for the Joystick interaction
% --> Psychtoolbox : for Time, Keyboard and Sound management 
% You migh need :
% --> labstreaminglayer toolbox : to stream all those data :)


%% INTIALISATION

close all; clc; clear; fclose('all');
addpath('Function_MATB')
rng('shuffle')

global fileID MATB_DATA % Almost every important game mechanics data is stocked in MATB_DATA. Attention : MATB_DATA est parfois global parfois passer en argument
MATB_DATA=[]; MATB_DATA.ScenarioNumber=1;
MATB_DATA.LSL_Streaming = 1; % if 1, Data Streamed via LSL

[MATB_DATA]=Init_LOG(MATB_DATA);
[MATB_DATA]=Init_LSL(MATB_DATA);
[MATB_DATA]=Init_MATB_Simu23_09(MATB_DATA); 

%-------- Difficulté des scenario (une valeur par scénario)----------------
MATB_DATA.ScenarioType=[0 0 0]; % Workload 0/1  avec 0 pour low workload, 1 pour high workload
%------------------------------------------------------------ -------------

%------------------------ Scenario Duration (sec) -------------------------
MATB_DATA.ScenarioDuration=[300 120 300];
%--------------------------------------------------------------------------

%---------------------- Evenements (Comms) --------------------------------
gen_EVENT % Automatically generate events
% EventManuel % Program MATB events manually
%--------------------------------------------------------------------------

ListenChar(-1) % Stop taking keyboard input into matlab console

% str1 = compose(str1);
% pop_waiter(["Bonjour,",... 
%     "Bienvenue dans cette expérimentation MATB!", ...
%     "(Appuyez sur 'ENTREE' pour commencer)"],1); 

%-------- TRAINING---------------------------------------------------------
% pop_waiter(["Veuillez à present vous entrainer sur la tâche", ...
%     "(Appuyez sur 'ENTREE' pour continuer)"],1);
Training
pop_waiter(["Les sessions d'entrainement sont desormais terminées", ...
    "(Appuyez sur 'ENTREE' pour continuer)"],1);
%--------------------------------------------------------------------------



%% TACHE PRINCIPALE

pop_waiter(["Passons maintenant à la vraie tâche laquelle durera 5mn", ...
    "(Appuyez sur 'ENTREE' pour commencer)"],1);

% MATB_DATA.ScenarioType % Diplaying just to be sure :)
% [pop]=guide(MATB_DATA.ScenarioType(MATB_DATA.ScenarioNumber,1),MATB_DATA.ScenarioNumber);
% pop_waiter('The Cooperation instructions are on the left. Dont forget to look at it. Hit ENTER when you are READY to START the Calibration',1);

for i=1:size(MATB_DATA.ScenarioType,1)
    MATB_Main_Simu23_09(); %MATB_Main(); 
    Performance();
    MATB_DATA.ScenarioNumber=MATB_DATA.ScenarioNumber+1;
    
    pause(2)
    pop_waiter(["FIN DE LA TACHE",... 
        "(Appuyez sur la touche 'ENTREE' pour continuer)"],1);
    
    if MATB_DATA.ScenarioNumber > size(MATB_DATA.ScenarioType,1)
        break
    end
%     close(pop)
%     
%     [pop]=guide(MATB_DATA.ScenarioType(MATB_DATA.ScenarioNumber,1),MATB_DATA.ScenarioNumber);
%     pop_waiter(['Look at the Instructions for Scenario ' num2str(MATB_DATA.ScenarioNumber-4) ' and hit Enter to START'],1);
end

% close(pop)
pop_waiter(["Enregistrement des données",...
    "(Appuyez sur la touche 'ENTREE' pour continuer)"],1);
SauvegardeDATA
pop_waiter(["Veuillez compléter le questionnaire NASA TLX fourni en version papier "],1);
pop_waiter(["Thank you so much!", ...
   "Que Dieu vous garde!"],1);

ListenChar(0); fclose(fileID);
DeleteHandle(MATB_DATA)

close all
diary off