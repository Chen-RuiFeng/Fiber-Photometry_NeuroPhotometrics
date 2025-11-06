function Beh_txt = txt2data(Beh_txt)
[Beh_txt.filenames,Beh_txt.AnimalID] = readfiles(Beh_txt.folderName,'.txt');
for ii = 1:length(Beh_txt.filenames)

    filename = [Beh_txt.folderName,'\',Beh_txt.filenames{ii}];
    fidin=fopen(filename,'r');
    ind = 0;
    while ~feof(fidin)
        tline=fgetl(fidin);
        for i = 1:length(Beh_txt.Map_keys)
            if ~isempty(tline) && isequal(tline(1:2),[Beh_txt.Map_keys{i},':'])
                ind = ind + 1;
                Beh_txt.Data.(['B_',Beh_txt.AnimalID{ii}]).(Beh_txt.Map_values{ind}) = [];
            end
        end
            try
                Beh_txt.Data.(['B_',Beh_txt.AnimalID{ii}]).(Beh_txt.Map_values{ind}) = [Beh_txt.Data.(['B_',Beh_txt.AnimalID{ii}]).(Beh_txt.Map_values{ind});cell2mat(textscan(tline(8:end),'%f'))];
            catch

            end
    end
    fclose(fidin);
end