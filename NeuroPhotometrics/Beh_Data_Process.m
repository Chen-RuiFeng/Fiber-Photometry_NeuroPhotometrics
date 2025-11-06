%Beh_Data_Process
function Beh = Beh_Data_Process(Para)

Para.BhfileName = dir([Para.path,'\Laser','*.csv']);
Beh.Raw= readtable([Para.path,'\',Para.BhfileName.name]);
try
    Beh.Events = Beh.Raw.Var5(cellfun(@(x) isequal(x,Para.BehStampName),Beh.Raw.Var1));

catch
    Beh.Events = Beh.Raw.ComputerTimestamp(cellfun(@(x) isequal(x,Para.BehStampName),Beh.Raw.DigitalIOName));
end

Beh.Events = [Beh.Events(1);Beh.Events(find(diff(Beh.Events)>Para.MinEventInterval)+1)];

if length(Beh.Events)> 1
    Beh.Pauses = diff(find(diff(Beh.Events)>Para.MinEventInterval));
    if ~isempty(Beh.Pauses)
        Beh.Pauses = [Beh.Pauses(1);Beh.Pauses;Beh.Pauses(end)]/2;
    end
end