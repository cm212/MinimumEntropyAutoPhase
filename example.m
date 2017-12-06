close all;
clear all;
load('testData.mat');


bruteForce = 0;
simplex = 1;
params.firstOrderPhaseCorrection = false;
params.nonNegativePenalty = true;
params.searchMethod = bruteForce;

correctedSpectrum = phaseCorrect(spectrum, params);


subplot(1,2,1)
plot(real(spectrum),'b-')
title('original')
subplot(1,2,2)
plot(real(correctedSpectrum),'b-')
title('phase corrected')
