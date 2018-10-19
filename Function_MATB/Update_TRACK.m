% function [THETA_Force,LastUpdate_TRACK]=Update_TRACK(h,THETA_Force,joy)
function [MATB_DATA]=Update_TRACK(MATB_DATA)

h=MATB_DATA.TRACK.handleCible;

x=h(2).XData; y=h(2).YData;
MATB_DATA.TRACK.ThetaForce=MATB_DATA.TRACK.ThetaForce+(rand-0.5);

if ~isempty(MATB_DATA.TRACK.JoystickID)
    if MATB_DATA.TRACK.Difficulty{MATB_DATA.ScenarioNumber}==1    % Difficile % Facile % On enleve si les pompes sont pas biens
        %     [X,Y] = pol2cart(MATB_DATA.TRACK.ThetaForce,1.15 + any(MATB_DATA.RESMAN.HorsZone)*0.1 );
        [X,Y] = pol2cart(MATB_DATA.TRACK.ThetaForce,1.10 + any(MATB_DATA.RESMAN.HorsZone)*0.05+0.01*randi(10,1) );
        
        x_R=x+0.2*mean([axis(MATB_DATA.TRACK.JoystickID, 1) X]);
        y_R=y+0.2*mean([-axis(MATB_DATA.TRACK.JoystickID, 2) Y]);
        
    else                                % Facile % On enleve si les pompes sont pas biens
        [X,Y] = pol2cart(MATB_DATA.TRACK.ThetaForce,0.9 + any(MATB_DATA.RESMAN.HorsZone)*0.1 );
        
        x_R=x+0.07*mean([axis(MATB_DATA.TRACK.JoystickID, 1) X]);
        y_R=y+0.07*mean([-axis(MATB_DATA.TRACK.JoystickID, 2) Y]);
    end
else 
    x_R=0; y_R=0;
end
x=max([min([x_R 10]) -10]); y=max([min([y_R 10]) -10]); % Garder dans les limites -10 10
circle(x,y,h);

% Couleur Track
% if x > 2 && x < 4 || x < -2 && x > -4 || y > 2 && y < 4 || y < -2 && y > -4
if x > 2 || y > 2 || x < -2 || y < -2
    set(h,'Color',[1 0.6 0],'MarkerFaceColor',[1 0.6 0])
end

if x < 2 && y < 2 && x > -2 && y > -2
    set(h,'Color','k','MarkerFaceColor','k')
end

if  (x > 4 || y > 4 || x < -4 || y < -4)% && ~all(get(MATB_DATA.TRACK.handleCible(1),'Color')==[1 0 0])
    set(h,'Color','r','MarkerFaceColor','r')
    
    % On eteint les pompes si c'est rouge
    colorPMP=cell2mat(get(MATB_DATA.RESMAN.handlePompe,'backgroundcolor')); % Recherche l'Etat des pompes
    StatePMP_k(colorPMP(:,1)==0.94)=0; % Eteint
    StatePMP_k(colorPMP(:,1)==0)=1; % Allume
    StatePMP_k(colorPMP(:,1)==1)=2; % Panne (pas de flux)
    
    set(MATB_DATA.RESMAN.handlePompe(StatePMP_k ~= 2),'backgroundColor',[0.94 0.94 0.94])
    
    %     send_log('TRACKING','SORTIE CADRE')
end


MATB_DATA.LastUpdate.TRACK=GetSecs;