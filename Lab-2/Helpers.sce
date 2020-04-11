function [signal] = ysin(nSamples, amplitude, frequency, phase, fs)
    stepSize = frequency * (2 * %pi) / fs;
    samples = (1:fs) * stepSize;
    
    while length(samples) < nSamples
        samples = cat(2, samples, samples);
    end
    
    if length(samples) > nSamples then
        samples = samples(1:nSamples)
    end
    
    signal = amplitude * sin(samples + phase)
endfunction
