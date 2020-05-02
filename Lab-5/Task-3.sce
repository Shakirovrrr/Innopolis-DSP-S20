exec("GenerateSine.sce", -1);

function [] = plotAudioSpectrum(input, Fs, color)
	l = length(input);
	frequencies = (0:l-1)/l * Fs;
	half = (1:floor(l/2));

	plot2d("nl", frequencies(half), abs(fft(input))(half), color);
	xlabel("Frequency component, n", 'fontsize', 2);
	ylabel("Freq Amplitude", 'fontsize', 2);
endfunction

F1 = 6.296;
F2 = 20;
F3 = 33.685;

Fs = 100;
nSamples = Fs * 1;
x1 = sineSignal(nSamples, 1, F1, 0, Fs);
x2 = sineSignal(nSamples, 1, F2, 0, Fs);
x3 = sineSignal(nSamples, 1, F3, 0, Fs);

original = x1 + x2 + x3;
windowParam = 8;
originalWindowed = original .* window('kr', length(original), windowParam);
padded = resize_matrix(original, 1, nSamples * 4);
paddedWindowed = padded .* window('kr', length(padded), windowParam);

subplot(2,2,1);
plotAudioSpectrum(original, Fs, color('red'));
title("Original", 'fontsize', 3);
subplot(2,2,2);
plotAudioSpectrum(padded, Fs, color('limegreen'));
title("Padded", 'fontsize', 3);
subplot(2,2,3);
plotAudioSpectrum(originalWindowed, Fs, color('blue'));
title("Original, windowed", 'fontsize', 3);
subplot(2,2,4);
plotAudioSpectrum(paddedWindowed, Fs, color('orange'));
title("Padded, windowed", 'fontsize', 3);
// legend(['Original', 'Padded', 'Original, windowed', 'Padded, windowed']);
