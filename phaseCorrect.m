
function [correctedSpectrum] = phaseCorrect(spectrum, params)
  
  bruteForce = 0;
  simplexZeroOrder = 1;
  simplexZeroAndFirstOrder = 2;
  correctedSpectrum = [];
  
  if(params.searchMethod == bruteForce)
    ent = zeros([1 360]);
    for ii = 1:1:360
      %phi = ii + jj * linearRamp;
      phi = ii;
      phiFactor = exp(-1i * pi * phi / 360);
      spectrumCorr = spectrum .* phiFactor;
      ent(ii) = phaseCorrectCostFunction(spectrumCorr, params);
    end  
    
    minIndex = find(ent == min(ent));
    correctedSpectrum = spectrum * exp(-1i * pi * minIndex / 360);
  
  elseif(params.searchMethod == simplexZeroOrder)

    bestPhase = fminsearch (@(phi) (phaseCorrectCostFunction(exp(-1i * phi) * spectrum, params)), [0]);
    correctedSpectrum = spectrum * exp(-1i * bestPhase);
    
  else
  end
  
%ent = zeros([360 360]);
%n = length(spectrum);
%linearRamp = linspace(0,1,n);

%for ii = 1:1:360
%  for jj = 1:1:360
%    phi = ii + jj * linearRamp;
%    phiFactor = exp(-1i * pi * phi / 360);
%    spectrumCorr = spectrum .* phiFactor;
%    ent(ii,jj) = normalizedEntropy(spectrumCorr, false);
%  
%  end
%end


endfunction
