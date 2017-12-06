
function [correctedSpectrum] = phaseCorrect(spectrum, params)
  
  bruteForceSearch = 0;
  simplex = 1;
  
  if(params.searchMethod == bruteForceSearch)
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
  
  elseif(params.searchMethod == simplex)
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


%figure();
%
%surf(ent);

%phiFactor = exp(-1i * pi * 250 / 360);
%spectrumCorr = spectrum * phiFactor;

%figure()
%plot(real(spectrumCorr))


endfunction
