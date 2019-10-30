global MATB_DATA outlet

deviceIndex=[];
KbQueueCreate(deviceIndex);
KbQueueStart(deviceIndex);
Start = GetSecs;
yesKeys = KbName('Return');

MATB_DATA.LastUpdate.RESMAN=Start;
MATB_DATA.LastUpdate.SYSMON=Start;
MATB_DATA.LastUpdate.TRACK=Start;
MATB_DATA.LastUpdate.EVENT=Start;
MATB_DATA.LastUpdate.KB=Start;
MATB_DATA.LastUpdate.LOG=Start;
MATB_DATA.LastUpdate.JS=Start;

MATB_DATA.TRACK.DATA{MATB_DATA.ScenarioNumber}=[];
MATB_DATA.RESMAN.DATA{MATB_DATA.ScenarioNumber}=[];
MATB_DATA.COMM.DATA{MATB_DATA.ScenarioNumber}=[];
MATB_DATA.SYSMON.DATA{MATB_DATA.ScenarioNumber}=[];
MATB_DATA.KeyboardAction{MATB_DATA.ScenarioNumber}=[];

%-------------------------------------------------------
%                   SYSMON
%-------------------------------------------------------

fprintf(MATB_DATA.LogFileID,'%s\t\t %.4f \t\t\t %s \n',char(datetime('now','Format','HH:mm:ss')),0,'TRAINING SYSMON');

if MATB_DATA.LSL_Streaming
    MATB_DATA.LSLoutlet.push_sample({0,'TRAINING SYSMON',''});
end

pop_waiter('Commençons par la tache de MONITORING',1)
pop=dialog('position',[1035  519  605 200],'CloseRequestFcn',@CloseFigEmpty);
txt = uicontrol('Parent',pop,...
    'Style','text',...
    'Position', [10 -100 585 250],...
    'String','Ici tout est normal, les jauges oscillent autour du milieu',...
    'Fontsize',18);

a=[ones(10,1) ; -ones(10,1)];
Ev=[randi(35,20,1)+15 randi(6,20,1) a(randperm(20))];

Start=GetSecs;
MATB_DATA.ScenarioStartedAt=Start;
while true
    t=GetSecs;
    
    % SET EVENTS
    if round(t-Start,1)==10 &&  t-MATB_DATA.LastUpdate.EVENT > 0.2 % Si jamais y'a un event et qu'il attend 200ms
        delete(pop)
        fClav=figure('menubar','non','numbertitle','off','position',[900 97 1000 420],'CloseRequestFcn',@CloseFigEmpty);
        imagesc(imread('Function_MATB\clavier.png'))
        set(gca,'position',[ 0 0  1 1]); axis off
        
        pop=dialog('position',[900  519  1000 300],'CloseRequestFcn',@CloseFigEmpty); %[1035  519  605 200])
        txt = uicontrol('Parent',pop,...
            'Style','text',...
            'Position', [50 -100 900 300],... %[-100 -100 850 250]
            'String','Essayez maintenant de répondre aux alarmes. Lorsque le niveau d`une jauge s`eloigne du milieu, appuyez sur le numéro correspondant à la jauge (bouton 1 à 4, première ligne du clavier). Lorsque F5 cesse d`etre vert, appuyez sur F5. Enfin, lorsque F6 devient rouge, appuyez sur la touche F6. ',...
            'Fontsize',18);
        
        MATB_DATA.LastUpdate.EVENT=GetSecs;
    end
    
    if any(Ev(:,1)==round(t-Start,1)) &&  t-MATB_DATA.LastUpdate.EVENT > 0.2 % Si jamais y'a un event et qu'il attend 200ms
        N_Ev=find(Ev(:,1)==round(t-Start,1));
        
        MATB_DATA.SYSMON.EtatAlarm(Ev(N_Ev,2),1)=1;
        MATB_DATA.SYSMON.EtatAlarm(Ev(N_Ev,2),2)=Ev(N_Ev,3);
        MATB_DATA.SYSMON.EtatAlarm(Ev(N_Ev,2),3)=GetSecs;
        MATB_DATA.LastUpdate.EVENT=GetSecs;
    end
    
    % UPDATE ALL TASKS
    if t-MATB_DATA.LastUpdate.KB >= 0.0
        Update_KEYBOARD()
    end
    
    if t-MATB_DATA.LastUpdate.SYSMON >= 0.2
        Update_SYSMON()
    end
    
    if t-Start > 60
        delete(pop); delete(fClav);
        break
    end
    drawnow
end


%-------------------------------------------------------
%                   TRACK
%-------------------------------------------------------

fprintf(MATB_DATA.LogFileID,'%s\t\t %.4f \t\t\t %s \n',char(datetime('now','Format','HH:mm:ss')),0,'TRAINING TRACK');
if MATB_DATA.LSL_Streaming
    MATB_DATA.LSLoutlet.push_sample({0,'TRAINING TRACK',''});
end

pop_waiter('Passons maintenant à la tache de TRACKING',1)
pop=dialog('position',[240 623 560 259]);
txt = uicontrol('Parent',pop,...
    'Style','text',...
    'Position', [-150 -100 850 250],... %[-100 -100 850 250]
    'String','Maintenez le cercle dans le carré central',...
    'Fontsize',18);
MATB_DATA.TRACK.Difficulty{1}=0;
Start=GetSecs;
MATB_DATA.ScenarioStartedAt=Start;
while true
    t=GetSecs;
    
    % SET EVENTS
    if round(t-Start,1)==20 &&  t-MATB_DATA.LastUpdate.EVENT > 0.2 % Si jamais y'a un event et qu'il attend 200ms
        close(pop)
        pop=dialog('position',[240 623 560 259]);
        txt = uicontrol('Parent',pop,...
            'Style','text',...
            'Position', [-150 -100 850 250],...
            'String','Cela peut aussi devenir plus dur',...
            'Fontsize',18);
        MATB_DATA.LastUpdate.EVENT=GetSecs;
    end
    if round(t-Start,1)==25 &&  t-MATB_DATA.LastUpdate.EVENT > 0.2 % Si jamais y'a un event et qu'il attend 200ms
        MATB_DATA.TRACK.Difficulty{1}=1;
        MATB_DATA.LastUpdate.EVENT=GetSecs;
    end
    
    % UPDATE ALL TASKS
    if t-MATB_DATA.LastUpdate.KB >= 0.0
        Update_KEYBOARD()
    end
    
    if t-MATB_DATA.LastUpdate.TRACK >= 0.02
        Update_TRACK()
    end
    
    if t-Start > 60
        delete(pop)
        break
    end
    drawnow
end
% %pop_waiter('Don`t forget when the CIRCLE is RED, all pumps are OFF !',1,[240 623 560 259],[0 -100 560 250])


%-------------------------------------------------------
%                  RESMAN
%-------------------------------------------------------

fprintf(MATB_DATA.LogFileID,'%s\t\t %.4f \t\t\t %s \n',char(datetime('now','Format','HH:mm:ss')),0,'TRAINING RESMAN');

if MATB_DATA.LSL_Streaming %%%%%%%%%ajouté par Alex car impossible de lancer la tache sans cela
    MATB_DATA.LSLoutlet.push_sample({0,'TRAINING RESMAN',''});
end%%%%%%%%%%%%%%%%%%%

pop_waiter('Passons maintenant à la tache de FUEL MANAGEMENT',1)

pop_nowait('L`objectif ici est de garder le niveau des réservoirs A et B autour de 2500 le plus longtemps possible',yesKeys)
pop_nowait('2500 est symbolisé par une petite ligne bleue tandis que les zones bleues latérales délimitent des niveaux (entre 2000 et 3000) au delà desquels une zone critique est atteinte',yesKeys)
pop_nowait('Il est important de maintenir le niveau des reservoirs A et B entre 2000 et 3000. Dans le cas contraire, les chiffres indiquant le niveau deviendront orange',yesKeys)
pop_nowait('Notez bien que lorsqu`une pompe est grise, celle-ci est désactivée. Vert signifie qu`elle est activée et rouge défectueuse.',yesKeys)
pop_nowait('Quand une pompe est défectueuse, vous ne pourrez pas la réparer, vous devrez simplement attendre que celle-ci redevienne fonctionnelle',yesKeys)
fClav2=figure('menubar','non','numbertitle','off','position',[30 87 746 316],'CloseRequestFcn',@CloseFigEmpty);
imagesc(imread('Function_MATB\clavier2.png'))
set(gca,'position',[ 0 0  1 1]); axis off
pop_nowait('Pour activer une pompe, pressez le nombre correspondant à la pompe sur la deuxième ligne du clavier, la pompe en question deviendra alors verte',yesKeys)
delete(fClav2);
pop_nowait('Au début, toutes les pompes seront desactivées (grises) et les réservoirs A et B seront vides, donc n`oubliez pas d`activer les pompes !',yesKeys)
pop_nowait('Parfait, faisons maintenant un petit essai. Restez proche de 2500, pas plus, pas moins, 2500 !',yesKeys)

Start=GetSecs;
MATB_DATA.ScenarioStartedAt=Start;
while true
    t=GetSecs;
    
    % SET EVENTS
    if round(t-Start,1)==20 &&  t-MATB_DATA.LastUpdate.EVENT > 0.2 % Si jamais y'a un event et qu'il attend 200ms
        pop1=dialog('position',[  30   403   746   276],'CloseRequestFcn',@CloseFigEmpty);
        txt = uicontrol('Parent',pop1,...
            'Style','text',...
            'Position', [-50 -100 850 250],...
            'String','Les pompes 1, 2, 3 et 4 sont les plus importantes',...
            'Fontsize',18);
        MATB_DATA.LastUpdate.EVENT=GetSecs;
    end
    if round(t-Start,1)==25 &&  t-MATB_DATA.LastUpdate.EVENT > 0.2 % Si jamais y'a un event et qu'il attend 200ms
        pop=dialog('position',[26    56   745   254],'CloseRequestFcn',@CloseFigEmpty);
        txt = uicontrol('Parent',pop,...
            'Style','text',...
            'Position', [100 -100 600 250],...
            'String','Les pompes 5 et 6 doivent être activées tout le temps pour maintenir les réservoirs auxiliaires (C et D) pleins. Les réservoirs E et F sont illimités',...
            'Fontsize',18);
        MATB_DATA.LastUpdate.EVENT=GetSecs;
    end
    
    if round(t-Start,1)==40 &&  t-MATB_DATA.LastUpdate.EVENT > 0.2 % Si jamais y'a un event et qu'il attend 200ms
        delete(pop); delete(pop1)
        set(MATB_DATA.RESMAN.handlePompe([1 2]),'backgroundcolor',[1 0 0])
        pop1=dialog('position',[30  403  746  276],'CloseRequestFcn',@CloseFigEmpty);
        txt = uicontrol('Parent',pop1,...
            'Style','text',...
            'Position', [100 -100 600 250],...
            'String','A présent les pompes 1 et 2 sont défectueuses, elles ne marchent plus. Vous pouvez simplement attendre qu`elles redeviennent fonctionnelles',...
            'Fontsize',18);
        MATB_DATA.LastUpdate.EVENT=GetSecs;
    end
    if round(t-Start,1)==45 &&  t-MATB_DATA.LastUpdate.EVENT > 0.2 % Si jamais y'a un event et qu'il attend 200ms
        pop=dialog('position',[26    56   745   254],'CloseRequestFcn',@CloseFigEmpty);
        txt = uicontrol('Parent',pop,...
            'Style','text',...
            'Position', [100 -100 600 250],...
            'String','En attendant le retour des pompes 1 et 2, vous pouvez activer la pompe 8 pour maintenir un niveau stable dans le réservoir A',...
            'Fontsize',18);
        MATB_DATA.LastUpdate.EVENT=GetSecs;
    end
    
    % UPDATE ALL TASKS
    if t-MATB_DATA.LastUpdate.KB >= 0.0
        Update_KEYBOARD;
    end
    
    if t-MATB_DATA.LastUpdate.RESMAN >= 1
        Update_RESMAN;
    end
    
    if t-MATB_DATA.LastUpdate.LOG >= 0.5
        send_log('RESMAN',num2str(MATB_DATA.RESMAN.NiveauxPompe));
        MATB_DATA.LastUpdate.LOG=GetSecs;
    end
    
    if t-Start > 60
        delete(pop); delete(pop1);
        break
    end
    drawnow
end

% -------------------------------------------------------
%                   COMM
% -------------------------------------------------------
if MATB_DATA.Param.CommActive
    fprintf(MATB_DATA.LogFileID,'%s\t\t %.4f \t\t\t %s \n',char(datetime('now','Format','HH:mm:ss')),0,'TRAINING COMM');
    if MATB_DATA.LSL_Streaming
        MATB_DATA.LSLoutlet.push_sample({0,'TRAINING COMM',''});
    end
    pop_waiter('Enfin, voyons comment réaliser la tâche de COMMUNICATION',1)
    pop=dialog('position',[937   177   560   299],'CloseRequestFcn',@CloseFigEmpty);
    txt = uicontrol('Parent',pop,...
        'Style','text',...
        'Position', [-150 -100 850 250],...
        'String','Ecoutez...',...
        'Fontsize',18);
    drawnow;
    
Start=GetSecs;
MATB_DATA.ScenarioStartedAt=Start;
    while true
        t=GetSecs;
        
        % SET EVENTS
        if round(t-Start,1)==1 &&  t-MATB_DATA.LastUpdate.EVENT > 0.2
            TypeOwnOth=1; TypeCOMM=1;
            IdFichier=find(MATB_DATA.COMM.IdxCOMM(:,1)==TypeOwnOth & MATB_DATA.COMM.IdxCOMM(:,2)==TypeCOMM);
            PsychPortAudio('FillBuffer', MATB_DATA.handlePortAudio,...
                [MATB_DATA.COMM.ListFichierAudio{IdFichier(1)}' ; MATB_DATA.COMM.ListFichierAudio{IdFichier(1)}']);
            PsychPortAudio('Start', MATB_DATA.handlePortAudio,1,0,1);
            
            MATB_DATA.LastUpdate.EVENT=GetSecs;
        end
        if round(t-Start,1)==3 &&  t-MATB_DATA.LastUpdate.EVENT > 0.2
            f1=figure('position',[10 487 414 121],'menubar','none','numbertitle','off','CloseRequestFcn',@CloseFigEmpty);
            text(-0.1,1,'NASA 504: Cela vous concerne','fontsize',18);
            set(gca,'xlim',[0 2],'ylim',[0 2]); axis off
            MATB_DATA.LastUpdate.EVENT=GetSecs;
        end
        if round(t-Start,1)==12 &&  t-MATB_DATA.LastUpdate.EVENT > 0.2
            delete(pop)
            f2=figure('position',[10 346 414 94],'menubar','none','numbertitle','off','CloseRequestFcn',@CloseFigEmpty);
            text(-0.1,1.3,'Selectionnez NAV1 grâce à la gachette','fontsize',14);
            text(0.7,0.6,'du joystick','fontsize',14);
            set(gca,'xlim',[0 2],'ylim',[0 2]); axis off
            
            fjoy1=figure('menubar','non','numbertitle','off','position',[821 780 391 272],'CloseRequestFcn',@CloseFigEmpty);
            imagesc(imread('Function_MATB\gachette1.png'))
            set(gca,'position',[ 0 0  1 1]); axis off
            
            pause(1);
            
            f3=figure('position',[10 220 414 94],'menubar','none','numbertitle','off','CloseRequestFcn',@CloseFigEmpty);
            text(-0.15,1.5,'Changez ensuite les valeurs pour atteindre','fontsize',14);
            text(-0.13,0.8,'110 et 650 grâce aux boutons sur le haut','fontsize',14);
            text(0.7,0.1,'du joystick','fontsize',14);
            set(gca,'xlim',[0 2],'ylim',[0 2]); axis off
            
            fjoy2=figure('menubar','non','numbertitle','off','position',[821 404 286 346],'CloseRequestFcn',@CloseFigEmpty);
            imagesc(imread('Function_MATB\gachette2.png'))
            set(gca,'position',[ 0 0  1 1]); axis off
            
            pause(1);
            
            f4=figure('position',[10 94 414 94],'menubar','none','numbertitle','off','CloseRequestFcn',@CloseFigEmpty);
            text(-0.15,1.3,'Enfin, validez le tout avec le bouton latéral','fontsize',14);
            set(gca,'xlim',[0 2],'ylim',[0 2]); axis off
            
            fjoy3=figure('menubar','non','numbertitle','off','position',[821 76 211 297],'CloseRequestFcn',@CloseFigEmpty);
            imagesc(imread('Function_MATB\gachette3.png'))
            set(gca,'position',[ 0 0  1 1]); axis off
            
            MATB_DATA.LastUpdate.EVENT=GetSecs;
        end
        
        if round(t-Start,1)==40 &&  t-MATB_DATA.LastUpdate.EVENT > 0.2
            delete([f1, f2, f3, f4, fjoy1, fjoy2, fjoy3]);
            TypeOwnOth=-1; TypeCOMM=3;
            IdFichier=find(MATB_DATA.COMM.IdxCOMM(:,1)==TypeOwnOth & MATB_DATA.COMM.IdxCOMM(:,2)==TypeCOMM);
            PsychPortAudio('FillBuffer', MATB_DATA.handlePortAudio,...
                [MATB_DATA.COMM.ListFichierAudio{IdFichier(1)}' ; MATB_DATA.COMM.ListFichierAudio{IdFichier(1)}']);
            PsychPortAudio('Start', MATB_DATA.handlePortAudio,1,0,1);
            
            MATB_DATA.LastUpdate.EVENT=GetSecs;
        end
        if round(t-Start,1)==42 &&  t-MATB_DATA.LastUpdate.EVENT > 0.2
            f4=figure('position',[10 487 414 121],'menubar','none','numbertitle','off','CloseRequestFcn',@CloseFigEmpty);
            text(0.05,1.2,'CITRUS 211: Ce message','fontsize',18);
            text(0.2,0.6,'ne vous concerne pas','fontsize',18);
            set(gca,'xlim',[0 2],'ylim',[0 2]); axis off
            
            MATB_DATA.LastUpdate.EVENT=GetSecs;
        end
        if round(t-Start,1)==44 &&  t-MATB_DATA.LastUpdate.EVENT > 0.2
            f5=figure('position',[10 300 414 140],'menubar','none','numbertitle','off','CloseRequestFcn',@CloseFigEmpty); %[10 330 414 121]
            text(0.2,1.2,'Donc, vous n`avez pas','fontsize',18);
            text(0.35,0.6,'à en tenir compte','fontsize',18);
            set(gca,'xlim',[0 2],'ylim',[0 2]); axis off
            MATB_DATA.LastUpdate.EVENT=GetSecs;
        end
        
        if sum(button(MATB_DATA.TRACK.JoystickID)) && GetSecs-MATB_DATA.LastUpdate.JS>=0.25
            Update_JOYSTICKBUT()
        end
        
        if t-Start > 60
            delete([f4 f5])
            break
        end
        drawnow
    end
end
%--------------------------------------------------------------------------

[MATB_DATA]=ReInit_MATB(MATB_DATA);
PsychPortAudio('Stop', MATB_DATA.handlePortAudio);
KbQueueStop

function pop_nowait(texte,yesKeys)
pop=dialog('position',[ 30   403   746   276],'CloseRequestFcn',@CloseFigEmpty);
txt = uicontrol('Parent',pop,...
    'Style','text',...
    'Position', [80 -50 600 250],... %[100 -100 600 250]
    'String',texte,...
    'Fontsize',18);
drawnow; pause(0.5)
while true
    [~,~,keyCode] = KbCheck;
    if any(keyCode(yesKeys))
        break
    end
end
delete(pop)
end