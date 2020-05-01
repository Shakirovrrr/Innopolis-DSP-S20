exec("GenerateSine.sce", -1);

Fs = 100;
nSamples = Fs * 1;
x1 = sineSignal(nSamples, 1, 5, 0, Fs);
x2 = sineSignal(nSamples, 1, 10, 0, Fs);
x3 = sineSignal(nSamples, 1, 23.685, 0, Fs);
xres = x1 + x2 + x3;

magFreq = abs(fft(xres));
plot(magFreq);
// scatter(magFreq);
