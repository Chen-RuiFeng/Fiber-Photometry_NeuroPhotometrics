function CompresseData = HeatMapCompress(temp,CompressRate)
% CompressRate = 5;
% temp = Beh_txt.distribution.B_7M75R;
iiMax = floor(size(temp,2)/CompressRate);
CompresseData = zeros(size(temp,1),iiMax);
for i = 1:size(temp,1)
    for ii = 1:iiMax
        CompresseData(i,ii) = max(temp(i,CompressRate*(ii-1)+1:CompressRate*ii));
    end
end
imagesc(CompresseData)