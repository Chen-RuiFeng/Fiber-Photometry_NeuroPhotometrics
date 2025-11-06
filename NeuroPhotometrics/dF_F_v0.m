% dF_F_v0
function dF_F = dF_F_v0(raw,BaseLine)
if isempty(BaseLine)
    dF_F = (raw-mean(raw))/abs(mean(raw));
else
    dF_F = (raw-mean(raw(BaseLine)))/abs(mean(raw(BaseLine)));
end