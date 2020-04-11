function [] = plotAudioTime(input)
	plot(input);
	xlabel("Time, n", 'fontsize', 2)
	ylabel("Amplitude", 'fontsize', 2)
	title("Signal with noise in time domain", 'fontsize', 3)
endfunction

function [] = plotAudioSpectrum(input, Fs)
	inputLen = length(input)
	frequencies = (0:inputLen-1)/inputLen * Fs

	plot2d("nl", frequencies, abs(fft(input)), color("blue"))
	xlabel("Frequency component, n", 'fontsize', 2)
	ylabel("Freq Amplitude", 'fontsize', 2)
	title("Signal with noise in frequency domain", 'fontsize', 3) 
endfunction

function H = idealLowpass(N, cutoff, stop_value)
	N = (N - modulo(N,2)) / 2
	cutoff = floor(2 * N * cutoff)
	H = ones(1, N) * stop_value
	H(1,1:cutoff) = 1.
	// need to make N odd
	H = [1. H flipdim(H, 2)]
endfunction
