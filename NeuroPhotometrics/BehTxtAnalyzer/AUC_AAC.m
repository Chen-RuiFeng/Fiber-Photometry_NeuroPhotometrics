function [AACs,AUCs] = AUC_AAC(M,area)


AACs = zeros(size(M,2),1);
AUCs = zeros(size(M,2),1);
% AAC
for i = 1:size(M,2)
    temp = M(area,i);
    
    AAC = 0;
    indx = 1;
    tt = temp(indx);
    while tt<0.2
        AAC=AAC+tt;
        indx = indx +1;
        tt = temp(indx);
    end
    AACs(i) = AAC;

try
    AUC = 0;
    while tt>-0.2
        AUC = AUC +tt;
        indx = indx +1;
        tt = temp(indx);
    end
    AUCs(i) = AUC;
catch
    AUCs(i)=0;
end
end