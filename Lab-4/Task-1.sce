// [S20] Digital Signal Processing
// Assignment 4, Task 1 - FIR filter design
//
// Author: Ruslan Shakirov, B17-SE-01

// Load helpers for drafing graphs.
exec("Helpers.sce", -1);

function response = passBandAux(N, freqFrom, freqTo, Fs)
	// Creates a left half of frequency response array.

	// Compute indicies
	passFrom = floor(freqFrom / Fs * N);
	passTo = floor(freqTo / Fs * N);

	// Make sure indicies are valid
	if (passFrom < 1) then
		passFrom = 1;
	end
	if (passTo < 1) then
		passTo = 1;
	end

	// Create the response and allow provided bands
	response = zeros(1, N);
	response(1, passFrom:passTo) = 1;
endfunction

function response = passBand(N, freqFrom, freqTo, Fs)
	// Create a pass band frequency response.
	response = passBandAux(N, freqFrom, freqTo, Fs/2);
	if (modulo(N, 2) == 0) then
		response = [response(1,1), response, flipdim(response, 2)];
	end
endfunction

function response = stopBand(N, freqFrom, freqTo, Fs)
	// Create a stop band frequency response.
	response = passBand(N, freqFrom, freqTo, Fs);
	response = abs(response - 1); // Invert the passBand response
endfunction

function filter = makeFilter(bands)
	// Make a filter based on provided bands

	// Convert response into time domain
	filter = real(ifft(bands));

	// Shift the frequency responce
	l = length(filter);
	filter = [filter(floor(l/2)+1:l), filter(1:floor(l/2))];
	filter = filter .* window('kr', l, 8);
endfunction

// Load the data
load("signal_with_noise_and_filtered.sod");

// Define stop bands which contain noise
bands = stopBand(256, 1, 50, Fs);
bands = bands .* stopBand(256, 8500, 15000, Fs);

// Draw the frequency response for bands
subplot(1, 1, 4);
plotResponseFreq(bands, color('blue'));


// Make the filter
filter = makeFilter(bands);

// Draw the filter impulse response
subplot(1, 2, 4);
plotResponseFreq(filter, color('blue'));

// Draw the frequency response of the filter
subplot(2, 1, 4);
plotResponseSpectrum(filter, Fs, color('blue'));


// Apply the filter
result = conv(signal_with_noise, filter);

// Draw spectrograms
subplot(2, 2, 4);
plotAudioSpectrum(signal_with_noise, Fs, color('blue'));
plotAudioSpectrum(result, Fs, color('red'));
legend("With noise", "Filtered");

// Save the result
savewave("result.wav", result, Fs);
