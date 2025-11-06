% TimeWindow
function FP = TimeWindow(Para,FP)

for ii = 1:length(Para.ChamberIndx)
    FP.EventWindows470{ii} = zeros(2*Para.WindowLength+1,length(FP.Eventindx{ii}));
    FP.EventWindows560{ii} = zeros(2*Para.WindowLength+1,length(FP.Eventindx{ii}));
    %FP.Eventindx{ii}(FP.Eventindx{ii}>15000)=[]; 
    for i = 1:length(FP.Eventindx{ii})
            

            FP.EventWindows470{ii}(:,i) = FP.Ftd470(FP.Eventindx{ii}(i)-Para.WindowLength:FP.Eventindx{ii}(i)+Para.WindowLength,Para.ChamberIndx(ii));
            %FP.EventWindows470{ii}(:,i) = zscore(FP.EventWindows470{ii}(:,i));
            try
            FP.EventWindows560{ii}(:,i) = FP.Ftd560(FP.Eventindx{ii}(i)-Para.WindowLength:FP.Eventindx{ii}(i)+Para.WindowLength,Para.ChamberIndx(ii));
            %FP.EventWindows560{ii}(:,i) = zscore(FP.EventWindows560{ii}(:,i));
            catch
            end
    end
    FP.EventWindows470{ii} = FP.EventWindows470{ii}';
    try
    FP.EventWindows560{ii} = FP.EventWindows560{ii}';
    catch
    end
end

figure("Name",'EventWindows')
set(gcf, 'Position', get(0, 'Screensize'));
for ii = 1:length(Para.ChamberIndx)
    try
    nexttile
    imagesc(FP.EventWindows470{ii},[prctile(FP.EventWindows470{ii}(:),10),prctile(FP.EventWindows470{ii}(:),90)])
    colormap('jet')
    colorbar
    xlim([0,2*Para.WindowLength])
    xline(Para.WindowLength)
    title(['470 ChamberID ',num2str(Para.ChamberIndx(ii))])
    nexttile
    plot(mean(FP.EventWindows470{ii},1))
    xlim([0,2*Para.WindowLength])
    xline(Para.WindowLength)
    title(['470 ChamberID ',num2str(Para.ChamberIndx(ii)),' mean'])
try
    nexttile
    imagesc(FP.EventWindows560{ii},[prctile(FP.EventWindows560{ii}(:),10),prctile(FP.EventWindows560{ii}(:),90)])
    colormap('jet')
    colorbar
    xlim([0,2*Para.WindowLength])
    xline(Para.WindowLength)
    title(['560 ChamberID ',num2str(Para.ChamberIndx(ii))])
    nexttile
    plot(mean(FP.EventWindows560{ii},1))
    xlim([0,2*Para.WindowLength])
    xline(Para.WindowLength)
    title(['560 ChamberID ',num2str(Para.ChamberIndx(ii)),' mean'])
catch
end
    catch
        disp(['Chamber',num2str(Para.ChamberIndx(ii)),': failed to show the heatmap'])
    end
end
saveas(gca,[Para.path,'\df_f_zscore.jpg'])
