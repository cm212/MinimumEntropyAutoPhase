function entr = normalizedEntropy(spectrum, doNegativePenalty);
  h = real(spectrumCorr);
  h = abs(h) / sum(abs(h));
  entr  = -sum(h .* log(h));
end