function gen_EVENT
global MATB_DATA
% % EVENT MATB
%
%  SON minimum 15 secondes entre les MESSAGES
%
%            -1: Bas  1: Haut      -1: Error         Pmp    -1:Error     1:PluError               1:Own -1:Others
% Seconds  F1    F2    F3    F4    F5    F6     1     2     3    4     5     6     7      8   NAV1  NAV2   COM1  COM2

%   10     0 0 0 0 0 1 


for N_Scenar=1:size(MATB_DATA.ScenarioType,1)
    EVENT{N_Scenar}=[];
    disp(['Generating Event for Scenario ' num2str(N_Scenar) ' / ' num2str(size(MATB_DATA.ScenarioType,1))])
    %--------------------------------------------%
    %--------------- EVENT PF -------------------%
    %--------------------------------------------%
    N_Ev=30;
    Ev=zeros(N_Ev,19);
    
    t=round(linspace(5,280,N_Ev))+randi([-15 15],1,N_Ev);
    
    t(t>280)=280; t(t<5)=5;
    t=sort(t);
    % Repartition entre les bars et les alarmes lumineuses
    N_F1F4=N_Ev*2/3; N_F5F6=N_Ev*1/3;
    
    % Temps dans les 5mn
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

    if MATB_DATA.ScenarioType(N_Scenar,2)==0  % Track Facile
        MATB_DATA.TRACK.Difficulty{N_Scenar}=0;
    else % Track Difficile
        MATB_DATA.TRACK.Difficulty{N_Scenar}=1;
    end
    
    %--------------------------------------------%
    %--------------- EVENT PM -------------------%
    %--------------------------------------------%
    
    % COMM
    N_Ev=16;
    while true
        Ev=zeros(N_Ev,19);
        t=round(linspace(10,270,N_Ev))+randi([-10 5],1,N_Ev);
        
        TypeCOMM=randi([1 4],N_Ev,1);
        TypeCOMM=TypeCOMM(randperm(length(TypeCOMM)));
        
        value=cat(2,ones(1,10),-ones(1,6)); value=value(randperm(length(value)));
        
        Ev(:,1)=t;
        for i=1:N_Ev
            Ev(i,TypeCOMM(i)+15)=value(i);
        end
        
        if ~any(diff(Ev(:,1))<15)
            break
        end
    end
    EVENT{N_Scenar}=cat(1,EVENT{N_Scenar},Ev);
    
    if MATB_DATA.ScenarioType(N_Scenar,3)==0  % PM Facile
        % RESMAN
        MATB_DATA.RESMAN.FluxPompe{N_Scenar}=[70 60 70 60 60 60 40 40 80 80]/3; % FlowRatesPompes Pompe 1 a 8 plus Vidage A et B
        
        Ev=zeros(8*2,19);
        t_start=(30:30:240)+randi([-20 20],1,8);
        t_end=t_start+randi([-5 5],1,8)+30;
        Ev(:,1)=[t_start, t_end]';
        
        pmp_num=randi(8,1,8);
        
        for i=1:8
            Ev(find(pmp_num==i),i+7)=-1;
            Ev(find(pmp_num==i)+8,i+7)=1;
        end
        [~,b]=sort(Ev(:,1));
        Ev=Ev(b,:);
        EVENT{N_Scenar}=cat(1,EVENT{N_Scenar},Ev);
        
    else % PM Difficile
        % RESMAN
        %     FRP=[80 60 80 60 60 60 40 40 80 80]/6; % FlowRatesPompes Pompe 1 a 8 plus Vidage A et B
        MATB_DATA.RESMAN.FluxPompe{N_Scenar}=[90 90 100 80 80 80 75 75 120 120]/2; % FlowRatesPompes Pompe 1 a 8 plus Vidage A et B
        
        N_Ev=20;
        Ev=zeros(N_Ev*2,19);
        
        t_start=round(linspace(10,280,N_Ev))+randi([-10 10],1,N_Ev);
        t_end=t_start+randi([-5 5],1,N_Ev)+20;
        Ev(:,1)=[t_start, t_end]';
        
        while true
            pmp_num=randi(8,1,N_Ev);
            if ~any(diff(pmp_num)==0)
                break
            end
        end
        
        for i=1:8
            Ev(find(pmp_num==i),i+7)=-1;
            Ev(find(pmp_num==i)+N_Ev,i+7)=1;
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