function pop_waiter(text,sec)

pop=dialog('position',[500   450   850   250]);
txt = uicontrol('Parent',pop,...
           'Style','text',...
           'Position', [1 -100 850 250],...
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

