% computational model

% s_temp = shape(101:end-100);
% s_temp = s_temp(81:end-80);
s_temp(1:71)= 0;
s_temp(119:end) = 0;
figure
plot(s_temp)

signal = zeros(1,501);
for i = 1:1000
f= randperm(125);
f = f(1:5)+250;
    for ii = 1:5   
        signal(f(ii)-70:f(ii)+70)  = s_temp'+signal(f(ii)-70:f(ii)+70);
    end
end
figure
plot(signal)
xline([251,251+125]);