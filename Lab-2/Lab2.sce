chdir('C:\Users\Ruslani\Documents\Scilab\Lab-2');
exec('ADC.sce', -1);

// Sample frequency
fs = 44000;

// Noise frequencies for each poem fragments
noiseFrequencies = [200,150,180,120,210,180,140,120,150,210,150,190,140,210];

// Loads the audio with many quantization levels.
// Uses provided ADC function.
function [audio] = loadAudio(n, fs)
	quantLevels = [-1:0.01:1];
	audio = ADC(n, quantLevels, fs);
endfunction;

// Generates the sine noise.
function [signal] = ysin(nSamples, amplitude, frequency, phase, fs)
	stepSize = frequency * (2 * %pi) / fs;
	samples = (1:fs) * stepSize;
	
	// If amount of generated signals is
	// lower than needed, reduplicate it
	while length(samples) < nSamples
		samples = cat(2, samples, samples);
	end
	
	// If amount of samples is higher than needed,
	// truncate it
	if length(samples) > nSamples then
		samples = samples(1:nSamples);
	end
	
	signal = amplitude * sin(samples + phase);
endfunction;

function[] = plotAudio(audio, fs)
	f = figure(1);
	clf;
	plot(audio, '-');
	gca.data_bounds = [0, -1; fs, 1];
	xlabel('Samples');
	ylabel('Amplitude');
endfunction;

function[signal] = loadAndClean(n)
	// Load and quantize the data
	recData = loadAudio(n, fs);

	// Eliminate amplitude shift
	recData = recData - mean(recData);

	// Generate noise and subtract it from original signal.
	// Amplitude=0.1 and phase=0 are given.
	noiseFreq = noiseFrequencies(n);
	noise = ysin(length(recData), 0.1, noiseFreq, 0, fs);
	signal = recData - noise';
endfunction

// Collect all fragments and merge them
poem = [];
for i = 1:14
	fragment = loadAndClean(i);
	poem = cat(1, poem, fragment);
end

plotAudio(poem, fs);
playsnd(poem, fs);
