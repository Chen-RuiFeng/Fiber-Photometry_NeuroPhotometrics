% csvread
% folderName Behaviorfiles
function Bh_csv = readcsv(Para_Beh)

figure('name','behaviors')
set(gcf, 'Position', get(0, 'Screensize'));

    for i = 1:length(Para_Beh.Behaviorfiles)
        fls = [Para_Beh.folderName,'\',Para_Beh.Behaviorfiles{i}];
        opts = detectImportOptions(fls);
        Bh_csv.rawdata.(['B_',Para_Beh.AnimalID{i}]) = readtable(fls,opts);
        Bh_csv.Data.(['B_',Para_Beh.AnimalID{i}]) = showBehavior(Bh_csv.rawdata.(['B_',Para_Beh.AnimalID{i}]),Para_Beh.AnimalID{i});
    end

saveas(gca,[Para_Beh.folderName,'\','behaviors.jpg'])
end

% proprietary functions
function timeline = showBehavior(dat,AnimalID)
    actions = convertCharsToStrings(dat.Var5);
    actionList = unique(actions);
    try
        timeLine = dat.Var2;
    catch
        timeLine = dat.Subject;
    end

    nexttile
    label = {};
    label_ind = 1;
    for i = 1: length(actionList)
        if~isempty(actionList(i))  
            if actionList(i)~=""
                ind = find(actions == actionList(i) );
                nt = strsplit(actionList(i),{' ','\','.'});
                timeline.(nt(1)) = timeLine(ind);
                scatter(timeLine(ind),ones(size(ind))*i,100,'|b','linewidth',1)
                label{label_ind} = actionList(i);
                label_ind = label_ind +1;
                hold on
            end
        end
    end 
    yticklabels(label)
    xlabel('time(s)')
    title(AnimalID)
end