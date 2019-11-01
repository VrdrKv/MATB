% ------------------------------INFOS--------------------------------------
% MATB - Multi Attribute Task Battery (Replica from the NASA version - https://matb.larc.nasa.gov/)

% Author: Kevin Verdiere, ISAE-SUPAERO, 2018,
% kevin.verdiere@isae-supaero.fr

% You'll absolutely need :
% --> Simulink 3D Animation toolbox : for the Joystick interaction
% --> Psychtoolbox : for Time, Keyboard and Sound management 
% You migh need :
% --> labstreaminglayer toolbox : to stream all those data :)

close all; clc; clear; fclose('all');
addpath('Function_MATB')
rng('shuffle')

global MATB_DATA % Almost every important game mechanics data is stocked in MATB_DATA
MATB_DATA=[]; MATB_DATA.ScenarioNumber=1;

Config
%-------- Initializing ----------------------------------------------------
Init_LOG;
Init_LSL;
Init_MATB;
Init_EYE_TRACK;
%--------------------------------------------------------------------------

%-------- EVENT -----------------------------------------------------------
% gen_EVENT % Automatically generate events
EventManuel % Program MATB events manually
%--------------------------------------------------------------------------

ListenChar(-1) % Stop taking keyboard input into matlab console

% pop_waiter(["Bonjour,",... 
%     "Bienvenue dans cette expérimentation MATB!", ...
%     "(Appuyez sur 'ENTREE' pour commencer)"],1); 

%-------- TUTORIAL  -------------------------------------------------------
if MATB_DATA.Param.Tutorial
pop_waiter(["Afin de vous familiariser avec la tâche, merci de réaliser ce petit tutoriel", ... 
     "(Appuyez sur 'ENTREE' pour continuer)"],1);
Tutorial
pop_waiter('Ce tutorial est desormais termine. Appuyez sur "Entrée" pour continuer',1)
end
%--------------------------------------------------------------------------

%-------- TRAINING---------------------------------------------------------
if MATB_DATA.Param.Training
pop_waiter(["Veuillez à present vous entrainer sur la tâche", ...
    "(Appuyez sur 'ENTREE' pour continuer)"],1);
Training
pop_waiter(["Les sessions d'entrainement sont desormais terminées", ...
    "(Appuyez sur 'ENTREE' pour continuer)"],1);
end
%--------------------------------------------------------------------------

%% ------------------------ MAIN TASK--------------------------------------

% pop_waiter(["Passons maintenant à la vraie tâche laquelle durera 5mn", ...
%     "(Appuyez sur 'ENTREE' pour commencer)"],1);

% MATB_DATA.ScenarioType % Diplaying just to be sure :)
% [pop]=guide(MATB_DATA.ScenarioType(MATB_DATA.ScenarioNumber,1),MATB_DATA.ScenarioNumber);
% pop_waiter('The Cooperation instructions are on the left. Dont forget to look at it. Hit ENTER when you are READY to START the Calibration',1);

for i=1:size(MATB_DATA.ScenarioType,1)
    MATB_Main(); 
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

% pop_waiter(["Enregistrement des données",...
%     "(Appuyez sur la touche 'ENTREE' pour continuer)"],1);
% SauvegardeDATA
% pop_waiter(["Veuillez à présent compléter un dernier questionnaire",...
%     "(Appuyez sur la touche 'ENTREE' pour continuer)"],1);
% slidervalues
% pop_waiter(["Thank you so much!",1);
% pop_waiter(["Que Dieu vous garde!"],1);

DeleteHandle
ListenChar(0); 


close all
diary off