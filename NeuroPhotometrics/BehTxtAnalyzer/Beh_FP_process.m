clear
%--------------------------------------------------------------------------
Para.path = 'D:\Neurophotometrics\Ruifeng\08202024RC_RP100_FR1_Food_30Min_5sDelay\F227_F1213_F1214_F1257_F1259_M1260_M1261_M1263';
Para.BehStampName = 'Input1';%
Para.WindowLength = 250;
Para.ChamberIndx = [2,3]; % 
Para.Channels = ["415","470","560","None"];
Para.FiberNum = 8; 
Para.MinEventInterval = 500;% 5sec 
%--------------------------------------------------------------------------
Beh_txt.folderName = [Para.path,'\Behavior'];
Beh_txt.ReferenceEvent = 'RewardDelivery';
Beh_txt.Map_keys = {'A','B','H','I','Y'};
Beh_txt.Map_values = {'ActiveLP','InactiveLP','MagEnt','Licking','RewardDelivery'};
Beh_txt.StatisticList = {Beh_txt.ReferenceEvent;'ActiveLP';'MagEnt'};
Beh_txt.windowLength = 250;% 10sec * 25Hz
Beh_txt.isFR = [1,1]; 
Beh_txt.resolution = 25;
Beh_txt.FoodDeliveryDuration = 10; % UNIT:second
Beh_txt.Shift = 0;
%--------------------------------------------------------------------------
clc;close all
Beh_txt = txt2data(Beh_txt);
Beh_txt = csv_analyze(Beh_txt,Beh_txt);
%--------------------------------------------------------------------------
[FP,Para] = FP_Data_Process(Para);
%--------------------------------------------------------------------------
Beh = Beh_Data_Process(Para);
%--------------------------------------------------------------------------
FP.ComTime_sorted = (FP.ComTime - Beh.Events(1))/1000; % +Beh_txt.pivots.(['B_',Beh_txt.AnimalID{3}])(1);
FP.EventTime = {};
FP.Eventindx = {};
Para.ChamberIndx = zeros(size(Beh_txt.AnimalID));
for i = 1:length(Beh_txt.AnimalID)
    Para.ChamberIndx(i) = str2num(Beh_txt.AnimalID{i}(1));
    [FP.EventTime{i},FP.Eventindx{i}] = findNearest(FP.ComTime_sorted,Beh_txt.Data.(['B_',Beh_txt.AnimalID{i}]).(Beh_txt.ReferenceEvent));
end

FP = TimeWindow(Para,FP);
%--------------------------------------------------------------------------
% save data
save([Para.path,'\FP.mat'],'FP')
save([Para.path,'\Beh.mat'],'Beh')
save([Para.path,'\Para.mat'],'Para')
save([Para.path,'\Beh_txt.mat'],'Beh_txt')
%--------------------------------------------------------------------------