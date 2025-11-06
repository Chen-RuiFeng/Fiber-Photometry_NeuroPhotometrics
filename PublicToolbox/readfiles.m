function [filenames,AnimalID] = readfiles(files,type)
fil = dir([files,'\*',type]);
filenames = cell(1,length(fil));
AnimalID = cell(1,length(fil));
for i =1:length(fil)
    filenames{i} = fil(i).name;
    nt = strsplit(filenames{i},{'_','\','.',' '});
    AnimalID{i} = nt{end-1};
end
