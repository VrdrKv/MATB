function [pop]=guide(scenarioType,ScenarioNumber)
% A function to display a message next to the MATB to remember particpants
% to cooperate or not
%
% scenarioType refer to the 3 conditions
% ScenarioNumber to the actual scenario number (knowing that there is 4
% training)

NumScenar=max(ScenarioNumber-4,0);

pop=figure('position',[10 360 390 580],'menubar','none','numbertitle','off','resize','off');
text(0.15,1,['Scenario ' num2str(NumScenar) ' / 8'],'Fontsize',20,'Color','k')

if scenarioType==0
    text(0,0.3,'DONT COOPERATE','Fontsize',24,'Color','k')
else
    text(0.1,0.6,'COOPERATE','Fontsize',24,'Color','k')
end
axis off






