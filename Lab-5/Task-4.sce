exec("GenerateSine.sce", -1);

function [] = plotAudioSpectrum(input, Fs, color)
	l = length(input);
	frequencies = (0:l-1)/l * Fs;
	half = (1:floor(l/2));

	plot2d("nl", frequencies(half), abs(fft(input))(half), color);
	xlabel("Frequency component, n", 'fontsize', 2);
	ylabel("Freq Amplitude", 'fontsize', 2);
	title("Signal in frequency domain", 'fontsize', 3);
endfunction

Fs = 200;
nSamples = 0.5 * Fs;

x1 = sineSignal(nSamples, 0.5, 190, 0, Fs);
x2 = cosineSignal(nSamples, 2, 10, 0, Fs);

subplot(221);
samples = (1:nSamples);
plot2d(samples, x1, color('blue'));
plot2d(samples, x2, color('red'));
xlabel("Time, n", 'fontsize', 2);
ylabel("Amplitude", 'fontsize', 2);
title("Signals with Fs = 200", 'fontsize', 3);

subplot(222);
plotAudioSpectrum(x1, Fs, color('blue'));
plotAudioSpectrum(x2, Fs, color('red'));
legend(['A = 0.5, f = 190 Hz', 'A = 2, f = 10 Hz']);


Fs = 1000;
nSamples = 0.5 * Fs;

x1 = sineSignal(nSamples, 0.5, 190, 0, Fs);
x2 = cosineSignal(nSamples, 2, 10, 0, Fs);

subplot(223);
samples = (1:nSamples);
plot2d(samples, x1, color('blue'));
plot2d(samples, x2, color('red'));
xlabel("Time, n", 'fontsize', 2);
ylabel("Amplitude", 'fontsize', 2);
title("Signals with Fs = 1000", 'fontsize', 3);

subplot(224);
plotAudioSpectrum(x1, Fs, color('blue'));
plotAudioSpectrum(x2, Fs, color('red'));
