
function [correctedSpectrum] = minimizeEntropy(spectrum, doFirstOrder, searchMethod)
  bruteForceSearch = 0;
  simplex = 1;
  
  if(searchMethod == bruteForceSearch)
    ent = zeros([1 360]);
    for ii = 1:1:360
      %phi = ii + jj * linearRamp;
      phi = ii;
      phiFactor = exp(-1i * pi * phi / 360);
      spectrumCorr = spectrum .* phiFactor;
      ent(ii) = normalizedEntropy(spectrumCorr, false);
    end  
    
  end

endfunction
