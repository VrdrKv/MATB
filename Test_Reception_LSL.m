%% instantiate the library
disp('Loading the library...');
lib = lsl_loadlib();

% resolve a stream...
disp('Resolving an EEG stream...');
result = {};
while isempty(result)
    %result = lsl_resolve_all(lib);
    result = lsl_resolve_byprop(lib,'source_id','myID_Kvv');
end
% create a new inlet
disp('Opening an inlet...');
inlet = lsl_inlet(result{1});

i=1;
while true
    [sample{i},stamps] = inlet.pull_sample();
    if strcmp(sample{i}{2},'STOP')
        break
    end
    i=i+1;
end