% listplot
function D = listplot(temp,interval)
D = zeros(size(temp));
    figure
    for i = 1:size(temp,2)
        D(:,i) = temp(:,i)+interval*i;
        plot(D(:,i))
        hold on
    end
end