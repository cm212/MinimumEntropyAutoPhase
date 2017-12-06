function entr = phaseCorrectCostFunction(spectrum, params);
  R = real(spectrum);
  
  h = abs(R) / sum(abs(R));
  entr  = -sum(h .* log(h));
  if(params.nonNegativePenalty)
    % equation 8 in reference
    stepDownFunction = 0.5 - sign(R)/2; % 1 when negative, 0 when positive 
  
    % should be determined to make negativity penalty on order of entropy
    % for now hard coded
    scaleFactor = 1e10;

    % equation 7 in reference
    negativePenalty = scaleFactor * sum(stepDownFunction .* abs(h));
    entr = entr + negativePenalty;
  end
end