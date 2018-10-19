% Training - Entrainement
function Training
global MATB_DATA
pop_waiter('We are going to start with 2 Training session of 2mn30',1);
[pop]=guide(MATB_DATA.ScenarioType(MATB_DATA.ScenarioNumber,1),MATB_DATA.ScenarioNumber);
pop_waiter('Look on the LEFT Window EVERY SCENARIO for COOP or NOT',1);
pop_waiter('For the moment we are just training so that s ok',1);

[y,Fs] = audioread('Audio/OWN_TESTFILE.wav');
y2=resample(y,44100,Fs);
PsychPortAudio('FillBuffer', MATB_DATA.handlePortAudio, [y2' ; y2']);
PsychPortAudio('Start', MATB_DATA.handlePortAudio,1,0,1);

pop2=dialog('position',[500   150   850   250]);
txt = uicontrol('Parent',pop2,...
           'Style','text',...
           'Position', [1 -100 850 250],...
           'String','NASA 504 NASA 504 turn your COM1 radio to frequency 118.025',...
           'Fontsize',18);
pop_waiter('This is the kind of message you will hear for the COMM task',5);
close(pop2)
pop_waiter('Hit enter to START first training session',1); MATB_Main ; Performance
MATB_DATA.ScenarioNumber=MATB_DATA.ScenarioNumber+1;
pop_waiter('Second training session, its going to be harder',1); MATB_Main; Performance
MATB_DATA.ScenarioNumber=MATB_DATA.ScenarioNumber+1; 

pop_waiter('Now you change role',1); 
pop_waiter('Hit enter to START first training session',1); MATB_Main ; Performance
MATB_DATA.ScenarioNumber=MATB_DATA.ScenarioNumber+1;
pop_waiter('Second training session, its going to be harder',1); MATB_Main; Performance
MATB_DATA.ScenarioNumber=MATB_DATA.ScenarioNumber+1; 


pop_waiter('End of the training session',1);
close(pop)