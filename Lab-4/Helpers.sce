function [] = plotAudioTime(input)
	plot(input);
	xlabel("Time, n", 'fontsize', 2);
	ylabel("Amplitude", 'fontsize', 2);
	title("Signal in time domain", 'fontsize', 3);
endfunction

function [] = plotAudioSpectrum(input, Fs, color)
	l = length(input);
	frequencies = (0:l-1)/l * Fs;
	half = (1:floor(l/2));

	plot2d("nl", frequencies(half), abs(fft(input))(half), color);
	xlabel("Frequency component, n", 'fontsize', 2);
	ylabel("Freq Amplitude", 'fontsize', 2);
	title("Signal in frequency domain", 'fontsize', 3);
endfunction

function [] = plotResponseFreq(input, color)
	l = length(input);
	frequencies = (0:l-1)/l * Fs;

	plot2d('nn', frequencies, input, color);
	xlabel("Frequency, Hz", 'fontsize', 2);
	ylabel("Amplitude", 'fontsize', 2);
	title("Impulse response of the filter", 'fontsize', 3);
endfunction

function [] = plotResponseSpectrum(input, Fs, color)
	l = length(input);
	frequencies = (0:l-1)/l * Fs;

	plot2d("nl", frequencies, abs(fft(input)), color);
	xlabel("Frequency, Hz", 'fontsize', 2);
	ylabel("Freq Amplitude", 'fontsize', 2);
	title("Frequency response of the filter", 'fontsize', 3);
endfunction
