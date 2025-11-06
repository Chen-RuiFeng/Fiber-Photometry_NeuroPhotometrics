  % MagEntDistribution
file = 'D:\Fiber Photometry Data\Himanshu\D1_CIN project\07182023RC_FR1_5s Delay_gACh4m\FiberPhotometry';

% ------------------------------------------------------------------------
close all
load([file,'\BhTimeLine.mat'])
% load([file,'\AUCsWindows.mat'])

eventAnalyz

% FPAnalyze
% % Summary VS eventParas
% % Pearson product-moment correlation coefficient
% coscor = PPMCC(Summary,eventParas);

save([file,'\distributionMap.mat'],'distributionMap');
save([file,'\startp.mat'],'startp');
save([file,'\endp.mat'],'endp');

summary = zeros(2,4);
tempd = startp{end-2};
n = size(tempd,1);
tempd = tempd(~isnan(tempd));
summary(2,1) = sum(tempd>-100&tempd<-50)/n;
summary(2,2) = sum(tempd>-50&tempd<0)/n;
summary(2,3) = sum(tempd>0&tempd<50)/n;
summary(2,4) = sum(tempd>50&tempd<100)/n;


tempd = startp{end};
n = size(tempd,1);
tempd = tempd(~isnan(tempd));
summary(1,1) = sum(tempd>-100&tempd<-50)/n;
summary(1,2) = sum(tempd>-50&tempd<0)/n;
summary(1,3) = sum(tempd>0&tempd<50)/n;
summary(1,4) = sum(tempd>50&tempd<100)/n;
summary = summary';