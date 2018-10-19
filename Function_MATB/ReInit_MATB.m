function [MATB_DATA]=ReInit_MATB(MATB_DATA)

ColorBar=[0 0.4470 0.7410];

% RESMAN
MATB_DATA.RESMAN.NiveauxPompe(1)=2500;
MATB_DATA.RESMAN.NiveauxPompe(2)=2500;
MATB_DATA.RESMAN.NiveauxPompe(3)=1000;
MATB_DATA.RESMAN.NiveauxPompe(4)=1000;

set(MATB_DATA.RESMAN.handleTextNiveau(1),'String',num2str(MATB_DATA.RESMAN.NiveauxPompe(1)))
set(MATB_DATA.RESMAN.handleTextNiveau(2),'String',num2str(MATB_DATA.RESMAN.NiveauxPompe(2)))
set(MATB_DATA.RESMAN.handleTextNiveau(3),'String',num2str(MATB_DATA.RESMAN.NiveauxPompe(3)))
set(MATB_DATA.RESMAN.handleTextNiveau(4),'String',num2str(MATB_DATA.RESMAN.NiveauxPompe(4)))

set(MATB_DATA.RESMAN.handleTextNiveau(1),'Color',ColorBar)
set(MATB_DATA.RESMAN.handleTextNiveau(2),'Color',ColorBar)

Lev(1)=MATB_DATA.RESMAN.NiveauxPompe(1)*(3.9/2500)+12.1; set(MATB_DATA.RESMAN.handleNiveau(1),'YData',[12.1 Lev(1) Lev(1) 12.1])
Lev(2)=MATB_DATA.RESMAN.NiveauxPompe(2)*(3.9/2500)+12.1; set(MATB_DATA.RESMAN.handleNiveau(2),'YData',[12.1 Lev(2) Lev(2) 12.1])
Lev(3)=MATB_DATA.RESMAN.NiveauxPompe(3)*(2.9/1000)+1.1; set(MATB_DATA.RESMAN.handleNiveau(3),'YData',[1.1 Lev(3) Lev(3) 1.1])
Lev(4)=MATB_DATA.RESMAN.NiveauxPompe(4)*(2.9/1000)+1.1; set(MATB_DATA.RESMAN.handleNiveau(5),'YData',[1.1 Lev(4) Lev(4) 1.1])

set(MATB_DATA.RESMAN.handlePompe,'backgroundcolor',[.94 .94 .94]);
MATB_DATA.RESMAN.EtatPompe=zeros(8,1);
% TRACK
h=MATB_DATA.TRACK.handleCible;
circle(0,0,h);

% SYSMON
MATB_DATA.SYSMON.EtatAlarm=zeros(6,2);