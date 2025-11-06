% fileCheck
function [Behaviorfiles,Fiberphofiles] = fileCheck(folderName)
filefolds = readfiles(folderName,'');
BehaviorFolder = [];
FiberphoFolder = [];
for i = 1:length(filefolds)
    if ~isempty(strfind(filefolds{i},'Beh'))
        BehaviorFolder = filefolds{i};
    elseif ~isempty(strfind(filefolds{i},'Fib'))
        FiberphoFolder = filefolds{i};
    end
end

if isempty(BehaviorFolder)
    error('Behavior folder was not found.')
end

if isempty(BehaviorFolder)
    error('Behavior folder was not found.')
end

Behaviorfiles = readfiles([folderName,'\',BehaviorFolder],'.csv');
Fiberphofiles = readfiles([folderName,'\',FiberphoFolder],'.txt');

if isempty(Behaviorfiles)||isempty(Fiberphofiles)
    error('Warning: There is no Fiber photometry file or Behavior file')
end

if length(Behaviorfiles)>length(Fiberphofiles)
    disp('-------------------------------------------------------------' )
    disp('Warning: one or more Fiber photometry files were missed!')
    disp('-------------------------------------------------------------' )
end 

if length(Behaviorfiles)<length(Fiberphofiles)
    disp('-------------------------------------------------------------' )
    disp('Warning: one or more Behavior files were missed!')
    disp('-------------------------------------------------------------' )
end 

for i = 1:length(Behaviorfiles)
    Behaviorfiles{i} = [BehaviorFolder,'\',Behaviorfiles{i}];
end

for i = 1:length(Fiberphofiles)
    Fiberphofiles{i} = [FiberphoFolder,'\',Fiberphofiles{i}];
end
