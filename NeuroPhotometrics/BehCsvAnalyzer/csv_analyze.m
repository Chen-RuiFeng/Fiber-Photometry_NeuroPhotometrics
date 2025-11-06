%csv_analyze
function Bh_csv = csv_analyze(Bh_csv,Para_Beh)

figure('Name','Behavior distribution')
set(gcf, 'Position', get(0, 'Screensize'));

for i = 1:length(Para_Beh.AnimalID)
    nt = strsplit(Para_Beh.ReferenceEvent,{' ','\','.'});
    pivots = Bh_csv.Data.(['B_',Para_Beh.AnimalID{i}]).(nt{1});
    pivots = pivots(Para_Beh.isFR(2):Para_Beh.isFR(1):end );
    Bh_csv.pivots.(['B_',Para_Beh.AnimalID{i}]) = pivots+Para_Beh.Shift;
    Bh_csv.distribution.(['B_',Para_Beh.AnimalID{i}]) = zeros(length(pivots),2*Para_Beh.windowLength+1);
    Bh_csv.distribution.(['B_',Para_Beh.AnimalID{i}])(:,Para_Beh.windowLength+1) = 1;
    
    for ii = 2:length(Para_Beh.StatisticList)
        for iii = 1:length(pivots)
            nt = strsplit(Para_Beh.StatisticList{ii},{' ','\','.'});
            event_tmp = Bh_csv.Data.(['B_',Para_Beh.AnimalID{i}]).(nt{1})-pivots(iii);
            event_tmp = round(event_tmp*Para_Beh.resolution);
            Bh_csv.distribution.(['B_',Para_Beh.AnimalID{i}])(iii,event_tmp((event_tmp>-Para_Beh.windowLength) & (event_tmp<Para_Beh.windowLength))+Para_Beh.windowLength) =ii;
        end
    end

    nexttile
    imagesc(Bh_csv.distribution.(['B_',Para_Beh.AnimalID{i}]))
    colormap([[1 1 1];[1 0 0];[0.6 0.8 0.3];[0.1 0.5 0.1];[0 1 0]])
    title(Para_Beh.AnimalID{i})
end

saveas(gca,[Para_Beh.folderName,'\',Para_Beh.ReferenceEvent,'_sortTime.jpg'])
