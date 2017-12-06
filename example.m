close all;
clear all;
load('testData.mat');


bruteForce = 0;
simplexZeroOrder = 1;
simplexZeroAndFirstOrder = 2;

params.firstOrderPhaseCorrection = false;
params.nonNegativePenalty = true;
params.searchMethod = simplexZeroOrder;

correctedSpectrum = phaseCorrect(spectrum, params);

subplot(1,2,1)
plot(real(spectrum),'b-')
title('original')
subplot(1,2,2)
plot(real(correctedSpectrum),'b-')
title('phase corrected')
