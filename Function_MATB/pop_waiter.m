function pop_waiter(text,secToWait,pos,postext)
% Pop a window with a message, wait for keyboard from user
% text = message displayed
% sec = minimum time the message will stay
% pos = where is the window relatively to the screen in px
% postext = where is the text in that window

if ~exist('secToWait')
    secToWait = 1;
end
if ~exist('pos')
    pos=[500   450   850   250];
end
if ~exist('postext')
    postext=[1 -100 850 250];
end

pop=dialog('position',pos);
uicontrol('Parent',pop,...
    'Style','text',...
    'HorizontalAlignment', 'center',...
    'Position', postext,...
    'String',text,...
    'Fontsize',18);
set(pop,'CloseRequestFcn',@CloseFigEmpty)

pause(secToWait)
set(pop,'WindowKeyPressFcn',@KeyRecup)


pressed = 0;
while true
    if pressed == 1
        break
    end
    pause(0.01)
end

    function KeyRecup(~,eventdata)
        if strcmp(eventdata.Key,'return')
            pressed = 1;
            delete(pop)
        end
    end
end

