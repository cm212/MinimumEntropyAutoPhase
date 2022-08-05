% clear workspace + cmd-line
clear all
clc
% load testdata
load('testData02.mat')

% set window bandwidth for graphs
winBW = [-1,0.5]*1000; % Hz

% plot original spectrum
figure(1)
subplot(2,2,1)
plot(frequency,real(spectrum))
title('Baseline')
xlabel('Frequency (hz)')
ylabel('Signal (a.u.)')
xlim(winBW)

% Dephase original spectrum
fx = frequency / max(abs(frequency));
spectrum_dephased = spectrum .* exp(-1i * (-0.9 + 2.5 * fx) * pi);

% plot dephased spectrum
subplot(2,2,2)
plot(frequency,real(spectrum_dephased))
title('Dephased')
xlabel('Frequency (hz)')
ylabel('Signal (a.u.)')
xlim(winBW)

% set params for phaseCorrect()
bruteForce = 0;
simplexZeroOrder = 1;
simplexZeroAndFirstOrder = 2;
params.nonNegativePenalty = true;
params.searchMethod = simplexZeroAndFirstOrder;
% run phaseCorrect()
[correctedSpectrum, phi0] = phaseCorrect(spectrum_dephased', params);

% calc resulting phi0 in units of pi
phi0_unit_pi = phi0/pi;

% plot corrected spectrum
subplot(2,2,3)
plot(frequency, real(correctedSpectrum))
title('Result = phaseCorrect(Dephased)')
xlabel('Frequency (hz)')
ylabel('Signal (a.u.)')
xlim(winBW)
lim = get(gca,"YLim");

% plot residual = original - corrected
subplot(2,2,4)
plot(frequency, real(spectrum - correctedSpectrum))
title('Basline - Result')
xlabel('Frequency (hz)')
ylabel('Signal (a.u.)')
xlim(winBW)
ylim(lim)

