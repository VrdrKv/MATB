% function [THETA_Force,LastUpdate_TRACK]=Update_TRACK(h,THETA_Force,joy)
function Update_TRACK
global MATB_DATA
h=MATB_DATA.TRACK.handleCible;

x=h(2).XData; y=h(2).YData; % On recupère la position actuel
MATB_DATA.TRACK.ThetaForce=MATB_DATA.TRACK.ThetaForce+(rand-0.5);

if ~isempty(MATB_DATA.TRACK.JoystickID)
    if MATB_DATA.TRACK.Difficulty{MATB_DATA.ScenarioNumber}==1    % if Difficile
        ForceDuBruit = 1.10; % Si 1 elle est égale à l'input joystick si supérieur le bruit est plus fort
        Vitesse = 0.2;
        
        % MATB_DATA.RESMAN.HorsZone est un boolen qui "dit" si les
        % reservoirs sont Hors Zone. La 1ere lighne rajoute du bruit si
        % hors zone
        %         [X,Y] = pol2cart(MATB_DATA.TRACK.ThetaForce,ForceDuBruit + any(MATB_DATA.RESMAN.HorsZone)*0.05+0.01*randi(10,1) ); %
        [X,Y] = pol2cart(MATB_DATA.TRACK.ThetaForce,ForceDuBruit); % 
        
        x_R=x+Vitesse*mean([axis(MATB_DATA.TRACK.JoystickID, 1) X]);
        y_R=y+Vitesse*mean([-axis(MATB_DATA.TRACK.JoystickID, 2) Y]);
        
    else        
        ForceDuBruit = 0.9; % Si 1 elle est égale à l'input joystick si supérieur le bruit est plus fort
        Vitesse = 0.07;
        
        [X,Y] = pol2cart(MATB_DATA.TRACK.ThetaForce,ForceDuBruit + any(MATB_DATA.RESMAN.HorsZone)*0.1 );
        
        x_R=x+Vitesse*mean([axis(MATB_DATA.TRACK.JoystickID, 1) X]);
        y_R=y+Vitesse*mean([-axis(MATB_DATA.TRACK.JoystickID, 2) Y]);
    end
else 
    x_R=0; y_R=0;
end
x=max([min([x_R 10]) -10]); y=max([min([y_R 10]) -10]); % Garder dans les limites -10 10
circle(x,y,h); % Update circle position

% Change Track color if out of box
% if x > 2 && x < 4 || x < -2 && x > -4 || y > 2 && y < 4 || y < -2 && y > -4
if x > 2 || y > 2 || x < -2 || y < -2
    set(h,'Color',[1 0.6 0],'MarkerFaceColor',[1 0.6 0])
end

if x < 2 && y < 2 && x > -2 && y > -2
    set(h,'Color','k','MarkerFaceColor','k')
end

% Close Pump if Out of square:Red
if  (x > 4 || y > 4 || x < -4 || y < -4)% && ~all(get(MATB_DATA.TRACK.handleCible(1),'Color')==[1 0 0])
    set(h,'Color','r','MarkerFaceColor','r')
    
    if MATB_DATA.Param.PumpCloseTrack
        % On eteint les pompes si c'est rouge
        colorPMP=cell2mat(get(MATB_DATA.RESMAN.handlePompe,'backgroundcolor')); % Recherche l'Etat des pompes
        StatePMP_k(colorPMP(:,1)==0.94)=0; % Eteint
        StatePMP_k(colorPMP(:,1)==0)=1; % Allume
        StatePMP_k(colorPMP(:,1)==1)=2; % Panne (pas de flux)
        
        set(MATB_DATA.RESMAN.handlePompe(StatePMP_k ~= 2),'backgroundColor',[0.94 0.94 0.94])
    end
    
    %     send_log('TRACKING','SORTIE CADRE')
end


MATB_DATA.LastUpdate.TRACK=GetSecs;