% Performance Calculation
function [FigPerf]=Performance
global MATB_DATA

% MATB_DATA.ScenarioNumber=7;
FigPerf=figure('position',[ 449  55  1056  948],'menubar','none','numbertitle','off','name','Performance','windowstyle','Modal');

Posi=[ .25 .3 .5 .5];

%% COMM
Data=MATB_DATA.COMM.DATA{MATB_DATA.ScenarioNumber};
if ~isempty(Data)
    Request=find(Data(:,1)==1); % On cherche les request comm
    PC=0;
    
    for i=1:length(Request)
        if Request(i)+1 <= size(Data,1)  % Si il a des events après la dernière requete
            if i == length(Request)
                b=find(Data(Request(i)+1:end,1)==3); % Si c'est la dernière requete on prend toutes les entrées suivantes
            else
                b=find(Data(Request(i)+1:Request(i+1),1)==3); % On cherche les entrée avant la prochaine requete
            end
            
            if ~isempty(b) % Si il y une réponse
                Ask=Data(Request(i),:);
                Rep=Data(Request(i)+b,2:end);
                
                if Ask(3)+0.001*Ask(4)==Rep(Ask(2))
                    PC=PC+1;
                    %                         disp([' Request ' num2str(i) ' OK'])
                else
                    %                         disp([' Request ' num2str(i) ' FAUX'])
                end
            else
                %                     disp([' Request ' num2str(i) ' No Response'])
            end
        end
    end
    
    
else
    Request=0;
    PC=0;
end
% subplot(224)
subplot('Position',Posi(1,:))
PerfComm
%% Pour PAUSE CLAVIER
drawnow

pause(1)
yesKeys = KbName('Return');

while true
    [~,~,keyCode] = KbCheck;
    if any(keyCode(yesKeys))
        break
    end
end

close(FigPerf)
