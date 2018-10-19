% cd Documents/MATLAB/MATB_Kevin/
% cd D:\k.verdiere\Documents\MATB_HomeMade_New
%% IMPROVEMENT 
% Use only low level graphic operator :  line, patch, rectangle, surface, text, image, axes, and light
% NaN for multiple lines : (Contour etc...)
% x = [0:10,NaN,20:30,NaN,40:50];
% y = [0:10,NaN,0:10,NaN,0:10];
% line(x,y)

% Quand y'a un KB PMP et que la pompe est failed, il est quand meme
% comptabilisé --> à suprimer ?
%%
close all; clc; clear; fclose('all');
addpath('Function_MATB')
addpath(genpath('D:\k.verdiere\Documents\MATLAB\labstreaminglayer'))
rng('shuffle')

global fileID MATB_DATA

MATB_DATA=[]; MATB_DATA.ScenarioNumber=1;
[MATB_DATA]=Init_LOG(MATB_DATA);
[MATB_DATA]=Init_LSL(MATB_DATA);
[MATB_DATA]=Init_MATB(MATB_DATA);
% [MATB_DATA]=Init_EYE_TRACK(MATB_DATA);


% MATB_DATA.ScenarioType=[ % Interation 0/1  WL_PF 0/1 WL_PM 0/1
%     1     1     1
%     0     1     1];
% MATB_DATA.ScenarioDuration=[60];

MATB_DATA.ScenarioType=[ % Interation 0/1  WL_PF 0/1 WL_PM 0/1
    0     1     1
    0     0     1
    0     0     0
    1     0     0
    1     1     1
    1     0     1
    0     1     0
    1     1     0];
% MATB_DATA.ScenarioType=MATB_DATA.ScenarioType(randperm(size(MATB_DATA.ScenarioType,1)),:);
% % Add The training
MATB_DATA.ScenarioType=cat(1,...
    [   0   0   0
    0   1   1
    0   0   0
    0   1   1] ,MATB_DATA.ScenarioType);
% 
% MATB_DATA.ScenarioDuration=cat(2,ones(1,4)*150,ones(1,8)*300);
MATB_DATA.ScenarioDuration=cat(2,ones(1,4)*150,ones(1,8)*300);
% MATB_DATA.ScenarioDuration=ones(1,7)*300;

gen_EVENT
% EventManuel
pop_waiter('Hello, Welcome in the MATB world',1);

% TRAINING
ListenChar(-1)
pop_waiter('Let s try all tasks',1);

Training
pop_waiter('Goooood',1)
%% Ca part
MATB_DATA.ScenarioType
[pop]=guide(MATB_DATA.ScenarioType(MATB_DATA.ScenarioNumber,1),MATB_DATA.ScenarioNumber);
pop_waiter('Read The Instructions on the left and Hit ENTER when you are READY to START the Experiment',1);
for i=1:size(MATB_DATA.ScenarioType,1)
    
    MATB_Main
    Performance
    MATB_DATA.ScenarioNumber=MATB_DATA.ScenarioNumber+1;
    pop_waiter([' End of Scenario ' num2str(MATB_DATA.ScenarioNumber-1-4) ' Please Complete the corresponding NASA TLX '],1);
    
    if MATB_DATA.ScenarioNumber > size(MATB_DATA.ScenarioType,1)
        break
    end
    close(pop)
    
    [pop]=guide(MATB_DATA.ScenarioType(MATB_DATA.ScenarioNumber,1),MATB_DATA.ScenarioNumber);
    pop_waiter(['Look at the Instructions for Scenario ' num2str(MATB_DATA.ScenarioNumber-4) ' and hit Enter to START'],1);
end
close(pop)
SauvegardeDATA
pop_waiter('Thank you so much',1);
pop_waiter('Que Dieu vous Garde',1);

ListenChar(0)
fclose(fileID); PsychHID('KbQueueStop'), PsychPortAudio('close', MATB_DATA.handlePortAudio)
for i=1:2
fprintf(MATB_DATA.EyeTrack.client_socket{i},'<SET ID="ENABLE_SEND_DATA" STATE="0" />');
fclose(MATB_DATA.EyeTrack.client_socket{i});
delete(MATB_DATA.EyeTrack.client_socket{i});
end
close all
