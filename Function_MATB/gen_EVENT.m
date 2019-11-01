function gen_EVENT
global MATB_DATA
% % EVENT MATB
%
%  SON minimum 15 secondes entre les MESSAGES
%
%            -1: Bas  1: Haut      -1: Error         Pmp    -1:Error     1:PluError               1:Own -1:Others
% Seconds  F1    F2    F3    F4    F5    F6     1     2     3    4     5     6     7      8   NAV1  NAV2   COM1  COM2

%   10     0 0 0 0 0 1 
pop=dialog('position',[500   450   850   250]);
txt = uicontrol('Parent',pop,...
    'Style','text',...
    'Position', [100 -100 600 250],...
    'String','Generating Scenarios',...
    'Fontsize',18);
drawnow;

for N_Scenar=1:size(MATB_DATA.ScenarioType,1)
    EVENT{N_Scenar}=[];
    Tot_Ev = [12 4 2 4; 12 4 2 4; 24 10 5 5]; %Definition du nombre d evenements/pannes pour chaque scenario (lignes) et chaque tache (colones: SYSMON (!!! Multiple de 3!!!), COM-Ev, COM-Target, RESMAN) -- AL
    disp(['Initialisation des scénarios' num2str(N_Scenar) ' / ' num2str(size(MATB_DATA.ScenarioType,1))])
    t_Max = MATB_DATA.ScenarioDuration(N_Scenar);

    %--------------- EVENT SYSMON -------------------%
    N_Ev=Tot_Ev(N_Scenar,1); % Nombre d'alarmes (30 dans le script de Kevin)
    Ev=zeros(N_Ev,19);
        
%     t=round(linspace(5,280,N_Ev))+randi([-15 15],1,N_Ev); % De 5 à 280 lineairement espacé + un jitter de 15sec max
    t=round(linspace(10,(t_Max-(t_Max/15)),N_Ev))+randi([-10 5],1,N_Ev); % Modifie pour permettre des scenarii de differentes durees -- AL
    
    t(t>(t_Max-(t_Max/15)))=(t_Max-(t_Max/15)); t(t<5)=5; % si trop haut ou trop bas
    t=sort(t);
    % Repartition entre les bars et les alarmes lumineuses
    N_F1F4=N_Ev*2/3; N_F5F6=N_Ev*1/3;  % 2/3 d'alarme de type barres et 1/3 de boutons
    
    % Attribution aléatoire des alarmes aux barres ou aux boutons 
    pos=cat(1,randi([1 4],N_F1F4,1),randi([5 6],N_F5F6,1)); pos=pos(randperm(N_Ev));
    
    % Valeur +1 ou -1
    value=cat(2,ones(1,N_Ev/2),-ones(1,N_Ev/2)); value=value(randperm(length(value)));
    
    Ev(:,1)=t;
    for i=1:6
        if i<5
            Ev(pos==i,i+1)=value(pos==i);
        else
            Ev(pos==i,i+1)=-1;
        end
    end
    EVENT{N_Scenar}=cat(1,EVENT{N_Scenar},Ev);

    
        %--------------- EVENT TRACK -------------------%
    if MATB_DATA.ScenarioType(N_Scenar,1)==0  %  Facile
        MATB_DATA.TRACK.Difficulty{N_Scenar}=0;
    else %  Difficile
        MATB_DATA.TRACK.Difficulty{N_Scenar}=1;
    end
    
    
        %--------------- EVENT COMM -------------------%
    
    % COMM % Attention : Pas de comm à Zero
    N_Ev=Tot_Ev(N_Scenar,2); % Nombre d'evenement (16 dans le script de Kévin)
    Target=Tot_Ev(N_Scenar,3); % Nombre de targets (10 dans le script de Kévin)
    while true
        Ev=zeros(N_Ev,19);
%         t=round(linspace(10,270,N_Ev))+randi([-10 5],1,N_Ev);  % De 5 à 270 lineairement espacé + un jitter de -10 à 5 sec 
        t=round(linspace(10,(t_Max-20),N_Ev))+randi([-10 5],1,N_Ev); % Modifie pour permettre des scenarii de differentes durees -- AL
        
        TypeCOMM=randi([1 4],N_Ev,1); % NAV 1 2 ou COMM 1 2 (4 possibilite)
        TypeCOMM=TypeCOMM(randperm(length(TypeCOMM)));
        
        value=cat(2,ones(1,Target),-ones(1,N_Ev-Target)); value=value(randperm(length(value)));
        
        Ev(:,1)=t;
        for i=1:N_Ev
            Ev(i,TypeCOMM(i)+15)=value(i);
        end
        
        if ~any(diff(Ev(:,1))<15) || ~any(Ev(:,1) <= 1)
            break
        end
    end
    EVENT{N_Scenar}=cat(1,EVENT{N_Scenar},Ev);
    
    MATB_DATA.COMM.NbrTarget = Target; % ligne rajoutee pour recuperer le nombre de target et l utiliser dans la fonction PerfComm
    
        %--------------- EVENT RESMAN -------------------%
    if MATB_DATA.ScenarioType(N_Scenar,1)==0  % Facile
        
        N_Panne=Tot_Ev(N_Scenar,4); % (8 dans le script de Kevin)
        MATB_DATA.RESMAN.FluxPompe{N_Scenar}=[70 60 70 60 60 60 40 40 80 80]/3; % FlowRatesPompes Pompe 1 a 8 plus Vidage A et B Attention les deux dernières valeurs correspondent aux deux reservoirs (attention les valeurs doivent etre sup ou inf autres)
        
        Ev=zeros(N_Panne*2,19);
%         t_start=(linspace(30,240,N_Panne))+randi([-20 20],1,N_Panne); % Depart des pannes
        t_start=(linspace(30,(t_Max-(t_Max/5)),N_Panne))+randi([-20 20],1,N_Panne); % Depart des pannes, Modifie pour permettre des scenarii de differentes durees -- AL
        
        t_end=t_start+randi([-5 5],1,N_Panne)+30; % Durée de la panne 30 sec "+ ou - 5"
        Ev(:,1)=[t_start, t_end]';
        
        if N_Panne >= 7
            pmp_num=randi(8,1,N_Panne); % 2 pannes consecutives peuvent arriver 
        else
            pmp_num=randsample(8, N_Panne)'; % Selection des pompes qui vont etre en panne en evitant 2 pannes consecutives -- AL
        end
            
        for i=1:8
            Ev(find(pmp_num==i),i+7)=-1;
            Ev(find(pmp_num==i)+N_Panne,i+7)=1; % Modifie (find(pmp_num==i)+8) en (find(pmp_num==i)+N_Panne) pour compatibilité avec changement du nombre de panne -- AL
        end
        [~,b]=sort(Ev(:,1));
        Ev=Ev(b,:);
        EVENT{N_Scenar}=cat(1,EVENT{N_Scenar},Ev);
        
    else % Difficile

        MATB_DATA.RESMAN.FluxPompe{N_Scenar}=[90 90 100 80 80 80 75 75 120 120]/2; % FlowRatesPompes Pompe 1 a 8 plus Vidage A et B
        
        N_Panne=20;
        Ev=zeros(N_Panne*2,19);
        
        t_start=round(linspace(10,280,N_Panne))+randi([-10 10],1,N_Panne); % Depart des pannes
        t_end=t_start+randi([-5 5],1,N_Panne)+20;  % Durée de la panne 20 sec "+ ou - 5"
        Ev(:,1)=[t_start, t_end]';
        
        while true
            pmp_num=randi(8,1,N_Panne);
            if ~any(diff(pmp_num)==0)
                break
            end
        end
        
        for i=1:8
            Ev(find(pmp_num==i),i+7)=-1;
            Ev(find(pmp_num==i)+N_Panne,i+7)=1;
        end
        [~,b]=sort(Ev(:,1));
        Ev=Ev(b,:);
        EVENT{N_Scenar}=cat(1,EVENT{N_Scenar},Ev);
    end
    
    %% FUSION DES EVENTS qui demarre exactement en meme temps
    EVENT_sansDoublon=[];
    [C,~,ic] = unique(EVENT{N_Scenar}(:,1));
    if size(C,1) < size(EVENT{N_Scenar},1) % Si il y a des doublons
        for i=1:max(ic)
            if sum(ic==i) > 1
                DoubleLigne=EVENT{N_Scenar}(ic==i,:);  % On Copie les lignes en double
                NouvelleLigne=[DoubleLigne(1,1) sum(DoubleLigne(:,2:end))];
                EVENT_sansDoublon=cat(1,EVENT_sansDoublon,NouvelleLigne);
            else
                EVENT_sansDoublon=cat(1,EVENT_sansDoublon,EVENT{N_Scenar}(ic==i,:));
            end
        end
        EVENT{N_Scenar}=EVENT_sansDoublon;
    end
    [~,sortEv]=sort(EVENT{N_Scenar}(:,1));
    EVENT{N_Scenar}=EVENT{N_Scenar}(sortEv,:);
    
    MATB_DATA.EVENT{N_Scenar}=EVENT{N_Scenar};
end
close(pop)