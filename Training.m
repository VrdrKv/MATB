% Training - Entrainement
function Training
global MATB_DATA
% pop_waiter(["Nous allons commencer par deux sessions d'entrainement de 2mn chacune", ...
%     "(Appuyez sur 'ENTREE' pour continuer)"],1);
% 
pop_waiter(["Appuyez sur la touche 'ENTREE' pour commencer le premier entrainement"],1); MATB_Main_Simu23_09  ; Performance %MATB_Main  

MATB_DATA.ScenarioNumber=MATB_DATA.ScenarioNumber+1; 

pop_waiter(["Le premier entrainement est terminé", ...
    "(Passons à present au deuxieme entrainement"],1)
% pop_waiter(["Appuyez sur la touche 'ENTREE' pour commencer le deuxieme entrainement", ...
%     "(Appuyez sur la touche 'ENTREE' pour commencer)"],1); MATB_Main_Simu23_09 ; Performance

MATB_DATA.ScenarioNumber=MATB_DATA.ScenarioNumber+1; 
