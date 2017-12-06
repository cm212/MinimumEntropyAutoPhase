function entr = phaseCorrectCostFunction(spectrum, params);
  h = real(spectrum);
  h = abs(h) / sum(abs(h));
  entr  = -sum(h .* log(h));
  if(params.nonNegativePenalty)
    negativePenalty = 0;
    entr = entr + negativePenalty;
  end
end