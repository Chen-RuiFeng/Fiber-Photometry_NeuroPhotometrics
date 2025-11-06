function eventDistr = eventdistribution(Beh_txt,compressRate)
l = length(Beh_txt.AnimalID);
LP = [];
MagEnt = [];
for i = 1:l
    temp = Beh_txt.distribution.(['B_',Beh_txt.AnimalID{i}]);
    CompresseData = HeatMapCompress(temp,compressRate);
    %CompresseData = HeatMapCompress(CompresseData,5);
    LP = [LP;CompresseData==2];
    MagEnt =[MagEnt;CompresseData==3];
end

figure
ML= mean(LP);
ML = ML'/sum(ML);
nexttile
plot(ML)
MM = mean(MagEnt);
nexttile
plot(MM)
MM = MM'/sum(MM);

eventDistr = [ML,MM];