function[audio] = loadAudio(name)
	filename = sprintf('audio/%s.wav', name);
	[x, Fs, bits] = wavread(filename);

	audio = intdec(x, 44100/Fs); // Convert signal to 44100 Hz sample frequency
endfunction;

function[] = playAudio(audio)
	playsnd(audio, 44100);
endfunction;

function[] = saveAudio(audio, name)
	filename = sprintf('audio/%s.wav', name);
	savewave(filename, audio, 44100);
endfunction;
