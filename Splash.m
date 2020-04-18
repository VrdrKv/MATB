% SPLASH
% global MATB_DATA
clc

% Bas         = 0;
% Haut        = 1;
% Epaisseur   = 1;
% DecHori     = [0 1];
% X           = cat(2,DecHori,fliplr(DecHori+Epaisseur));
% Y           = [Bas Haut Haut Bas];

MainFig = figure('visible','off');
set(MainFig,'Color',[0 0 0],'WindowState','fullscreen','toolbar','none','menubar','none')

subplot('position',[0 0 1 1])
axis square
grid on; hold on
Color = [153 50 204]/256;

%-------  LOGO ISAE  ------------
% [img, map, alphachannel] = imread('LOGO.png');
% img             = flipud(img(10:end,1:675,:));
% alphachannel    = flipud(alphachannel(10:end,1:675,:));
% img             = imresize(img,0.5);
% alphachannel    = imresize(alphachannel,0.5);
% image(2600, 2700,img, 'AlphaData',alphachannel);
% 
% set(gca,'YDir','normal')
set(gca,'color','k')

XL = [0 1000]  ; xlim(XL); 
YL = [0 1000]  ; ylim(YL);

%-------   BACK GROUND LINE  ------------
Conv(1) = 1000; % X  (XL(2)-XL(1))/2;
Conv(2) = 1000; % Y
N_Ligne = 20;
Xligne=[ linspace(-0.5*XL(2),1.8*XL(2),N_Ligne) ; repmat(Conv(1),1,N_Ligne) ;  nan(1,N_Ligne)];
Yligne=[ repmat(-1,1,N_Ligne) ; repmat(Conv(2),1,N_Ligne) ; nan(1,N_Ligne)];
p=plot(Xligne(:),Yligne(:),'w');

%------- TEXT  ------------
x=500; y=500; hold on
r=20;
ColorTrack = [250,178,11]/256;
th = 0:pi/50:2*pi;
xunit = r * cos(th) + x;
yunit = r * sin(th) + y;
h_cr=plot(xunit, yunit,'Color',ColorTrack,'linewidth',5);
h_cx=plot(x,y,'o','Color',ColorTrack,'linewidth',1,'markerfacecolor',ColorTrack);
h_l1=plot([x x],[y+r y+r/3],'Color',ColorTrack,'linewidth',5);
h_l2=plot([x x],[y-r y-r/3],'Color',ColorTrack,'linewidth',5);
h_l3=plot([x+r x+r/3],[y y],'Color',ColorTrack,'linewidth',5);
h_l4=plot([x-r x-r/3],[y y],'Color',ColorTrack,'linewidth',5);
h_cible=[h_cr,h_cx,h_l1,h_l2,h_l3,h_l4];

%------- TEXT  ------------
tMATB = text(mean(XL),mean(YL),'MATB II','fontname','ArcadeClassic',...
    'fontunits','centimeters','fontsize',10,'Color',Color, 'HorizontalAlignment', 'Center');

text( 150, 900,  'ISAE SUPAERO', ...
    'FontSize', 35, 'Color',  [0,173,239]/256, 'HorizontalAlignment', 'Center','fontname','ArcadeClassic' );

%%
%-------   AUDIO   ------------
InitializePsychSound 
pahandle = PsychPortAudio('Open',[],[],0,[],2);

[Sound,Fs] = audioread(['Audio/GeneriqueMATB.wav']);
FichierGenerique=resample(Sound,44100,Fs);

PsychPortAudio('FillBuffer', pahandle, FichierGenerique')

pause(.5)
PsychPortAudio('Start', pahandle,1,0,1);


axis off
set(MainFig,'visible','on')
yesKeys = KbName('space');

%-------   ANIM  ------------
N_Step = 300;

TrajetX         = [linspace(1100,800,100), linspace(800,200,100), linspace(200,800,100)];
TrajetY         = [linspace(0,1100,100), repmat(1100,1,200)];
FtSz            = linspace(1,10,N_Step);  
% TextPos = % Move MAT

th = linspace(3*pi/2,-pi/2,N_Step);
r = linspace(500,0,N_Step);
xunit = r .* cos(th) + x;
yunit = r .* sin(th) + y; 
rayonCible = [linspace(20,200,N_Step-40) linspace(200,1000,40)];

lastUpdate = datetime;
UpdateI = 1;
while true 
    if seconds(datetime - lastUpdate) > 0.02 && UpdateI <= N_Step
        Conv(1) = TrajetX(UpdateI); % X
        Conv(2) = TrajetY(UpdateI); % Y
        Xligne=[ linspace(-0.5*XL(2),1.8*XL(2),N_Ligne) ; repmat(Conv(1),1,N_Ligne) ;  nan(1,N_Ligne)];
        Yligne=[ repmat(-1,1,N_Ligne) ; repmat(Conv(2),1,N_Ligne) ; nan(1,N_Ligne)];
        
        tMATB.FontSize = round(FtSz(UpdateI));
        p.XData = Xligne(:);
        p.YData = Yligne(:);
        
        circle_splash(xunit(UpdateI),yunit(UpdateI),h_cible,rayonCible(UpdateI))
        
        UpdateI = UpdateI + 1;
        lastUpdate = datetime;
        drawnow
    end
    
    if UpdateI > N_Step
        delete(h_cible)
        break
    end 
        
    [~,~,keyCode] = KbCheck; 
    if any(keyCode(yesKeys))
        break
    end
end

enterText = text( mean(XL), 0.1*(YL(2)-YL(1)),  'PRESS SPACE TO CONTINUE', ...
    'FontSize', 30, 'Color', 'w', 'HorizontalAlignment', 'Center','fontname','ArcadeClassic' );



%-------   INTERACTIVITY SPACE BAR ------------
LastUpdate = datetime;
while true
    if seconds( datetime - lastUpdate) > 0.5
        if strcmp(enterText.Visible,'on')
            enterText.Visible = 'off';
        else
            enterText.Visible = 'on';
        end
        lastUpdate = datetime;
        drawnow
    end
    
    [~,~,keyCode] = KbCheck;
    if any(keyCode(yesKeys))
        break
    end
end

close(MainFig)
PsychPortAudio('Stop', pahandle);



%% DEPRE
%------------------------------------------------------------------------
% %----- M ------
% f(1)=fill([0 + X],Y,Color);
% f(2)=fill([3 + X],Y,Color);
% 
% EpBar=0.2;
% f(3)=fill([1 3 3 2],1 - [EpBar 2*EpBar EpBar 0],Color);
% f(4)=fill([3 4 4 3],1 - [2*EpBar EpBar 0 EpBar],Color);
% 
% %----- A -----
% f(5)=fill([5 + X],Y,Color);
% f(6)=fill([9 8.5 9.5 10],Y,Color);
% 
% f(7)=fill([6 9 9 6],[.85 .85  1  1 ],Color);
% f(8)=fill([6 9 9 6],[.6 .6  .75 .75],Color);
% 
% %----- T -----
% f(9)=fill([11 + X],Y,Color);
% f(10)=fill([10 10 15 15],[.9 1 1 .9],Color);
% 
% %----- B -----
% f(11)=fill([15 + X],Y,Color);
% 
% f(12)=fill([15 20 20.75 16 15.5 19 18.6 15.5],[0 0 .5 .5 .35 .35 .15 .15],Color);
% f(13)=fill([16 17 17.3 16],[0.15 0.15 0.35 0.35],Color);
% 
% % fill([15 20 20.75 16 15.5 19 18.6 15.5]+0.75,[0 0 .5 .5 .35 .35 .15 .15]+0.5,'k')
% % fill([16 17 17.3 16]+0.6,[0.15 0.15 0.35 0.35]+0.5,'k')
% 
% %----- II -----
% f(14)=fill([21.5 + X],Y,Color);
% f(15)=fill([23 + X],Y,Color);
% 
% set(f,'linestyle','none')
%------------------------------------------------------------------------


function circle_splash(x,y,h,r)
th = 0:pi/50:2*pi;
xunit = r * cos(th) + x;
yunit = r * sin(th) + y;
h(1).XData=xunit; h(1).YData=yunit;
h(2).XData=x; h(2).YData=y;

h(4).XData=[x x]; h(4).YData=[y-r y-r/3];
h(3).XData=[x x]; h(3).YData=[y+r y+r/3];
h(5).XData=[x+r x+r/3]; h(5).YData=[y y];
h(6).XData=[x-r x-r/3]; h(6).YData=[y y];
end
