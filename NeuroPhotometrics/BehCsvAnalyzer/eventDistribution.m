function [averageMagDuration,startps,Mdis,distributionMap,starts,ends] = eventDistribution(BhTimeLine)
    sampleRate = 10;
    Bh = BhTimeLine;
    raw = BhTimeLine;
    distributionMap = zeros(size(Bh,1),200);
    Bh(isnan(Bh)) = 0;
    indx = find(sum(Bh)==0);
    starts = raw(:,indx(3):indx(4))*sampleRate;
    % starts(starts<0) = NaN;
    ends = raw(:,indx(4):indx(5))*sampleRate;
    % ends(ends<0) = NaN;
    startps =zeros(1,size(Bh,1));
    for i = 2:size(Bh,1)  
        try
            startp = starts(i,:);
            endp = ends(i,:);
            pairs = [startp(~isnan(startp));endp(~isnan(endp))];
            startps(i) = pairs(1,1);
            pair = round(pairs);
            
            for ii = 1:size(pair,2)
                distributionMap(i,pair(1,ii)+100:pair(2,ii)+100) =1;
            end
        catch
        end
    end
    cleanIndx = sum(distributionMap,2);
    distributionMap = distributionMap(cleanIndx~=0,:);
    averageMagDuration = mean(cleanIndx(cleanIndx~=0));
    figure
    imshow(distributionMap)
    figure
    Mdis = mean(distributionMap);
    Mdis = [Mdis;std(distributionMap)/sqrt(size(distributionMap,1))];
    plot(Mdis(1,:),'r')
    hold on
    plot(Mdis(2,:),'b')
end
