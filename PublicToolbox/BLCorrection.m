% Y = A(:,2);
function [yOut,BL] = BLCorrection(Y,stepsize)
X = 1:length(Y);
yOut = msbackadj(X',Y,"WindowSize",stepsize,"StepSize",stepsize);
BL = Y-yOut;