function [samples] = generateSineSamples(nSamples, frequency, fs)
	stepSize = frequency * (2 * %pi) / fs;
	samples = (1:fs) * stepSize;
	
	if length(samples) < nSamples
		samples = repmat(samples, 1, ceil(nSamples / length(samples)));
	end
	
	if length(samples) > nSamples then
		samples = samples(1:nSamples);
	end
endfunction

function [signal] = sineSignal(nSamples, amplitude, frequency, phase, fs)
	samples = generateSineSamples(nSamples, frequency, fs);
	signal = amplitude * sin(samples + phase);
endfunction

function [signal] = cosineSignal(nSamples, amplitude, frequency, phase, fs)
	samples = generateSineSamples(nSamples, frequency, fs);
	signal = amplitude * cos(samples + phase);
endfunction
