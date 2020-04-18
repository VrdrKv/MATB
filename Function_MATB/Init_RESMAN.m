function Init_RESMAN
global MATB_DATA

subplot('Position',[0.35,0.05,0.6,0.4])
% set(gca, 'DrawMode','fast'); % 'normal' is the default axes value

ColorBar=[0 0.4470 0.7410];
ColorBar2=[116/256 208/256 241/256];

LW=1; FontSz=19;
% Marqueurs Remplissage sur A et B
fill([2 2 2.5 2.5],[15 17 17 15],ColorBar2,'linestyle','none'); hold on
plot([2 2.5],[16 16],'Color',ColorBar,'linewidth',LW)
fill([8 8 7.5 7.5],[15 17 17 15],ColorBar2,'linestyle','none'); hold on
plot([7.5 8],[16 16],'Color',ColorBar,'linewidth',LW)
fill(10+[2 2 2.5 2.5],[15 17 17 15],ColorBar2,'linestyle','none'); hold on
plot(10+[2 2.5],[16 16],'Color',ColorBar,'linewidth',LW)
fill(10+[8 8 7.5 7.5],[15 17 17 15],ColorBar2,'linestyle','none'); hold on
plot(10+[7.5 8],[16 16],'Color',ColorBar,'linewidth',LW)

% A B
plot([2.5 2.5 7.5 7.5 2.5],[12 19 19 12 12],'Color',ColorBar,'linewidth',LW); 
plot([12.5 12.5 17.5 17.5 12.5],[12 19 19 12 12],'Color',ColorBar,'linewidth',LW); 
text(1.5,18,'A','fontsize',FontSz,'color',ColorBar)
text(18,18,'B','fontsize',FontSz,'color',ColorBar)

% C D E F 
plot([1 1 3 3 1],[1 7 7 1 1],'Color',ColorBar,'linewidth',LW);
plot([6 6 9 9 6],[1 7 7 1 1],'Color',ColorBar,'linewidth',LW); 
plot(10+[1 1 3 3 1],[1 7 7 1 1],'Color',ColorBar,'linewidth',LW); 
plot(10+[6 6 9 9 6],[1 7 7 1 1],'Color',ColorBar,'linewidth',LW);
text(0.25,6,'C','fontsize',FontSz,'color',ColorBar)
text(9.25,6,'E','fontsize',FontSz,'color',ColorBar)
text(10.25,6,'D','fontsize',FontSz,'color',ColorBar)
text(19.25,6,'F','fontsize',FontSz,'color',ColorBar)

% Ligne AB
plot([7.5 12.5],[18 18],'Color',ColorBar,'linewidth',LW)
plot([7.5 12.5],[14 14],'Color',ColorBar,'linewidth',LW)
% Ligne AC AE
plot([2 2 2.5],[7 13 13],'Color',ColorBar,'linewidth',LW)
plot([8 8 7.5],[7 13 13],'Color',ColorBar,'linewidth',LW)
% Ligne BD BF
plot(10+[2 2 2.5],[7 13 13],'Color',ColorBar,'linewidth',LW)
plot(10+[8 8 7.5],[7 13 13],'Color',ColorBar,'linewidth',LW)
% Ligne CE DF
plot([3 6],[3 3],'Color',ColorBar,'linewidth',LW)
plot([3 6]+10,[3 3],'Color',ColorBar,'linewidth',LW)

% Affichage Niveau des Reservoirs
h_tNiv(1)=text(4.25,11,'2500','fontsize',FontSz,'color',ColorBar); %plot([4 4 6 6 4],[10.5 11.5 11.5 10.5 10.5],'k')
NIV(1)=2500;
h_tNiv(2)=text(14.25,11,'2500','fontsize',FontSz,'color',ColorBar); %plot(10+[4 4 6 6 4],[10.5 11.5 11.5 10.5 10.5],'k')
NIV(2)=2500;
h_tNiv(3)=text(3.25,5,'1000','fontsize',FontSz,'color',ColorBar); %plot([4 4 6 6 4],[10.5 11.5 11.5 10.5 10.5],'k')
NIV(3)=1000;
h_tNiv(4)=text(13.25,5,'1000','fontsize',FontSz,'color',ColorBar); %plot(10+[4 4 6 6 4],[10.5 11.5 11.5 10.5 10.5],'k')
NIV(4)=1000;

% Niveaux des Reservoirs
h_NIV(1)=fill([2.6 2.6 7.4 7.4],[12.1 16 16 12.1],[0 1 0],'linestyle','none');
h_NIV(2)=fill(10+[2.6 2.6 7.4 7.4],[12.1 16 16 12.1],[0 1 0],'linestyle','none');
h_NIV(3)=fill([1.1 1.1 2.9 2.9],[1.1 4 4 1.1],[0 1 0],'linestyle','none');
h_NIV(4)=fill([6.1 6.1 8.9 8.9],[1.1 6 6 1.1],[0 1 0],'linestyle','none');
h_NIV(5)=fill(10+[1.1 1.1 2.9 2.9],[1.1 4 4 1.1],[0 1 0],'linestyle','none');
h_NIV(6)=fill(10+[6.1 6.1 8.9 8.9],[1.1 6 6 1.1],[0 1 0],'linestyle','none');

faulty_pmp=zeros(8,1);
f=MATB_DATA.MainFigure;
[pmp]=Button_RESMAN(f);
% [pmp]=Button_RESMAN(MATB_DATA);

xlim([0 20]); ylim([0 20])
grid on
axis off

if MATB_DATA.Param.Retro
    set( get(gca,'children'), 'linewidth', 5)
    title('FUEL MANAGEMENT','fontsize',30,'color',ColorBar,'FontSmoothing','off');
else
    title('FUEL MANAGEMENT','fontsize',21,'color',ColorBar)
end

% FRP=[80 60 80 60 60 60 40 40 80 80]/6; % FlowRatesPompes Pompe 1 à 8 plus Vidage A et B
% MATB_DATA.RESMAN.FluxPompe=FRP;
MATB_DATA.RESMAN.handlePompe=pmp;
MATB_DATA.RESMAN.handleNiveau=h_NIV;
MATB_DATA.RESMAN.handleTextNiveau=h_tNiv;
MATB_DATA.RESMAN.EtatPompe=faulty_pmp;
MATB_DATA.RESMAN.NiveauxPompe=NIV;
MATB_DATA.RESMAN.HorsZone=[0 0];
    
