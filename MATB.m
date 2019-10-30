% ------------------------------INFOS--------------------------------------
% MATB - Multi Attribute Task Battery (Replica from the NASA version - https://matb.larc.nasa.gov/)

% Author: Kevin Verdiere, ISAE-SUPAERO, 2018,
% kevin.verdiere@isae-supaero.fr

% You'll absolutely need :
% --> Simulink 3D Animation toolbox : for the Joystick interaction
% --> Psychtoolbox : for Time, Keyboard and Sound management 
% You migh need :
% --> labstreaminglayer toolbox : to stream all those data :)
% Test
%% -----------------------TUTORIAL & TRAINING------------------------------

close all; clc; clear; fclose('all');
addpath('Function_MATB')
rng('shuffle')

global MATB_DATA % Almost every important game mechanics data is stocked in MATB_DATA
% SALE : MATB_DATA est parfois global parfois passer en argument
MATB_DATA=[]; MATB_DATA.ScenarioNumber=1;

MATB_DATA.GazepointEyeTracker = 0;  % if 1, Double Gazepoint Active
MATB_DATA.LSL_Streaming = 1;        % if 1, Data Streamed via LSL
MATB_DATA.Param.PumpCloseTrack = 0; % if 1, When track is out of big square all pump off
MATB_DATA.Param.TrackIfLevel = 0;   % if 1, when level are above 3000 or below 2000 TRACK is harder
MATB_DATA.Param.CommActive = 1;     % if 1, COMM Task is active
%-------- Initializing ----------------------------------------------------
Init_LOG;
Init_LSL;
Init_MATB;
Init_EYE_TRACK;
%--------------------------------------------------------------------------

%-------- Scenario Type ---------------------------------------------------
% Exemple : 2 scenario 10sec each
MATB_DATA.ScenarioType=[ %Workload 0/1  avec 0 pour low workload, 1 pour high workload
    0 
    0
    30];

% Randomisation=[ 5  1  2  6  8  7  4  3 ];
% MATB_DATA.ScenarioType=[ % Interation 0/1  WL_PF 0/1 WL_PM 0/1
%     0     0     0
%     0     0     1
%     0     1     0
%     0     1     1
%     1     0     0
%     1     0     1
%     1     1     0
%     1     1     1];
% MATB_DATA.ScenarioType=MATB_DATA.ScenarioType( Randomisation ,:);
% % Add The training
% MATB_DATA.ScenarioType=cat(1,...
%     [   0   0   0
%     0   1   1
%     0   0   0
%     0   1   1] ,MATB_DATA.ScenarioType);
%------------------------------------------------------------ --------------

%-------- Scenario Duration (sec) -----------------------------------------
MATB_DATA.ScenarioDuration=[30 10 10];
% MATB_DATA.ScenarioDuration=cat(2,ones(1,4)*5,ones(1,8)*5);
% MATB_DATA.ScenarioDuration=cat(2,ones(1,4)*150,ones(1,8)*300);
% MATB_DATA.ScenarioDuration=cat(2,ones(1,4)*10,ones(1,8)*300);
% MATB_DATA.ScenarioDuration=cat(2,ones(1,4)*10,ones(1,8)*300);
% MATB_DATA.ScenarioDuration=ones(1,8)*300;
%--------------------------------------------------------------------------

%-------- EVENT -----------------------------------------------------------
% gen_EVENT % Automatically generate events
EventManuel % Program MATB events manually
%--------------------------------------------------------------------------

ListenChar(-1) % Stop taking keyboard input into matlab console

% str1 = compose(str1);
pop_waiter(["Bonjour,",... 
    "Bienvenue dans cette expérimentation MATB!", ...
    "(Appuyez sur 'ENTREE' pour commencer)"],1); 

%-------- TUTORIAL  -------------------------------------------------------
pop_waiter(["Afin de vous familiariser avec la tâche, merci de réaliser ce petit tutoriel", ... 
     "(Appuyez sur 'ENTREE' pour continuer)"],1);
Tutorial
pop_waiter('Ce tutorial est desormais termine. Appuyez sur "Entrée" pour continuer',1)
%--------------------------------------------------------------------------

%-------- TRAINING---------------------------------------------------------
pop_waiter(["Veuillez à present vous entrainer sur la tâche", ...
    "(Appuyez sur 'ENTREE' pour continuer)"],1);
Training
pop_waiter(["Les sessions d'entrainement sont desormais terminées", ...
    "(Appuyez sur 'ENTREE' pour continuer)"],1);
%--------------------------------------------------------------------------


% f=figure('CloseRequestFcn',@closehide);
% 
% %   set(f,'CloseRequestFcn',); 
% 
% function closehide(src,callbackdata)
% set(src,'Visible','off');
% end
%% ------------------------ MAIN TASK--------------------------------------

pop_waiter(["Passons maintenant à la vraie tâche laquelle durera 5mn", ...
    "(Appuyez sur 'ENTREE' pour commencer)"],1);

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
pop_waiter(["Enregistrement des données",...
    "(Appuyez sur la touche 'ENTREE' pour continuer)"],1);
SauvegardeDATA
pop_waiter(["Veuillez à présent compléter un dernier questionnaire",...
    "(Appuyez sur la touche 'ENTREE' pour continuer)"],1);
% slidervalues
% pop_waiter(["Thank you so much!", ...
%    "Que Dieu vous garde!"],1);

ListenChar(0); fclose(MATB_DATA.LogFileID);
DeleteHandle

close all
diary off