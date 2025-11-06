% -------------------------------------------------------------------
% Ruifeng Chen
% sa15008146@tamu.edu
% March/21/2024
% -------------------------------------------------------------------
Para_Beh.folderName = 'F:\AG31L\Behavior';
Para_Beh.ReferenceEvent = 'Drinking Time';
Para_Beh.windowLength = 100;
Para_Beh.isFR = [2,1];
Para_Beh.resolution = 10;
Para_Beh.FoodDeliveryDuration = 10; % UNIT:second
Para_Beh.Shift = 0;
Para_Beh.StatisticList = {Para_Beh.ReferenceEvent;'MagEnt';'MagOut'};
% -------------------------------------------------------------------------
close all
% -------------------------------------------------------------------------
[Para_Beh.Behaviorfiles,Para_Beh.AnimalID] = readfiles(Para_Beh.folderName,'.csv');
Bh_csv = readcsv(Para_Beh);
Bh_csv = csv_analyze(Bh_csv,Para_Beh);
% -------------------------------------------------------------------------
Bh_csv = Beh_BnE(Bh_csv,Para_Beh,'MagEnt','MagOut');
% -------------------------------------------------------------------------
disp('---------------------------------------------------------------------------')
disp(Para_Beh)
disp('---------------------------------------------------------------------------')
% -------------------------------------------------------------------------
save([Para_Beh.folderName,'\Para_Beh.mat'],'Para_Beh')
save([Para_Beh.folderName,'\Bh_csv.mat'],'Bh_csv')