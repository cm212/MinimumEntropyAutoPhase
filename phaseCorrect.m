function [correctedSpectrum, phiVector] = phaseCorrect(spectrum, params)
  % NOTE: returns a corrected spectrum and a 2-vector of the  
  %   0th- and 1st-order phases
  
  bruteForce = 0;
  simplexZeroOrder = 1;
  simplexZeroAndFirstOrder = 2;
  correctedSpectrum = [];
  phiVector = [0 0];
  
  if(params.searchMethod == bruteForce)
    ent = zeros([1 360]);
    for phaseIndex = 1:1:360
      phiFactor = exp(-1i * pi * phaseIndex / 360);
      spectrumCorr = spectrum .* phiFactor;
      ent(phaseIndex) = phaseCorrectCostFunction(spectrumCorr, params);
    end  
    minIndex = find(ent == min(ent));
    phiVector(1) = pi * minIndex / 360;
    correctedSpectrum = spectrum * exp(-1i * phiVector(1));
  elseif(params.searchMethod == simplexZeroOrder)
    init = [0];
    phiVector(1) = fminsearch (@(phi) (phaseCorrectCostFunction(exp(-1i * phi) * spectrum, params)), init);
    correctedSpectrum = spectrum * exp(-1i * phiVector(1));
  elseif(params.searchMethod == simplexZeroAndFirstOrder)
    ramp = linspace(0, 1, length(spectrum));
    init = [0; 0];
    bestPhase = fminsearch (@(phi) (phaseCorrectCostFunction(exp(-1i * (phi(1) + phi(2)*ramp)) .* spectrum' , params)), init);
    phiVector = bestPhase;
    correctedSpectrum = exp(-1i * (phiVector(1) + phiVector(2)*ramp)) .* spectrum';
  else
    disp('bad search method');
  end
end  

