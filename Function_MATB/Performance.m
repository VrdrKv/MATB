% Performance Calculation
function Performance
global MATB_DATA

FigPerf=figure('position',[ 449  55  1056  948],'menubar','none','numbertitle','off','name','Performance','windowstyle','Modal','CloseRequestFcn',@CloseFigEmpty);

Posi=[ .1 .6 .3 .3
       .5 .55 .4 .35
       .5 .05 .4 .4
       .1 .1 .3 .3 ];

%% SYSMON
if ~isempty(MATB_DATA.SYSMON.DATA{MATB_DATA.ScenarioNumber})
    PS=MATB_DATA.SYSMON.DATA{MATB_DATA.ScenarioNumber}(:,2);
else
    PS=10;
end
subplot('Position',Posi(1,:))
plot([1 3],[0 0],'k','linewidth',3); hold on
plot([3 5],[0 0],'Color',[1 0.6 0],'linewidth',3)
plot([5 7],[0 0],'r','linewidth',3)

PerfSysVal=max(min(mean(PS),7),1);
plot(PerfSysVal,0,'ok','markersize',10,'linewidth',2)

text(-.2,0.2,'\bf Alarm Mean Reaction Time','fontsize',20)

text(.5,0.07,'1sec','fontsize',20)
text(6,0.07,'7sec','fontsize',20,'color','r')
ttt=text(2.5,-.07,[num2str(round(mean(PS),2)) ' seconds'],'fontsize',20);

if mean(PS) <= 7 && mean(PS) > 4
    set(ttt,'color',[1 0.6 0])
else if mean(PS) <= 4
         set(ttt,'color','k')
    else
       set(ttt,'color','r')
    end

end
xlim([0 8])
ylim([-0.3 0.4])
axis off
%% TRACK
PT=sqrt(MATB_DATA.TRACK.DATA{MATB_DATA.ScenarioNumber}(:,1).^2 + MATB_DATA.TRACK.DATA{MATB_DATA.ScenarioNumber}(:,2).^2);  % /(sqrt(2)*10);

x=MATB_DATA.TRACK.DATA{MATB_DATA.ScenarioNumber};
y=x < 2 & x > -2;
TempsPasseNoir=size(find(y(:,1)&y(:,2)),1)/length(y)*100;
TempsPasseNoir=round(TempsPasseNoir,2);

y= x > 4 | x < -4;
TempsPasseRouge=size(find(y(:,1) | y(:,2)),1)/length(y)*100;
TempsPasseRouge=round(TempsPasseRouge,2);

TempsPasseOrange=100-TempsPasseRouge-TempsPasseNoir;

subplot('Position',Posi(2,:))

x=2; y=0;
r=1.5;
th = 0:pi/50:2*pi;
xunit = r * cos(th) + x;
yunit = r * sin(th) + y;
h_cr=plot(xunit, yunit,'k','linewidth',3); hold on
h_cx=plot(x,y,'ok','linewidth',1,'markerfacecolor','k');
h_l1=plot([x x],[y+1.5 y+0.5],'k','linewidth',3);
h_l2=plot([x x],[y-1.5 y-0.5],'k','linewidth',3);
h_l3=plot([x+1.5 x+0.5],[y y],'k','linewidth',3);
h_l4=plot([x-1.5 x-0.5],[y y],'k','linewidth',3);
h_cible=[h_cr,h_cx,h_l1,h_l2,h_l3,h_l4];
text(1,-2.5,num2str(TempsPasseNoir),'fontsize',20)

x=6; y=0;
r=1.5;
th = 0:pi/50:2*pi;
xunit = r * cos(th) + x;
yunit = r * sin(th) + y;
h_cr=plot(xunit, yunit,'k','linewidth',3); hold on
h_cx=plot(x,y,'ok','linewidth',1,'markerfacecolor','k');
h_l1=plot([x x],[y+1.5 y+0.5],'k','linewidth',3);
h_l2=plot([x x],[y-1.5 y-0.5],'k','linewidth',3);
h_l3=plot([x+1.5 x+0.5],[y y],'k','linewidth',3);
h_l4=plot([x-1.5 x-0.5],[y y],'k','linewidth',3);
h_cible=[h_cr,h_cx,h_l1,h_l2,h_l3,h_l4];
set(h_cible,'Color',[1 0.6 0],'MarkerFaceColor',[1 0.6 0])
text(5,-2.5,num2str(TempsPasseOrange),'fontsize',20)

x=10; y=0;
r=1.5;
th = 0:pi/50:2*pi;
xunit = r * cos(th) + x;
yunit = r * sin(th) + y;
h_cr=plot(xunit, yunit,'k','linewidth',3); hold on
h_cx=plot(x,y,'ok','linewidth',1,'markerfacecolor','k');
h_l1=plot([x x],[y+1.5 y+0.5],'k','linewidth',3);
h_l2=plot([x x],[y-1.5 y-0.5],'k','linewidth',3);
h_l3=plot([x+1.5 x+0.5],[y y],'k','linewidth',3);
h_l4=plot([x-1.5 x-0.5],[y y],'k','linewidth',3);
h_cible=[h_cr,h_cx,h_l1,h_l2,h_l3,h_l4];
set(h_cible,'Color','r','MarkerFaceColor','r')
text(9,-2.5,num2str(TempsPasseRouge),'fontsize',20)

xlim([-1 13.5])
ylim([-7 4])

PerfTrackVal=min(mean(PT)*2,12);
plot([0 4],[-6 -6],'k','linewidth',3)
plot([4 8],[-6 -6],'Color',[1 0.6 0],'linewidth',3)
plot([8 12],[-6 -6],'r','linewidth',3)
plot(PerfTrackVal,-6,'ok','markersize',10,'linewidth',2)

text(-.5,-5,'Perfect','fontsize',20)
text(9.5,-5,'Far away','fontsize',20,'color','r')
text(3,-4,'\bf Mean distance','fontsize',20,'color','k')
text(1.3,3,'\bf Tracking Percentage','fontsize',20)

axis off


%% RESMAN
PR=abs(2500-MATB_DATA.RESMAN.DATA{MATB_DATA.ScenarioNumber});
% subplot(223)
subplot('Position',Posi(3,:))
% PRfig=figure('position',[993    80   588   366],'menubar','none','numbertitle','off');
  ColorBar=[0 0.4470 0.7410];
ColorBar2=[116/256 208/256 241/256];
  LW=1; FontSz=13;
 
%% GAUCHE
  dec=0; ht=1;
% Marqueurs Remplissage sur A et B
fill([2 2 2.5 2.5]+dec,[15 17 17 15]+ht,ColorBar2,'linestyle','none'); hold on
plot([2 2.5]+dec,[16 16]+ht,'Color',ColorBar,'linewidth',LW)
fill([8 8 7.5 7.5]+dec,[15 17 17 15]+ht,ColorBar2,'linestyle','none'); hold on
plot([7.5 8]+dec,[16 16]+ht,'Color',ColorBar,'linewidth',LW)
fill(10+[2 2 2.5 2.5]+dec,[15 17 17 15]+ht,ColorBar2,'linestyle','none'); hold on
plot(10+[2 2.5]+dec,[16 16]+ht,'Color',ColorBar,'linewidth',LW)
fill(10+[8 8 7.5 7.5]+dec,[15 17 17 15]+ht,ColorBar2,'linestyle','none'); hold on
plot(10+[7.5 8]+dec,[16 16]+ht,'Color',ColorBar,'linewidth',LW)

% A B
plot([2.5 2.5 7.5 7.5 2.5]+dec,[12 19 19 12 12]+ht,'Color',ColorBar,'linewidth',LW); 
plot([12.5 12.5 17.5 17.5 12.5]+dec,[12 19 19 12 12]+ht,'Color',ColorBar,'linewidth',LW); 

% Niveaux des Reservoirs
h_NIV(1)=fill([2.6 2.6 7.4 7.4]+dec,[12.1 16 16 12.1]+ht,[0 1 0],'linestyle','none');
h_NIV(2)=fill(10+[2.6 2.6 7.4 7.4]+dec,[12.1 14 14 12.1]+ht,[1 0.6 0],'linestyle','none');

  %% DROITE = gauche + dec en x
  dec=23;
% Marqueurs Remplissage sur A et B
fill([2 2 2.5 2.5]+dec,[15 17 17 15]+ht,ColorBar2,'linestyle','none'); hold on
plot([2 2.5]+dec,[16 16]+ht,'Color',ColorBar,'linewidth',LW)
fill([8 8 7.5 7.5]+dec,[15 17 17 15]+ht,ColorBar2,'linestyle','none'); hold on
plot([7.5 8]+dec,[16 16]+ht,'Color',ColorBar,'linewidth',LW)
fill(10+[2 2 2.5 2.5]+dec,[15 17 17 15]+ht,ColorBar2,'linestyle','none'); hold on
plot(10+[2 2.5]+dec,[16 16]+ht,'Color',ColorBar,'linewidth',LW)
fill(10+[8 8 7.5 7.5]+dec,[15 17 17 15]+ht,ColorBar2,'linestyle','none'); hold on
plot(10+[7.5 8]+dec,[16 16]+ht,'Color',ColorBar,'linewidth',LW)

% A B
plot([2.5 2.5 7.5 7.5 2.5]+dec,[12 19 19 12 12]+ht,'Color',ColorBar,'linewidth',LW); 
plot([12.5 12.5 17.5 17.5 12.5]+dec,[12 19 19 12 12]+ht,'Color',ColorBar,'linewidth',LW); 

% Niveaux des Reservoirs
h_NIV(1)=fill([2.6 2.6 7.4 7.4]+dec,[12.1 16 16 12.1]+ht,[0 1 0],'linestyle','none');
h_NIV(2)=fill(10+[2.6 2.6 7.4 7.4]+dec,[12.1 14 14 12.1]+ht,[1 0.6 0],'linestyle','none');

PerfResTot=mean(PR);
PrA=round(length(find(PR(:,1)<500))/size(PR,1)*100,2);
PrB=round(length(find(PR(:,2)<500))/size(PR,1)*100,2);

% PR A
h_tNiv(1)=text(2.5,11+ht,[num2str(PrA) '%'],'fontsize',FontSz,'color',[0 0.8 0]); %plot([4 4 6 6 4],[10.5 11.5 11.5 10.5 10.5],'k')
h_tNiv(2)=text(12.5,11+ht,[num2str(100-PrA) '%'],'fontsize',FontSz,'color',[0.9 0.6 0]); %plot(10+[4 4 6 6 4],[10.5 11.5 11.5 10.5 10.5],'k')
% PR B
h_tNiv(1)=text(3+dec,11+ht,[num2str(PrB) '%'],'fontsize',FontSz,'color',[0 0.8 0]); %plot([4 4 6 6 4],[10.5 11.5 11.5 10.5 10.5],'k')
h_tNiv(2)=text(13+dec,11+ht,[num2str(100-PrB) '%'],'fontsize',FontSz,'color',[0.9 0.6 0]); %plot(10+[4 4 6 6 4],[10.5 11.5 11.5 10.5 10.5],'k')

text(1,26+ht,'\bf Fuel Percentage in Critical Zone','fontsize',20)
text(5.5,21+ht,'\bf Tank A','fontsize',16)
text(28.5,21+ht,'\bf Tank B','fontsize',16)

text(5,5.5+ht,'2500','fontsize',16)
text(17,5.5+ht,'\pm 500','fontsize',16,'color',[1 0.6 0])
text(27.5,5.5+ht,'\pm 1000','fontsize',16,'color',[1 0 0])
ttt=text(15,2,['\pm ' num2str(round(mean(PR(:)),2))],'fontsize',20);

if mean(PR(:)) >= 500 && mean(PR(:)) < 1000
    set(ttt,'color',[1 0.6 0])
else if mean(PR(:)) >= 1000
         set(ttt,'color','r');
    else
       set(ttt,'color','k');
    end

end


PerfResTot=min(PerfResTot,1500);
ht=8.5; lg=2.5;
plot([5 15]+lg,[0 0]+ht,'k','linewidth',3); hold on
plot([15 25]+lg,[0 0]+ht,'Color',[1 0.6 0],'linewidth',3)
plot([25 35]+lg,[0 0]+ht,'r','linewidth',3)
plot((mean(PerfResTot)/50)+5+lg,ht,'ok','markersize',10,'linewidth',2)

ylim([0 30])
xlim([0 45])

axis off


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
subplot('Position',Posi(4,:))
% PCfig=figure('position',[386    81   588   366],'menubar','none','numbertitle','off');

%paramètres d'origine (Kevin)
% plot([0 3],[0 0],'k','linewidth',3); hold on
% plot([3 6],[0 0],'Color',[1 0.6 0],'linewidth',3)
% plot([6 9],[0 0],'r','linewidth',3)

% text(-1.5,0.5,'\bf Communication Exactitude','fontsize',20)

% text(0,0.07,'10/10','fontsize',20)
% text(3,0.07,'7/10','fontsize',20,'color',[1 0.6 0])
% text(6,0.07,'4/10','fontsize',20,'color','r')
% 
% if PC < 8  && PC > 4
%       text(3.5,0.3,[ num2str(PC) ' / 10 '],'fontsize',27,'color',[1 0.6 0])
% else if PC < 6
%         text(3.5,0.3,[ num2str(PC) ' / 10 '],'fontsize',27,'color','r')
%     else
%         text(3.5,0.3,[ num2str(PC) ' / 10 '],'fontsize',27)
%     end
% end
% 
% 
% PC=max(PC,1);
% plot(10-PC,0,'ok','markersize',10,'linewidth',2)
% 
% 
% xlim([-1 10])
% ylim([-0.2 0.7])

%modifications d'affichage en fonction du block expérimental (AL)----------

if MATB_DATA.ScenarioNumber <= 2
    
    plot([0 1],[0 0],'k','linewidth',3); hold on
    plot([1 2],[0 0],'r','linewidth',3)
    text(0.15,0.5,'\bf Communication Exactitude','fontsize',20)
    text(-0.1,0.07,'2/2','fontsize',20)
    text(0.95,0.07,'1/2','fontsize',20,'color','r')
    text(1.95,0.07,'0/2','fontsize',20,'color','r')
    
    if PC <= 1
        text(0.9,0.3,[ num2str(PC) ' / 2'],'fontsize',27,'color','r')
        plot(2-PC,0,'ok','markersize',10,'linewidth',2)
    
    else
        text(0.9,0.3,[ num2str(PC) ' / 2 '],'fontsize',27)
        plot(2-PC,0,'ok','markersize',10,'linewidth',2)
    
    end
    
    xlim([-0.1 2.1])
    ylim([-0.2 0.7])
  
    
else
    
    plot([0 3],[0 0],'k','linewidth',3); hold on
    plot([3 6],[0 0],'Color',[1 0.6 0],'linewidth',3)
    plot([6 9],[0 0],'r','linewidth',3)
    text(-1.5,0.5,'\bf Communication Exactitude','fontsize',20)
    text(1,0.07,'5/5','fontsize',20)
    text(3.8,0.07,'3/5','fontsize',20,'color',[1 0.6 0])
    text(7,0.07,'1/5','fontsize',20,'color','r')
    
    if PC == 3
        text(3.5,0.3,[ num2str(PC) ' / 5 '],'fontsize',27,'color',[1 0.6 0])
        PC=max(PC,1);
        plot(10-2*PC,0,'ok','markersize',10,'linewidth',2)
    
    elseif PC <= 2
        text(3.5,0.3,[ num2str(PC) ' / 5 '],'fontsize',27,'color','r')
        PC=max(PC,1);
        plot(10-2*PC,0,'ok','markersize',10,'linewidth',2)
   
    else
        text(3.5,0.3,[ num2str(PC) ' / 5 '],'fontsize',27)
        PC=max(PC,1);
        plot(10-2*PC,0,'ok','markersize',10,'linewidth',2)
        
    end

xlim([-1 10])
ylim([-0.2 0.7])  

end

%------------------------------------------------------------------------


axis off
% grid on
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

delete(FigPerf)

% close(PRfig)
% close(PTfig)
% close(PCfig)


%% OTHER TEST
% %% Perf TRACK
% % Distance / Distance Max (bord)
% PT=1-mean(sqrt(MATB_DATA.TRACK.DATA{1}(:,1).^2 + MATB_DATA.TRACK.DATA{1}(:,2).^2))/(sqrt(2)*10);
% disp(['TRACK NOTE : ' num2str(round(PT*20,1)) ' / 20'])
%
%
% %% Perf RESMAN (Difference ï¿½ 2500) / 2500
% PRes=1-mean(abs(2500-MATB_DATA.RESMAN.DATA{1}))/2500;
% Presm=mean(PRes);
% disp(['RESMAN NOTE : ' num2str(round(Presm*20,1)) ' / 20'])
%
% %% Perf SYSMON
% a= MATB_DATA.SYSMON.DATA{1};
% disp(['SYSMON RT m= ' num2str(mean(a(:,2))) ' sec ; std= '  num2str(std(a(:,2)))])
%
% b= -0.25*a(:,2)+1.25;
% Note=max(cat(2,b,zeros(length(b),1)),[],2);
% Note=min(cat(2,Note,ones(length(b),1)),[],2);
%
% disp(['SYSMON NOTE : ' num2str(round(mean(Note)*20,1)) ' / 20'])
%
% %%
% Data=MATB_DATA.COMM.DATA{1};
%
% Request=find(Data==1);
%
% b=find(Data(Request(i):end,1)==3);
% Point=0;
% for i=1:length(Request)
%     if ~isempty(b) && b-Request(i)==1
%         if Data(Request(i),3)+0.001*Data(Request(i),4)==Data(b,Data(Request(1),2))
%             Point=Point+1;
%         end
%     end
% end





