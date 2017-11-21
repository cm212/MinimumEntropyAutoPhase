close all;
clear all;
load('testData.mat');


ent = zeros([1 360]);
for ii = 1:360
  phiFactor = exp(-1i * pi * ii / 360);
  spectrumCorr = spectrum * phiFactor;
  h = real(spectrumCorr);
  h = abs(h) / sum(abs(h));
  ent(ii) = -sum(h .* log(h));
  
  
end


figure();
plot(ent);

phiFactor = exp(-1i * pi * 250 / 360);
  spectrumCorr = spectrum * phiFactor;

figure()
plot(real(spectrumCorr))
