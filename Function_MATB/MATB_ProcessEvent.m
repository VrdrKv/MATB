function MATB_ProcessEvent(lE)
global MATB_DATA
if any(lE(1:6)~=0) % Si jamais y'a du SYSMON
    Fnum=lE(1:6);
    MATB_DATA.SYSMON.EtatAlarm(Fnum~=0,1)=1;
    MATB_DATA.SYSMON.EtatAlarm(Fnum~=0,2)=Fnum(Fnum~=0);
    MATB_DATA.SYSMON.EtatAlarm(Fnum~=0,3)=hat;
end

if any(lE(7:14)~=0) % Si jamais y'a des POMPES a changer
    pmpNum=lE(7:14);
    MATB_DATA.RESMAN.EtatPompe(pmpNum==-1)=1;
    MATB_DATA.RESMAN.EtatPompe(pmpNum==1)=0;
    
    set(MATB_DATA.RESMAN.handlePompe(find(pmpNum==-1)),'backgroundcolor',[1 0 0])
    set(MATB_DATA.RESMAN.handlePompe(find(pmpNum==1)),'backgroundcolor',[.94 .94 .94])
end

if any(lE(15:18)~=0) && MATB_DATA.Param.CommActive % Si jamais y'a de la COMM a envoyer
    ttt=lE(15:18);
    TypeOwnOth=ttt(find(ttt));
    TypeCOMM=find(ttt);
    IdFichier=find(MATB_DATA.COMM.IdxCOMM(:,1)==TypeOwnOth & MATB_DATA.COMM.IdxCOMM(:,2)==TypeCOMM);
    
    % VERSIO LOADING RESAMPLING a la volée mamene : Trop long
    %     FichierAudio=MATB_DATA.COMM.ListFichierAudio{IdFichier(randi(8,1))};
    %     [y,Fs] = audioread(['Audio/' FichierAudio]);
    %     y2=resample(y,44100,Fs);
    %     PsychPortAudio('FillBuffer', MATB_DATA.handlePortAudio, [y2' ; y2']);
    %     PsychPortAudio('Start', MATB_DATA.handlePortAudio,1,0,1);
    
    NumRandFichier=randi(8,1);

    play(MATB_DATA.COMM.playerObj(IdFichier(NumRandFichier)))
%     PsychPortAudio('FillBuffer', MATB_DATA.handlePortAudio,...
%         [MATB_DATA.COMM.ListFichierAudio{IdFichier(NumRandFichier)}' ; MATB_DATA.COMM.ListFichierAudio{IdFichier(NumRandFichier)}']);
%     PsychPortAudio('Start', MATB_DATA.handlePortAudio,1,0,1);
    
    Fich=MATB_DATA.COMM.NomFichierAudio{IdFichier(NumRandFichier)};
    send_log('COMM PLAY',Fich);
    MATB_DATA.COMM.DATA{MATB_DATA.ScenarioNumber}=cat(1,MATB_DATA.COMM.DATA{MATB_DATA.ScenarioNumber},cat(2,TypeOwnOth,TypeCOMM,str2num(Fich(end-10:end-8)),str2num(Fich(end-6:end-4)),0));
end

MATB_DATA.LastUpdate.EVENT=hat;