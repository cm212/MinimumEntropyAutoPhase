close all;
clear all;
load('testData.mat');




ent = zeros([360 360]);
n = length(spectrum);
linearRamp = linspace(0,1,n);

for ii = 1:1:360
  for jj = 1:1:360
    phi = ii + jj * linearRamp;
    phiFactor = exp(-1i * pi * phi / 360);
    spectrumCorr = spectrum .* phiFactor;
    ent(ii,jj) = normalizedEntropy(spectrumCorr);
  
  end
end


figure();
surf(ent);

%phiFactor = exp(-1i * pi * 250 / 360);
%spectrumCorr = spectrum * phiFactor;

%figure()
%plot(real(spectrumCorr))
