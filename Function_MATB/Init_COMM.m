function Init_COMM
global MATB_DATA

[bs,r,ButtonGroup,ValueGroup]=Button_COMM();
MATB_DATA.COMM.HandleButtonGroup    = bs; 
MATB_DATA.COMM.HandleRadioButton    = r;
MATB_DATA.COMM.HandlePlusMinus      = ButtonGroup;
MATB_DATA.COMM.HandleTextValue      = ValueGroup;

ColorBar=[0 0.4470 0.7410];
set(r,'value',0);
r(1).Value = 1;
title('COMMUNICATIONS','fontsize',21,'color',ColorBar)
% text(0,1,'CALL SIGN : NASA-504','fontsize',18,'color',ColorBar)
axis off

try
    Fic={};
    a=dir('Audio/OTHER_N*.wav'); Fic=cat(1,Fic,{a.name}');
    a=dir('Audio/OTHER_C*.wav'); Fic=cat(1,Fic,{a.name}');
    a=dir('Audio/OWN_N*.wav'); Fic=cat(1,Fic,{a.name}');
    a=dir('Audio/OWN_C*.wav'); Fic=cat(1,Fic,{a.name}');
    
    MATB_DATA.COMM.NomFichierAudio=Fic;
    
    for i=1:80 % Load all the audio directly into memory
        %     a=cat(2,a,'.'); disp(a)
        [y,Fs] = audioread(['Audio/' MATB_DATA.COMM.NomFichierAudio{i}]);
        MATB_DATA.COMM.ListFichierAudio{i}=resample(y,44100,Fs);
    end
    MATB_DATA.COMM.IdxCOMM=cat(2,[-ones(20,1) ; ones(20,1) ; -ones(20,1) ; ones(20,1)],[ones(10,1)*1 ; ones(10,1)*2 ; ones(10,1)*1 ; ones(10,1)*2 ; ones(10,1)*3 ; ones(10,1)*4 ; ones(10,1)*3 ; ones(10,1)*4]);
catch
    warning('Audio File could not be reach or loaded, Comm task deactivated')
    MATB_DATA.Param.CommActive = 0;
end