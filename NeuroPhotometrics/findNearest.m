% findNearest
% Input = Matrix1 and Matrix2
% Output = the nearest numbers to Matrix2 in the Matrix1
function [Mout,Mindx] = findNearest(M1,M2)

Mout = zeros(length(M2),1);
Mindx = zeros(length(M2),1);
for i = 1:length(M2)
    [~,indx] = min(abs(M1-M2(i)));
    Mout(i) = M1(indx);
    Mindx(i) = indx;
end
