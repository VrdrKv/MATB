% function [LastUpdate_RESMAN,pmp,h_NIV,h_tNiv,faulty_pmp,NIV,FRP]=Update_RESMAN(pmp,h_NIV,h_tNiv,faulty_pmp,NIV,FRP)
function [MATB_DATA]=Update_RESMAN(MATB_DATA)

ColorBar=[0 0.4470 0.7410];
colorPMP=cell2mat(get(MATB_DATA.RESMAN.handlePompe,'backgroundcolor')); % Recherche l'état des pompes en regardant la couleur du boutons
set(MATB_DATA.RESMAN.handlePompe(find(MATB_DATA.RESMAN.EtatPompe)),'backgroundcolor',[1 0 0]); % Permet de prendre en compte les MouseClick

StatePMP(colorPMP(:,1)==0.94)=0; % Eteint
StatePMP(colorPMP(:,1)==0)=1; % Allumé
StatePMP(colorPMP(:,1)==1)=0; % Panne (pas de flux)

% Extinction des pompes si reservoirs d'arriver pleins ou départ vide
if MATB_DATA.RESMAN.NiveauxPompe(1) == 0
    set(MATB_DATA.RESMAN.handlePompe(7),'backgroundcolor',[.94 .94 .94]); StatePMP(7)=0;
end
if MATB_DATA.RESMAN.NiveauxPompe(2) == 0
    set(MATB_DATA.RESMAN.handlePompe(8),'backgroundcolor',[.94 .94 .94]); StatePMP(8)=0;
end
if MATB_DATA.RESMAN.NiveauxPompe(3) == 0
    set(MATB_DATA.RESMAN.handlePompe(1),'backgroundcolor',[.94 .94 .94]); StatePMP(1)=0;
end
if MATB_DATA.RESMAN.NiveauxPompe(4) == 0
    set(MATB_DATA.RESMAN.handlePompe(3),'backgroundcolor',[.94 .94 .94]); StatePMP(3)=0;
end

FRP=MATB_DATA.RESMAN.FluxPompe{MATB_DATA.ScenarioNumber};
% Calcul du Nouveau Niveaux
MATB_DATA.RESMAN.NiveauxPompe(1)=round(min([max([MATB_DATA.RESMAN.NiveauxPompe(1) - FRP(9) + StatePMP(1)*FRP(1) + StatePMP(2)*FRP(2) + StatePMP(8)*FRP(8) - StatePMP(7)*FRP(7) 0]) 4400 ]));
MATB_DATA.RESMAN.NiveauxPompe(2)=round(min([max([MATB_DATA.RESMAN.NiveauxPompe(2) - FRP(10) + StatePMP(3)*FRP(3) + StatePMP(4)*FRP(4) + StatePMP(7)*FRP(7) - StatePMP(8)*FRP(8) 0]) 4400 ]));
MATB_DATA.RESMAN.NiveauxPompe(3)=round(min([max([MATB_DATA.RESMAN.NiveauxPompe(3)+ StatePMP(5)*FRP(5) - StatePMP(1)*FRP(1) 0]) 2000]));
MATB_DATA.RESMAN.NiveauxPompe(4)=round(min([max([MATB_DATA.RESMAN.NiveauxPompe(4) + StatePMP(6)*FRP(6) - StatePMP(3)*FRP(3) 0]) 2000]));

set(MATB_DATA.RESMAN.handleTextNiveau(1),'String',num2str(MATB_DATA.RESMAN.NiveauxPompe(1)))
set(MATB_DATA.RESMAN.handleTextNiveau(2),'String',num2str(MATB_DATA.RESMAN.NiveauxPompe(2)))
set(MATB_DATA.RESMAN.handleTextNiveau(3),'String',num2str(MATB_DATA.RESMAN.NiveauxPompe(3)))
set(MATB_DATA.RESMAN.handleTextNiveau(4),'String',num2str(MATB_DATA.RESMAN.NiveauxPompe(4)))

% Changement de Couleur si trop bas trop haut
if MATB_DATA.RESMAN.NiveauxPompe(1)<=2000 || MATB_DATA.RESMAN.NiveauxPompe(1)>=3000
    set(MATB_DATA.RESMAN.handleTextNiveau(1),'Color',[1 0.6 0])
    MATB_DATA.RESMAN.HorsZone(1)=1;
else
    set(MATB_DATA.RESMAN.handleTextNiveau(1),'Color',ColorBar)
    MATB_DATA.RESMAN.HorsZone(1)=0;
end
if MATB_DATA.RESMAN.NiveauxPompe(2)<=2000 || MATB_DATA.RESMAN.NiveauxPompe(2)>=3000
    set(MATB_DATA.RESMAN.handleTextNiveau(2),'Color',[1 0.6 0])
    MATB_DATA.RESMAN.HorsZone(2)=1;
else
    set(MATB_DATA.RESMAN.handleTextNiveau(2),'Color',ColorBar)
    MATB_DATA.RESMAN.HorsZone(2)=0;
end

% Mise à jour du niveau graphiquement
Lev(1)=MATB_DATA.RESMAN.NiveauxPompe(1)*(3.9/2500)+12.1; set(MATB_DATA.RESMAN.handleNiveau(1),'YData',[12.1 Lev(1) Lev(1) 12.1])
Lev(2)=MATB_DATA.RESMAN.NiveauxPompe(2)*(3.9/2500)+12.1; set(MATB_DATA.RESMAN.handleNiveau(2),'YData',[12.1 Lev(2) Lev(2) 12.1])
Lev(3)=MATB_DATA.RESMAN.NiveauxPompe(3)*(2.9/1000)+1.1; set(MATB_DATA.RESMAN.handleNiveau(3),'YData',[1.1 Lev(3) Lev(3) 1.1])
Lev(4)=MATB_DATA.RESMAN.NiveauxPompe(4)*(2.9/1000)+1.1; set(MATB_DATA.RESMAN.handleNiveau(5),'YData',[1.1 Lev(4) Lev(4) 1.1])

% Extinction des pompes si reservoirs vide
if MATB_DATA.RESMAN.NiveauxPompe(1) == 0
    set(MATB_DATA.RESMAN.handlePompe(7),'backgroundcolor',[.94 .94 .94]); StatePMP(7)=0;
end
if MATB_DATA.RESMAN.NiveauxPompe(2) == 0
    set(MATB_DATA.RESMAN.handlePompe(8),'backgroundcolor',[.94 .94 .94]); StatePMP(8)=0;
end
if MATB_DATA.RESMAN.NiveauxPompe(3) == 0
    set(MATB_DATA.RESMAN.handlePompe(1),'backgroundcolor',[.94 .94 .94]); StatePMP(1)=0;
end
if MATB_DATA.RESMAN.NiveauxPompe(4) == 0
    set(MATB_DATA.RESMAN.handlePompe(3),'backgroundcolor',[.94 .94 .94]); StatePMP(3)=0;
end
% Extinction des pompes si reservoirs pleins
if MATB_DATA.RESMAN.NiveauxPompe(1) == 4400
    set(MATB_DATA.RESMAN.handlePompe(1:2),'backgroundcolor',[.94 .94 .94]); StatePMP(1:2)=0;
end
if MATB_DATA.RESMAN.NiveauxPompe(2) == 4400
    set(MATB_DATA.RESMAN.handlePompe(3:4),'backgroundcolor',[.94 .94 .94]); StatePMP(3:4)=0;
end
if MATB_DATA.RESMAN.NiveauxPompe(3) == 2000
    set(MATB_DATA.RESMAN.handlePompe(5),'backgroundcolor',[.94 .94 .94]); StatePMP(5)=0;
end
if MATB_DATA.RESMAN.NiveauxPompe(4) == 2000
    set(MATB_DATA.RESMAN.handlePompe(6),'backgroundcolor',[.94 .94 .94]); StatePMP(6)=0;
end

MATB_DATA.RESMAN.DATA{MATB_DATA.ScenarioNumber}=cat(1,MATB_DATA.RESMAN.DATA{MATB_DATA.ScenarioNumber},MATB_DATA.RESMAN.NiveauxPompe(1:2));
MATB_DATA.LastUpdate.RESMAN=GetSecs;