exec("GenerateSine.sce", -1);
exec("BandFilters.sce", -1);

Fs = 100;
nSamples = Fs * 1;
x1 = sineSignal(nSamples, 1, 5, 0, Fs);
x2 = sineSignal(nSamples, 1, 10, 0, Fs);
x3 = sineSignal(nSamples, 1, 23.685, 0, Fs);
xRes = x1 + x2 + x3;

xLong = resize_matrix(xRes, 1, nSamples * 4);

plot(abs(fft(xLong)));
