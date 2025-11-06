% values = {};
% figure
% for i = 1:6
%     nexttile
%     plot(M{i}(250:265,:))
%     [V,T] = max(M{i}(250:265,:));
%     values{i} = [V',(T'+250)/25];
% end

% mag = [];
% lp = [];
% for i = 1: length(Beh_txt.AnimalID)
% lp(i,1) = length(Beh_txt.Data.((['B_',Beh_txt.AnimalID{i}])).ActiveLP);
% lp(i,2) = length(Beh_txt.Data.((['B_',Beh_txt.AnimalID{i}])).MagEnt);
% end

% close all
% figure
% MS= {};
% for i = 1:6
%     nexttile
%     MS{i} = mean_n_se(FP.EventWindows470{i},1);
%     plot(MS{i}(:,1))
% end

% temp = FP.EventWindows470;
% MS = {};
% figure
% for i =1:4
%     nexttile
%     MS{i} = mean_n_se(temp{i},1);
%     plot(MS{i}(:,1))
% 
% end
% 

% figure
% for i = 1:7
%     nexttile
%     plot(temp(:,i))
% end

% MS470 = mean_n_se(FP.EventWindows470{5},1);
% MS560 = mean_n_se(FP.EventWindows560{5},1);
% figure
% plot(MS470(:,1))
% hold on
% plot(MS560(:,1))

% threshold = 1;
% start = 55000;
% ending = 1;
% t = 0:0.04:10000;
% t = t(1:length(FP.L470(start:end-ending,3)));
% figure
% nexttile
% plot(t,zscore(FP.L470(start:end-ending,3)))
% nexttile
% findpeaks(zscore(FP.L470(start:end-ending,3)),'MinPeakProminence',threshold,'Annotate','extents');
% [Pks, Locs, W, p] = findpeaks(zscore(FP.L470(start:end-ending,3)),'MinPeakProminence',threshold);
% nexttile
% plot(smoothdata((FP.L470(start:end-ending,3)),"gaussian",1000))
% X = smoothdata((FP.L470(start:end-ending,3)),"gaussian",1000);
% nexttile
% plot(t,zscore(FP.L470(start:end-ending,2)))
% nexttile
% findpeaks(zscore(FP.L470(start:end-ending,2)),'MinPeakProminence',threshold,'Annotate','extents');
% [Pks, Locs, W, p] = findpeaks((FP.L470(start:end-ending,2)),'MinPeakProminence',threshold);
% nexttile
% plot(smoothdata((FP.L470(start:end-ending,2)),"gaussian",1000))
% Y= smoothdata((FP.L470(start:end-ending,2)),"gaussian",1000);

