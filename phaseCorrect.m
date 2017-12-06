
function [correctedSpectrum] = phaseCorrect(spectrum, params)
  
  bruteForce = 0;
  simplexZeroOrder = 1;
  simplexZeroAndFirstOrder = 2;
  correctedSpectrum = [];
  
  if(params.searchMethod == bruteForce)
    ent = zeros([1 360]);
    for phi = 1:1:360
      phiFactor = exp(-1i * pi * phi / 360);
      spectrumCorr = spectrum .* phiFactor;
      ent(phi) = phaseCorrectCostFunction(spectrumCorr, params);
    end  
    minIndex = find(ent == min(ent));
    correctedSpectrum = spectrum * exp(-1i * pi * minIndex / 360);
  elseif(params.searchMethod == simplexZeroOrder)
    init = [0];
    bestPhase = fminsearch (@(phi) (phaseCorrectCostFunction(exp(-1i * phi) * spectrum, params)), init);
    correctedSpectrum = spectrum * exp(-1i * bestPhase);
  elseif(params.searchMethod == simplexZeroAndFirstOrder)
    ramp = linspace(0, 1, length(spectrum));
    init = [0; 0];
    bestPhase = fminsearch (@(phi) (phaseCorrectCostFunction(exp(-1i * (phi(1) + phi(2)*ramp)) .* spectrum' , params)), init);
    correctedSpectrum = exp(-1i * (bestPhase(1) + bestPhase(2)*ramp)) .* spectrum';
  else
    disp('bad search method');
  end
  
endfunction
