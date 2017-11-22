function entr = normalizedEntropy(spectrum, doNegativePenalty);
  h = real(spectrum);
  h = abs(h) / sum(abs(h));
  entr  = -sum(h .* log(h));
  if(doNegativePenalty)
    entr = entr + 0;
  end
end