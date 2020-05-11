exec("WavHelpers.sce", -1);

function y = clipAudio(x, a)
	y = min(abs(x), a) .* sign(x);
endfunction;

function y = distortAudio(x, a, b)
	y = atan(x * b) * a;
endfunction;

function y = normalizeAudio(x)
	y = x ./ max(abs(x));
endfunction;

clean = loadAudio('guitar')(1, :);
clean = normalizeAudio(clean);

clipped = clipAudio(clean, 0.3);
distorted = distortAudio(clean, 1, 20);

saveAudio(normalizeAudio(clipped), 'clipped');
saveAudio(normalizeAudio(distorted), 'distorted');

// Plot graphs
l = length(clean);
xrange = (0:l-1);

// Temporal domain
subplot(311);
title("Clean signal, temporal domain", 'fontsize', 2)
xlabel("Time, n");
ylabel("Amplitude");
plot2d(xrange, clean, color('skyblue'));

subplot(312);
plot2d(xrange, clipped, color('darkred'));
axes = gca();
axes.data_bounds = [0, -1; l-1, 1];
title("Clipped signal, temporal domain", 'fontsize', 2)
xlabel("Time, n");
ylabel("Amplitude");

subplot(313);
plot2d(xrange, distorted, color('orange'));
title("Distorted signal, temporal domain", 'fontsize', 2)
xlabel("Time, n");
ylabel("Amplitude");

// Spectral domain
scf();

frequencies = (0:l-1) / l * 44100;
half = (1:floor(l / 2));
xfreq = frequencies(half);

subplot(311);
plot2d("nl", xfreq, abs(fft(clean))(half), color('skyblue'));
title("Clean signal, spectral domain", 'fontsize', 2)
xlabel("Frequency, Hz");
ylabel("Amplitude");

subplot(312);
plot2d("nl", xfreq, abs(fft(clipped))(half), color('darkred'));
title("Clipped signal, spectral domain", 'fontsize', 2)
xlabel("Frequency, Hz");
ylabel("Amplitude");

subplot(313);
plot2d("nl", xfreq, abs(fft(distorted))(half), color('orange'));
title("Distorted signal, spectral domain", 'fontsize', 2)
xlabel("Frequency, Hz");
ylabel("Amplitude");
