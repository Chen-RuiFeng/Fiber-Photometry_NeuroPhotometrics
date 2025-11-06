% neurophotometrics
clear
%--------------------------------------------------------------------------
Para.path = 'E:\10162024RC_oICSS\F55\oICSS';
Para.BehStampName = 'Input0';%
Para.WindowLength = 250;
Para.ChamberIndx = [2,3]; % 
Para.Channels = ["415","470","560","None"];
Para.FiberNum = 8; 
Para.MinEventInterval = 10000;% 5sec 
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
    try
        nexttile
        plot(FP.L560(:,Para.ChamberIndx(ii)),'r')
    catch
    end
end
saveas(gca,[Para.path,'\raw.jpg'])
%--------------------------------------------------------------------------
% get the time window of each event.
    FP = TimeWindow(Para,FP);
%--------------------------------------------------------------------------

% save data
save([Para.path,'\Para.mat'],'Para')
save([Para.path,'\FP.mat'],'FP')
save([Para.path,'\Beh.mat'],'Beh')
%--------------------------------------------------------------------------