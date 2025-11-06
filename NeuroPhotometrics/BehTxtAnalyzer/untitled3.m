
area = [5000:10000];
figure
lr = [FP.Ftd470(area,2),FP.Ftd470(area,3)];
nexttile
plot(FP.Ftd470(area,3));
nexttile
plot(FP.Ftd470(area,2));