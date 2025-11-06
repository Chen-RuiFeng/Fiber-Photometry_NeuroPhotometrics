%FP_Data_Process
function [FP,Para] = FP_Data_Process(Para)

Para.FPfileName = dir([Para.path,'\FP','*.csv']);
FP.FPraw = readmatrix([Para.path,'\',Para.FPfileName.name]);
FP.FPraw = FP.FPraw(600:end,:);
%--------------------------------------------------------------------------
% List the data of all channels.
for i = 1:length(Para.Channels) 
    if Para.Channels(i)=="415"
        FP.L415 = FP.FPraw(FP.FPraw(:,3)==1,5:Para.FiberNum+4);
    elseif Para.Channels(i)=="470"
        FP.L470 = FP.FPraw(FP.FPraw(:,3)==2,5:Para.FiberNum+4);
    elseif Para.Channels(i)=="560"
        FP.L560 = FP.FPraw(FP.FPraw(:,3)==4,Para.FiberNum+5:2*Para.FiberNum+4);
    end
end

FP.ComTime = FP.FPraw(FP.FPraw(:,3)==2,4);
FP.SysTime = FP.FPraw(FP.FPraw(:,3)==2,2);
FP.SysTime = FP.SysTime-FP.SysTime(1);

% Parameter collector
Para.Freq = 1/mean(diff(FP.SysTime));
Para.Duration = FP.SysTime(end);
disp('---------------------------------------------------------------------------')
disp(Para)
disp('---------------------------------------------------------------------------')

%--------------------------------------------------------------------------
% ensure equal number of frames for each channel
try
    [FP.lenth,~] = min([length(FP.L415(:,1)),length(FP.L470(:,1)),length(FP.SysTime)]);
    FP.SysTime = FP.SysTime(1:FP.lenth,:);
    FP.L415= FP.L415(1:FP.lenth,:);
    FP.L470= FP.L470(1:FP.lenth,:);
catch
end
try
    [FP.lenth,~] = min([length(FP.L415(:,1)),length(FP.L560(:,1)),length(FP.SysTime)]);
    FP.SysTime = FP.SysTime(1:FP.lenth,:);
    FP.L415= FP.L415(1:FP.lenth,:);
    FP.L560= FP.L560(1:FP.lenth,:);
catch
end
%--------------------------------------------------------------------------
figure('Name','raw data')
for i = 1:Para.FiberNum
    nexttile
    plot(FP.L415(:,i),'m')
    hold on 
    plot(FP.L470(:,i),'g')
    try
    plot(FP.L560(:,i),'r')
    catch
    end
end

figure('Name','NNRLR fitting');
set(gcf, 'Position', get(0, 'Screensize'));
FP.dF_F470 = [];
FP.dF_F560 = [];
FP.dF_F415 = [];
FP.Ftd470 = [];
FP.Ftd560 = [];
for i = 1:Para.FiberNum
    % remove photobleaching
    FP.Fit470= fit(FP.SysTime,FP.L470(:,i),'exp2','Normalize', 'on');
    FP.dF_F470 = [FP.dF_F470,100*(FP.L470(:,i)-FP.Fit470(FP.SysTime))./FP.Fit470(FP.SysTime)];
    FP.Fit415= fit(FP.SysTime,FP.L415(:,i),'exp2','Normalize', 'on');
    FP.dF_F415 = [FP.dF_F415, 100*(FP.L415(:,i)-FP.Fit415(FP.SysTime))./FP.Fit415(FP.SysTime)];
    try
        FP.Fit560= fit(FP.SysTime,FP.L560(:,i),'exp2','Normalize', 'on');
        FP.dF_F560 = [FP.dF_F560,100*(FP.L560(:,i)-FP.Fit560(FP.SysTime))./FP.Fit560(FP.SysTime)];
    catch
    end
    
    % regress out 415 using non-negative robust linear regression
    FP.NNRLR = fit(FP.dF_F415(:,i),FP.dF_F470(:,i),fittype('poly1'),'Robust','on');
    FP.Ftd470 = [FP.Ftd470, FP.dF_F470(:,i)-FP.NNRLR(FP.dF_F415(:,i))];
    try
        FP.NNRLR = fit(FP.dF_F415(:,i),FP.dF_F560(:,i),fittype('poly1'),'Robust','on');
        FP.Ftd560 = [FP.Ftd560, FP.dF_F560(:,i)-FP.NNRLR(FP.dF_F415(:,i))];
    catch
    end

    nexttile
    plot(FP.Ftd470(:,i),'g')
    title(['Fitted L470,','G',num2str(i)])
    try
        nexttile
        plot(FP.Ftd560(:,i),'r')
        title(['Fitted L560,','R',num2str(i)])
    catch
    end
end
saveas(gca,[Para.path,'\Fitted data.jpg'])