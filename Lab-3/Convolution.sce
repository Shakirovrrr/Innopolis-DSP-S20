function[y] = convolveDirect(x, h)
	lx = length(x);
	lh = length(h);
	l = lx + lh - 1;

	x = resize_matrix(x, 1, l);
	h = resize_matrix(h, 1, l);
	h = flipdim(h, 2);
	
	y = [];
	for i = 1:l do
		y(i) = sum( x(1:i) .* h(l-i+1:l) );
	end

	y = y';
endfunction;

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

function[] = drawCompare(audio, irc)
	resb = conv(audio, irc);
	resf = convolveFFT(audio, irc);

	resb = resb ./ max(resb);
	resf = resf ./ max(resf);

	clf();

	subplot(2,2,1);
	plot(resb);
	title('Built-in conv()');

	subplot(2,2,2);
	plot(resf);
	title('Our convolveFFT()');

	subplot(2,2,3);
	mapsound(resb);

	subplot(2,2,4);
	mapsound(resf);

endfunction;
