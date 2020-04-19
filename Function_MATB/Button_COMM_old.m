function r=Button_COMM(MATB_DATA)

f=MATB_DATA.MainFigure;
% FigPos=get(f,'position');
% LargeurFig=FigPos(3);
% HauteurFig=FigPos(4);
LargeurFig=1100;
HauteurFig=1450;

ColorBar=[0 0.4470 0.7410];

% BUTTON PLUS & MINUS !!!!!Ne pas déplacer/Laisser avant bs!!!!! -- AL
plus_n1_b = uicontrol(f,'Style','pushbutton','String','+','visible','on',...
    'Position',[LargeurFig*.17 HauteurFig*.255 20 20],'Fontsize',16,'Callback', @plus_n1);
moins_n1_b = uicontrol(f,'Style','pushbutton','String','-','visible','on',...
    'Position',[LargeurFig*.17 HauteurFig*.24 20 20],'Fontsize',16,'Callback', @moins_n1);
plus_n1d_b = uicontrol(f,'Style','pushbutton','String','+','visible','on',...
    'Position',[LargeurFig*.29 HauteurFig*.255 20 20],'Fontsize',16,'Callback', @plus_n1d);
moins_n1d_b = uicontrol(f,'Style','pushbutton','String','-','visible','on',...
    'Position',[LargeurFig*.29 HauteurFig*.24 20 20],'Fontsize',16,'Callback', @moins_n1d);

plus_n2_b = uicontrol(f,'Style','pushbutton','String','+','visible','off',...
    'Position',[LargeurFig*.17 HauteurFig*.205 20 20],'Fontsize',16,'Callback', @plus_n2);
moins_n2_b = uicontrol(f,'Style','pushbutton','String','-','visible','off',...
    'Position',[LargeurFig*.17 HauteurFig*.19 20 20],'Fontsize',16,'Callback', @moins_n2);
plus_n2d_b = uicontrol(f,'Style','pushbutton','String','+','visible','off',...
    'Position',[LargeurFig*.29 HauteurFig*.205 20 20],'Fontsize',16,'Callback', @plus_n2d);
moins_n2d_b = uicontrol(f,'Style','pushbutton','String','-','visible','off',...
    'Position',[LargeurFig*.29 HauteurFig*.19 20 20],'Fontsize',16,'Callback', @moins_n2d);

plus_c1_b = uicontrol(f,'Style','pushbutton','String','+','visible','off',...
    'Position',[LargeurFig*.17 HauteurFig*.155 20 20],'Fontsize',16,'Callback', @plus_c1);
moins_c1_b = uicontrol(f,'Style','pushbutton','String','-','visible','off',...
    'Position',[LargeurFig*.17 HauteurFig*.14 20 20],'Fontsize',16,'Callback', @moins_c1);
plus_c1d_b = uicontrol(f,'Style','pushbutton','String','+','visible','off',...
    'Position',[LargeurFig*.29 HauteurFig*.155 20 20],'Fontsize',16,'Callback', @plus_c1d);
moins_c1d_b = uicontrol(f,'Style','pushbutton','String','-','visible','off',...
    'Position',[LargeurFig*.29 HauteurFig*.14 20 20],'Fontsize',16,'Callback', @moins_c1d);

plus_c2_b = uicontrol(f,'Style','pushbutton','String','+','visible','off',...
    'Position',[LargeurFig*.17 HauteurFig*.105 20 20],'Fontsize',16,'Callback', @plus_c2);
moins_c2_b = uicontrol(f,'Style','pushbutton','String','-','visible','off',...
    'Position',[LargeurFig*.17 HauteurFig*.09 20 20],'Fontsize',16,'Callback', @moins_c2);
plus_c2d_b = uicontrol(f,'Style','pushbutton','String','+','visible','off',...
    'Position',[LargeurFig*.29 HauteurFig*.105 20 20],'Fontsize',16,'Callback', @plus_c2d);
moins_c2d_b = uicontrol(f,'Style','pushbutton','String','-','visible','off',...
    'Position',[LargeurFig*.29 HauteurFig*.09 20 20],'Fontsize',16,'Callback', @moins_c2d);


% RADIO BUTTONS
% bs = uibuttongroup('Visible','off',...
%     'Position',[.05 .1 .11 .3],...
%     'SelectionChangedFcn',@bselection);
bs = uibuttongroup('Visible','off',... %------------ pour affichage simu
    'Position',[.05 .18 .25 .55],...
    'SelectionChangedFcn',@bselection);

r(1) = uicontrol(bs,'Style',...
    'radiobutton',...
    'String','NAV1',...
    'Position',[10 260 100 30],...
    'ForegroundColor',ColorBar,...
    'HandleVisibility','on',...
    'Value',0,...
    'Fontsize',19);

r(2) = uicontrol(bs,'Style','radiobutton',...
    'String','NAV2',...
    'Position',[10 185 100 30],...
    'ForegroundColor',ColorBar,...
    'HandleVisibility','on',...
    'Value',0,...
    'Fontsize',19);

r(3) = uicontrol(bs,'Style','radiobutton',...
    'String','COM1',...
    'Position',[10 110 100 30],...
    'ForegroundColor',ColorBar,...
    'HandleVisibility','on',...
    'Value',0,...
    'Fontsize',19);

r(4) = uicontrol(bs,'Style','radiobutton',...
    'String','COM2',...
    'Position',[10 35 100 30],...
    'ForegroundColor',ColorBar,...
    'HandleVisibility','on',...
    'Value',0,...
    'Fontsize',19);
bs.Visible = 'on';
bs.HandleVisibility = 'on';

uicontrol('Style','text',...
    'Position',[125 490 250 40],...
    'String','CALL SIGN : NASA 504',...
    'Fontsize',15,...
    'Foregroundcolor',ColorBar);


% TEXT for NAV & COM
n1 = uicontrol('Style','text',...
    'Position',[LargeurFig*.19 HauteurFig*.24 50 40],...
    'String','112',...
    'Fontsize',19,...
    'Foregroundcolor',ColorBar);
n1d = uicontrol('Style','text',...
    'Position',[LargeurFig*.24 HauteurFig*.24 50 40],...
    'String','500',...
    'Fontsize',19,...
    'Foregroundcolor',ColorBar);
n2 = uicontrol('Style','text',...
    'Position',[LargeurFig*.19 HauteurFig*.19 50 40],...
    'String','112',...
    'Fontsize',19,...
    'Foregroundcolor',ColorBar);
n2d = uicontrol('Style','text',...
    'Position',[LargeurFig*.24 HauteurFig*.19 50 40],...
    'String','500',...
    'Fontsize',19,...
    'Foregroundcolor',ColorBar);

c1 = uicontrol('Style','text',...
    'Position',[LargeurFig*.19 HauteurFig*.14 50 40],...
    'String','126',...
    'Fontsize',19,...
    'Foregroundcolor',ColorBar);
c1d = uicontrol('Style','text',...
    'Position',[LargeurFig*.24 HauteurFig*.14 50 40],...
    'String','500',...
    'Fontsize',19,...
    'Foregroundcolor',ColorBar);

c2 = uicontrol('Style','text',...
    'Position',[LargeurFig*.19 HauteurFig*.09 50 40],...
    'String','126',...
    'Fontsize',19,...
    'Foregroundcolor',ColorBar);
c2d = uicontrol('Style','text',...
    'Position',[LargeurFig*.24 HauteurFig*.09 50 40],...
    'String','500',...
    'Fontsize',19,...
    'Foregroundcolor',ColorBar);

apply_b = uicontrol(f,'Style','pushbutton','String','APPLY','Fontsize',19,...
    'Foregroundcolor',ColorBar,...
    'Position',[LargeurFig*.19 HauteurFig*.04 100 40],'Callback', @apply);

% FUNCTION CONTROL
    function apply(source,callbackdata)
        set(r,'Value',0)
        r(1).Value = 1; % Modifie AL
        set(plus_n1_b,'Visible','on');set(moins_n1_b,'Visible','on')
        set(plus_n1d_b,'Visible','on');set(moins_n1d_b,'Visible','on')
        set(plus_n2_b,'Visible','off');set(moins_n2_b,'Visible','off')
        set(plus_n2d_b,'Visible','off');set(moins_n2d_b,'Visible','off')
        set(plus_c1_b,'Visible','off');set(moins_c1_b,'Visible','off')
        set(plus_c1d_b,'Visible','off');set(moins_c1d_b,'Visible','off')
        set(plus_c2_b,'Visible','off');set(moins_c2_b,'Visible','off')
        set(plus_c2d_b,'Visible','off');set(moins_c2d_b,'Visible','off')

        send_log('COMM APPLY',['  NAV1:' get(n1, 'String') '.' get(n1d, 'String') ,...
            '  NAV2:' get(n2, 'String') '.' get(n2d, 'String') ,...
            '  COM1:' get(c1, 'String') '.' get(c1d, 'String') ,...
            '  COM2:' get(c2, 'String') '.' get(c2d, 'String')]);
        
        Value=cat(2, str2num(get(n1,'String')) + 0.001*str2num(get(n1d,'String')),...
            str2num(get(n2,'String')) + 0.001*str2num(get(n2d,'String')),...
            str2num(get(c1,'String')) + 0.001*str2num(get(c1d,'String')),...
            str2num(get(c2,'String')) + 0.001*str2num(get(c2d,'String')) );

        send_comm(Value)
        
        % Data=MATB_DATA.COMM.DATA{MATB_DATA.ScenarioNumber};
        % Data = Data(end-2:end,:)
        % suite du code perf comm
 %---------------------------------------------------------------------------       
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
        
%-----------------------------------------------------------------------------               
        end
    
    function bselection(source,callbackdata)
        if strcmp(callbackdata.NewValue.String,'NAV1')
            set(plus_n1_b,'Visible','on');set(moins_n1_b,'Visible','on')
            set(plus_n1d_b,'Visible','on');set(moins_n1d_b,'Visible','on')
            set(plus_n2_b,'Visible','off');set(moins_n2_b,'Visible','off')
            set(plus_n2d_b,'Visible','off');set(moins_n2d_b,'Visible','off')
            set(plus_c1_b,'Visible','off');set(moins_c1_b,'Visible','off')
            set(plus_c1d_b,'Visible','off');set(moins_c1d_b,'Visible','off')
            set(plus_c2_b,'Visible','off');set(moins_c2_b,'Visible','off')
            set(plus_c2d_b,'Visible','off');set(moins_c2d_b,'Visible','off')
        end
        if strcmp(callbackdata.NewValue.String,'NAV2')
            set(plus_n1_b,'Visible','off');set(moins_n1_b,'Visible','off')
            set(plus_n1d_b,'Visible','off');set(moins_n1d_b,'Visible','off')
            set(plus_n2_b,'Visible','on');set(moins_n2_b,'Visible','on')
            set(plus_n2d_b,'Visible','on');set(moins_n2d_b,'Visible','on')
            set(plus_c1_b,'Visible','off');set(moins_c1_b,'Visible','off')
            set(plus_c1d_b,'Visible','off');set(moins_c1d_b,'Visible','off')
            set(plus_c2_b,'Visible','off');set(moins_c2_b,'Visible','off')
            set(plus_c2d_b,'Visible','off');set(moins_c2d_b,'Visible','off')
        end
        if strcmp(callbackdata.NewValue.String,'COM1')
            set(plus_n1_b,'Visible','off');set(moins_n1_b,'Visible','off')
            set(plus_n1d_b,'Visible','off');set(moins_n1d_b,'Visible','off')
            set(plus_n2_b,'Visible','off');set(moins_n2_b,'Visible','off')
            set(plus_n2d_b,'Visible','off');set(moins_n2d_b,'Visible','off')
            set(plus_c1_b,'Visible','on');set(moins_c1_b,'Visible','on')
            set(plus_c1d_b,'Visible','on');set(moins_c1d_b,'Visible','on')
            set(plus_c2_b,'Visible','off');set(moins_c2_b,'Visible','off')
            set(plus_c2d_b,'Visible','off');set(moins_c2d_b,'Visible','off')
        end
        if strcmp(callbackdata.NewValue.String,'COM2')
            set(plus_n1_b,'Visible','off');set(moins_n1_b,'Visible','off')
            set(plus_n1d_b,'Visible','off');set(moins_n1d_b,'Visible','off')
            set(plus_n2_b,'Visible','off');set(moins_n2_b,'Visible','off')
            set(plus_n2d_b,'Visible','off');set(moins_n2d_b,'Visible','off')
            set(plus_c1_b,'Visible','off');set(moins_c1_b,'Visible','off')
            set(plus_c1d_b,'Visible','off');set(moins_c1d_b,'Visible','off')
            set(plus_c2_b,'Visible','on');set(moins_c2_b,'Visible','on')
            set(plus_c2d_b,'Visible','on');set(moins_c2d_b,'Visible','on')
        end
        
    end
% PLUS NAV
    function plus_n1(source,callbackdata)
        value=str2num(get(n1, 'String'));
        set(n1, 'String', num2str(value+1));
    end
    function plus_n1d(source,callbackdata)
        value=str2num(get(n1d, 'String'));
        set(n1d, 'String', num2str(value+25));
    end
    function plus_n2(source,callbackdata)
        value=str2num(get(n2, 'String'));
        set(n2, 'String', num2str(value+1));
    end
    function plus_n2d(source,callbackdata)
        value=str2num(get(n2d, 'String'));
        set(n2d, 'String', num2str(value+25));
    end
% PLUS COMM
    function plus_c1(source,callbackdata)
        value=str2num(get(c1, 'String'));
        set(c1, 'String', num2str(value+1));
    end
    function plus_c1d(source,callbackdata)
        value=str2num(get(c1d, 'String'));
        set(c1d, 'String', num2str(value+25));
    end
    function plus_c2(source,callbackdata)
        value=str2num(get(c2, 'String'));
        set(c2, 'String', num2str(value+1));
    end
    function plus_c2d(source,callbackdata)
        value=str2num(get(c2d, 'String'));
        set(c2d, 'String', num2str(value+25));
    end
% MOINS NAV
    function moins_n1(source,callbackdata)
        value=str2num(get(n1, 'String'));
        set(n1, 'String', num2str(value-1));
    end
    function moins_n1d(source,callbackdata)
        value=str2num(get(n1d, 'String'));
        set(n1d, 'String', num2str(value-25));
    end
    function moins_n2(source,callbackdata)
        value=str2num(get(n2, 'String'));
        set(n2, 'String', num2str(value-1));
    end
    function moins_n2d(source,callbackdata)
        value=str2num(get(n2d, 'String'));
        set(n2d, 'String', num2str(value-25));
    end
% MOINS COMM
    function moins_c1(source,callbackdata)
        value=str2num(get(c1, 'String'));
        set(c1, 'String', num2str(value-1));
    end
    function moins_c1d(source,callbackdata)
        value=str2num(get(c1d, 'String'));
        set(c1d, 'String', num2str(value-25));
    end
    function moins_c2(source,callbackdata)
        value=str2num(get(c2, 'String'));
        set(c2, 'String', num2str(value-1));
    end
    function moins_c2d(source,callbackdata)
        value=str2num(get(c2d, 'String'));
        set(c2d, 'String', num2str(value-25));
    end

end
end