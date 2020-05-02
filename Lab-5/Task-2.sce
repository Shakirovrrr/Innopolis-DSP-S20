exec("GenerateSine.sce", -1);

F1 = 6.296;
F2 = 20;
F3 = 33.685;

// ---------------- Plot source signals ------------------
Fs = 1000;
nSamples = Fs * 0.3;
x1 = sineSignal(nSamples, 1, F1, 0, Fs);
x2 = sineSignal(nSamples, 1, F2, 0, Fs);
x3 = sineSignal(nSamples, 1, F3, 0, Fs);
xsum = x1 + x2 + x3;

subplot(311);
xScale = (1:nSamples);
plot2d(xScale, x1, color('red'));
plot2d(xScale, x2, color('limegreen'));
plot2d(xScale, x3, color('blue'));
plot2d(xScale, xsum, color('black'));
legend(['6.296 Hz', '20 Hz', '33.685 Hz', 'Sum']);

g=gca();
g.title.text='Source signals';
g.title.font_size = 2;
g.x_label.text='Time, n';
g.y_label.text='Amplitude';
g.children(2).children.line_style=3;
g.children(2).children.thickness=2;

// ---------------- Plot sampled sum ------------------
Fs = 100;
nSamples = Fs * 0.3;
x1 = sineSignal(nSamples, 1, F1, 0, Fs);
x2 = sineSignal(nSamples, 1, F2, 0, Fs);
x3 = sineSignal(nSamples, 1, F3, 0, Fs);
xsum = x1 + x2 + x3;

subplot(312);
xScale = linspace(1, 300, nSamples);
plot2d(xScale, xsum, color('black'));
scatter(xScale, xsum);

g=gca();
g.title.text='Sampled result';
g.title.font_size = 2;
g.x_label.text='Time, n';
g.y_label.text='Amplitude';

// ---------------- Plot sampled sum ------------------
Fs = 100;
nSamples = Fs * 1;
x1 = sineSignal(nSamples, 1, F1, 0, Fs);
x2 = sineSignal(nSamples, 1, F2, 0, Fs);
x3 = sineSignal(nSamples, 1, F3, 0, Fs);
xsum = x1 + x2 + x3;

xScale = (0:floor(nSamples/2)-1);
magFreq = abs(fft(xsum)) (1:floor(nSamples/2));

subplot(313);
plot2d(xScale, magFreq, color('darkred'));
scatter(xScale, magFreq);

g=gca();
g.title.text='Signal in frequency domain';
g.title.font_size = 2;
g.x_label.text='Frequency, Hz';
g.y_label.text='Freq amplitude';
