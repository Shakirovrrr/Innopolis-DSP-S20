// [S20] Digital Signal Processing
// Assignment 4, Task 2 - Room effect cancellation
//
// Author: Ruslan Shakirov, B17-SE-01

function[audio] = loadAudio(name)
	filename = sprintf('audio/%s.wav', name);
	[x, Fs, bits] = wavread(filename);

	audio = intdec(x, 44100/Fs); // Convert signal to 44100 Hz sample frequency
endfunction;

function[] = saveAudio(name, audio)
	savewave(name+'.wav', audio, 44100);
endfunction;

function rirc = reverseIRC(irc)
	// Make the reverse filter
	ircf = fft(irc);
	rircf = conj(ircf) ./ (abs(ircf) ^ 2);
	rirc = ifft(rircf);

	// Shift the filter
	l = length(rirc);
	rirc = [rirc(floor(l/2)+1:l), rirc(1:floor(l/2))];

	// Apply window to filter
	rirc = rirc .* window('kr', l, 8);
endfunction;

function y = normalize(x)
	y = x ./ max(abs(x));
endfunction;


audio = loadAudio('sample')(1, :);
irc = loadAudio('irc')(1, :);

result = convol(audio, irc);
result = normalize(result);
saveAudio('result', result);

rirc = reverseIRC(irc);
reverted = convol(result, rirc);
reverted = normalize(reverted);
saveAudio('reverted', reverted);
