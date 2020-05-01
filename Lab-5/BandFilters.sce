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
