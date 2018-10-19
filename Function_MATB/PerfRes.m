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
%%
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
% grid on