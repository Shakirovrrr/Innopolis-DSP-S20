function[y] = convolveFFT(x, h)
	l = length(x) + length(h) - 1;

	x = resize_matrix(x, 1, l);
	h = resize_matrix(h, 1, l);

	xf = fft(x);
	hf = fft(h);

	y = ifft(xf .* hf);
endfunction;

function[audio] = loadAudio(name)
	filename = sprintf('audio/%s.wav', name);
	[x, Fs, bits] = wavread(filename);

	audio = intdec(x, 44100/Fs); // Convert signal to 44100 Hz sample frequency
endfunction;

function[] = playAudio(audio)
	playsnd(audio, 44100);
endfunction;

function[] = saveAudio(name, audio)
	savewave(name+'.wav', audio, 44100);
endfunction;

function rirc = reverseIRC(irc)
	ircf = fft(irc);
	rircf = conj(ircf) ./ (abs(ircf) ^ 2);
	rirc = ifft(rircf);
endfunction;


audio = loadAudio('sample')(1, :);
irc = loadAudio('irc')(1, :);

result = convolveFFT(audio, irc);
result = result ./ max(result);
saveAudio('result', result);

rirc = reverseIRC(irc);
reverted = convolveFFT(result, rirc);
reverted = reverted ./ max(reverted);
saveAudio('reverted', reverted);
