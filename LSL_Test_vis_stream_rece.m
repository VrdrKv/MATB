clear; close all
cd 'D:\k.verdiere\Documents\EXPE_NCC\Script\MATB\MATB_HomeMade_New'

tmax=10;
Nchan=64; rangeChan=2:65;  Fs=512; BuffSize=Fs*tmax;
filtre=[1 30];
%% instantiate the library
disp('Loading the library...');
lib = lsl_loadlib();

% resolve a stream...
disp('Resolving...');
result = {};
while isempty(result)
    result = lsl_resolve_byprop(lib,'type','EEG');
end
disp(['Opening ' num2str(size(result,2)) ' EEG...']);
inlet{1} = lsl_inlet(result{1});
inlet{2} = lsl_inlet(result{2});
% result = {};
% while isempty(result)
%     result = lsl_resolve_byprop(lib,'name','Kev2');
% end
% disp('Opening Kev2...');
% inlet{2} = lsl_inlet(result{1});

%% Init Chunk
for i=1:2
    [chunk,stamps] = inlet{i}.pull_chunk();
    if size(chunk,2) > BuffSize
        data{i}=chunk(rangeChan,end-BuffSize+1:end);
    else
        data{i}=zeros(Nchan,BuffSize); data{i}(:,end-size(chunk,2)+1:end)=chunk(rangeChan,:);
    end
end
% data{1}=rand(Nchan,BuffSize);
% data{2}=rand(Nchan,BuffSize);
% Plot Signaux
offset=50; offset_vec=0:offset:offset*(Nchan-1);
offset_mat=repmat(offset_vec,BuffSize,1);

figure;
for i=1:2
    ax(i)=subplot(1,2,i);
    p{i}.data=plot((data{i}+offset_mat')'); grid on
    %     set(gca,'ytick',[]);
    % set(gca,'ytick',Offset,'yticklabel',NameElec);xlabel('Time')
    set(gca,'ylim',[offset_vec(1) offset_vec(end)+offset])
    title('EEG Signal')
    xlabel('Time')
end


filtorder = 10;
filtwts = fir1(filtorder, filtre./(Fs/2));
XLMax=BuffSize
%%
KbName('UnifyKeyNames');
deviceIndex=[];
KbQueueCreate(deviceIndex);
KbQueueStart(deviceIndex);
ListenChar(-1)

while(1)
    for i=1:2
        % Load Chunk
        [chunk,stamps] = inlet{i}.pull_chunk();
        SC=size(chunk,2);
        
        [ keyIsDown, firstPress]=KbQueueCheck([]);
        if keyIsDown
            KeyName=KbName(find(firstPress,1));
            if any(strcmp(KeyName,{'-','+'}))
                offset=offset * sum(strcmp(KeyName,{'-','+'}) .* [0.9 1.1]);
            end
            if any(strcmp(KeyName,{'/','*'}))
                XLMax=XLMax * sum(strcmp(KeyName,{'/','*'}) .* [0.9 1.1]);
            end
            
        end
        
        
        offset_vec=0:offset:offset*(Nchan-1);
        offset_mat=repmat(offset_vec,BuffSize,1);
        
        if SC < BuffSize && SC > 0
            data{i}(:,1:end-SC) = data{i}(:,SC+1:end);
            data{i}(:,end-SC+1:end)=chunk(rangeChan,:);
            
        elseif SC > BuffSize
            data{i}=chunk(rangeChan,end-BuffSize+1:end);
        end
        
        filt_data=data{i} - repmat(mean(data{i},2),1,size(data{i},2));
        %         for c=1:Nchan
        %             filt_data(c,:) = filtfilt(filtwts,1,filt_data(c,:));
        %         end
        filt_data = filtfilt(filtwts,1,filt_data);
        %         filt_data=data{i};
        
        
        filt_data=filt_data+offset_mat';
        for j=1:Nchan
            p{i}.data(j).YData=filt_data(j,:);
            %             pdata(j).XData=(1:BuffSize)./Fs;
        end
        
        % pause(0.1)
        set(ax(i),'ylim',[offset_vec(1) offset_vec(end)+offset],'xlim',[0 XLMax]);
        set(ax(i),'xticklabel',num2str(round(get(gca,'xtick')/Fs,2)'))
    end
    drawnow
end

ListenChar(0)
KbQueueStop