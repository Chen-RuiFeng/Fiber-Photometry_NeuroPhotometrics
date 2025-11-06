FilePath = 'D:\Neurophotometrics\Zhenbo\3-19-24\New folder (4)';

load([FilePath,'\','Beh.mat']);
load([FilePath,'\','FP.mat']);
load([FilePath,'\','Para.mat']);

try
    load([FilePath,'\Behavior\Bh_csv.mat']);
    load([FilePath,'\Behavior\Para_Beh.mat']);
catch
    disp('----------------------------------------------------------')
    disp('Behavior csv data load failed')
    disp('----------------------------------------------------------')
end

