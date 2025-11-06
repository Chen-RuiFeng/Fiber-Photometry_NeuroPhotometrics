% -------------------------------------------------------------------------
% Ruifeng Chen
% sa15008146@tamu.edu
% March/21/2024
% -------------------------------------------------------------------------
Para_Beh.path = 'F:\AG31L\Behavior';
Para_Beh.folderName = 'F:\AG31L\Behavior';
Para_Beh.ReferenceEvent = 'Drinking Time';
Para_Beh.WindowLength = 250;
Para_Beh.windowLength = 250;
Para_Beh.isFR = [2,1];
Para_Beh.resolution = 10;
Para_Beh.FoodDeliveryDuration = 10; % UNIT:second
Para_Beh.Shift = 0;
Para_Beh.StatisticList = {Para_Beh.ReferenceEvent;'MagEnt';'MagOut'};
Para_Beh.ChamberIndx = [2];
% -------------------------------------------------------------------------
close all
% -------------------------------------------------------------------------
[Para_Beh.Behaviorfiles,Para_Beh.AnimalID] = readfiles(Para_Beh.path,'.csv');
Bh_csv = readcsv(Para_Beh);
Bh_csv = csv_analyze(Bh_csv,Para_Beh);
% -------------------------------------------------------------------------
Bh_csv = Beh_BnE(Bh_csv,Para_Beh,'MagEnt','MagOut');
% -------------------------------------------------------------------------
disp('--------------------------------------------------------------------------')
disp(Para_Beh)
disp('--------------------------------------------------------------------------')
% -------------------------------------------------------------------------
save([Para_Beh.path,'\Para_Beh.mat'],'Para_Beh')
save([Para_Beh.path,'\Bh_csv.mat'],'Bh_csv')


%--------------------------------------------------------------------------
Para.path = 'F:\AG31L';
Para.BehStampName = 'Output1';%
Para.WindowLength = 250;
Para.ChamberIndx = [2]; % 
Para.Channels = ["415","470","560","None"];
Para.FiberNum = 8; 
Para.MinEventInterval = 500;% 5sec 
%--------------------------------------------------------------------------
clc;close all
%--------------------------------------------------------------------------
[FP,Para] = FP_Data_Process(Para);
%--------------------------------------------------------------------------
Beh = Beh_Data_Process(Para);
%--------------------------------------------------------------------------
[FP.EventTime,FP.Eventindx{1}] = findNearest(FP.ComTime,Beh.Events);
figure
set(gcf, 'Position', get(0, 'Screensize'));
for ii = 1:length(Para.ChamberIndx)
    nexttile
    plot(FP.L415(:,Para.ChamberIndx(ii)),'m')
    hold on
    plot(FP.L470(:,Para.ChamberIndx(ii)),'g')
    try
        xline(FP.Eventindx{ii})
    catch
        FP.Eventindx{ii} = FP.Eventindx{1};
        xline(FP.Eventindx{ii})
    end
    legend('415nm LED','470nm LED','TTL')
    nexttile
    plot(FP.L560(:,Para.ChamberIndx(ii)),'r')
end
saveas(gca,[Para.path,'\raw.jpg'])
%--------------------------------------------------------------------------
FP.ComTime_sorted = (FP.ComTime - FP.EventTime(1))/1000;
FP.EventTime = {};
FP.Eventindx = {};
[FP.EventTime{2},FP.Eventindx{2}] = findNearest(FP.ComTime_sorted,Beh_csv.pivots.(['B_',Beh_txt.AnimalID{i}]).(Beh_txt.ReferenceEvent));
% get the time window of each event.
    FP = TimeWindow(Para_Beh,FP);
%--------------------------------------------------------------------------
save data
save([Para.path,'\Beh.mat'],'Beh')
save([Para.path,'\FP.mat'],'FP')
save([Para.path,'\Para.mat'],'Para')
%--------------------------------------------------------------------------