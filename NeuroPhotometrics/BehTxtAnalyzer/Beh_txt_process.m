clear
%--------------------------------------------------------------------------
Beh_txt.folderName = 'D:\Neurophotometrics\Ruifeng\04182024RC_FR1_Food_1hr\M62_M64_M66_M67\Behavior';
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
save([Beh_txt.folderName,'\Beh_txt.mat'],'Beh_txt')

summary = zeros(4,4);
for i = 1:length(Beh_txt.AnimalID)
    summary(i,1) = length(Beh_txt.Data.(['B_',Beh_txt.AnimalID{i}]).ActiveLP);
    summary(i,2) = length(Beh_txt.Data.(['B_',Beh_txt.AnimalID{i}]).InactiveLP);
    summary(i,3) = length(Beh_txt.Data.(['B_',Beh_txt.AnimalID{i}]).MagEnt);
    summary(i,4) = length(Beh_txt.Data.(['B_',Beh_txt.AnimalID{i}]).RewardDelivery);
end