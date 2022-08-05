close all
clear 
load('testData.mat');

bruteForce = 0;
simplexZeroOrder = 1;
simplexZeroAndFirstOrder = 2;

params.nonNegativePenalty = true;
params.searchMethod = simplexZeroOrder;

[correctedSpectrum, phi0] = phaseCorrect(spectrum, params);

subplot(1,2,1)
plot(real(spectrum),'b-')
title('original')
subplot(1,2,2)
plot(real(correctedSpectrum),'b-')
title('phase corrected')
