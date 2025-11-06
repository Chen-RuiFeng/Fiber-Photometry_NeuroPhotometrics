% n = [];
% M = [];
% 
% for i = 1:8
%     n = [n;size(Beh_txt.Data.(['B_',Beh_txt.AnimalID{i}]).ActiveLP,1)];
%     M = [M;size(Beh_txt.Data.(['B_',Beh_txt.AnimalID{i}]).MagEnt,1)];
% end










% close all
% temp = FP.EventWindows470;
% MS=[];
% figure
% for i = [1:8]
%     tt = FP.EventWindows470{i}(FP.EventWindows470{i}(:,1)~=0,:);
%     MS =[MS, mean_n_se(tt,1)'];
% nexttile
% plot(mean_n_se(tt,1)')
% end
% MMS = MS(:,1:2:end);

% figure
% tempp = temp(:,1:2:end);
% tempp = tempp';
% MS = mean_n_se(tempp,1);
% plot(MS(:,1))
% 
% 
% figure
% for i = 1:2:20
% nexttile
% plot(temp(:,i))
% end

% tt = temp(:,2:2:end);
% 
% for i = 2:7
%     dipSE(i-1) = tt(indx1(i-1),i);
%     rbSE(i-1) = tt(indx2(i-1),i);
% end





% stis = {};
% for i = 1:7
% % stis{i} = [temp{1}(:,i),temp{2}(:,i),temp{3}(:,i),temp{4}(:,i),temp{5}(:,i),temp{6}(:,i),temp{7}(:,i)];
% stis{i}= [];
% for ii = [1,4:5]
%     stis{i}= [stis{i},temp{ii}(:,i)];
% end
% end 
% figure
% for i = 1:7
% MS = mean_n_se(stis{i}',1);
% nexttile
% plot(MS(:,1))
% end
%temp = DF_F;

% figure
% for i= 1:6
%     nexttile
% plot(DF_F(:,i))
% end
% 
temp =FP.EventWindows470{2};
MS = [];
figure
for i = 1:7
 nexttile
 
 MS = [MS,mean(temp(5*(i-1)+1:i*5,:))'];

 plot(MS(:,i))

end






















