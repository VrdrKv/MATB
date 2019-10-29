function pop_waiter(text,sec,pos,postext)
% Pop a window with a message, wait for keyboard from user
% text = message displayed
% sec = minimum time the message will stay
% pos = where is the window relatively to the screen in px
% postext = where is the text in that window

if ~exist('pos')
    pos=[500   450   850   250];
end
if ~exist('postext')
    postext=[1 -100 850 250];
end
    
pop=dialog('position',pos);
txt = uicontrol('Parent',pop,...
           'Style','text',...
           'HorizontalAlignment', 'center',...
           'Position', postext,...
           'String',text,...
           'Fontsize',18);

yesKeys = KbName('Return');
pause(sec)
drawnow
while true
    [~,~,keyCode] = KbCheck;
    if any(keyCode(yesKeys))
        break
    end
end

close(pop)

end

