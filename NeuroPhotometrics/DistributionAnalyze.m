figure
CompresseDatas = {};
MCDs = [];
N = [];
for i = 1: length(Beh_txt.AnimalID)
    nexttile
    CompresseDatas{i} = HeatMapCompress(Beh_txt.distribution.(['B_',Beh_txt.AnimalID{i}]),5);
    % CompresseDatas{i} = HeatMapCompress(CompresseDatas{i},5);
    CompresseDatas{i}(CompresseDatas{i}==2)=0;
    CompresseDatas{i}(CompresseDatas{i}==1)=0;
    CompresseDatas{i}(CompresseDatas{i}==3)=1;
    nexttile
    MCDs(:,i) = mean(CompresseDatas{i});
    N(i) = size(CompresseDatas{i},1);
    plot(MCDs(:,i))
end
N = N';