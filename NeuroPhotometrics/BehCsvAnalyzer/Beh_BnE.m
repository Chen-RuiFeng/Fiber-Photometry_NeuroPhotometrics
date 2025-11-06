function Bh_csv = Beh_BnE(Bh_csv,Para_Beh,Beh_B,Beh_E)

for i = 1:length(Para_Beh.StatisticList)
    B = cellfun(@(x) isequal(x,Beh_B), Para_Beh.StatisticList);
    B = find(B==1);
    E = cellfun(@(x) isequal(x,Beh_E), Para_Beh.StatisticList);
    E = find(E==1);
end

inter = 1+B==E;

figure('Name','distribution')
set(gcf, 'Position', get(0, 'Screensize'));
for i = 1:length(Para_Beh.AnimalID)
    
    Bh_csv.distr_v1.(['B_',Para_Beh.AnimalID{i}]) = zeros(size(Bh_csv.distribution.(['B_',Para_Beh.AnimalID{i}])));

    for ii = 1:size(Bh_csv.distribution.(['B_',Para_Beh.AnimalID{i}]),1)
        B_indx_temp = find(Bh_csv.distribution.(['B_',Para_Beh.AnimalID{i}])(ii,Para_Beh.windowLength+1:end) == B)+Para_Beh.windowLength;
        E_indx_temp = find(Bh_csv.distribution.(['B_',Para_Beh.AnimalID{i}])(ii,Para_Beh.windowLength+1:end) == E)+Para_Beh.windowLength;
        for iii = 1:inter:length(B_indx_temp)
            E_temp = min(E_indx_temp(E_indx_temp>B_indx_temp(iii)));
            Bh_csv.distr_v1.(['B_',Para_Beh.AnimalID{i}])(ii,B_indx_temp(iii):E_temp)=1;
        end
    end
    nexttile
    imagesc(Bh_csv.distr_v1.(['B_',Para_Beh.AnimalID{i}]))
    colormap([[1 1 1];[1 0 0];[0.6 0.8 0.3];[0.1 0.5 0.1];[0 1 0]])
    title(Para_Beh.AnimalID{i})
end

saveas(gca,[Para_Beh.folderName,'\distribution.jpg'])