
function [correctedSpectrum, phi0] = phaseCorrect(spectrum, params)
  ## NOTE: returns a corrected spectrum and 0 order phase in radians
  
  bruteForce = 0;
  simplexZeroOrder = 1;
  simplexZeroAndFirstOrder = 2;
  correctedSpectrum = [];
  phi0 = 0;
  if(params.searchMethod == bruteForce)
    ent = zeros([1 360]);
    for phi = 1:1:360
      phiFactor = exp(-1i * pi * phi / 360);
      spectrumCorr = spectrum .* phiFactor;
      ent(phi) = phaseCorrectCostFunction(spectrumCorr, params);
    end  
    minIndex = find(ent == min(ent));
    phi0 = pi * minIndex / 360;
    correctedSpectrum = spectrum * exp(-1i * phi0);
  elseif(params.searchMethod == simplexZeroOrder)
    init = [0];
    phi0 = fminsearch (@(phi) (phaseCorrectCostFunction(exp(-1i * phi) * spectrum, params)), init);
    correctedSpectrum = spectrum * exp(-1i * phi0);
  elseif(params.searchMethod == simplexZeroAndFirstOrder)
    ramp = linspace(0, 1, length(spectrum));
    init = [0; 0];
    bestPhase = fminsearch (@(phi) (phaseCorrectCostFunction(exp(-1i * (phi(1) + phi(2)*ramp)) .* spectrum' , params)), init);
    phi0 = bestPhase(1);
    phi1 = bestPhase(2);% currently not returned by function
    correctedSpectrum = exp(-1i * (phi0 + phi1*ramp)) .* spectrum';
  else
    disp('bad search method');
  end
  
endfunction
