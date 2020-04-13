// [S20] Digital Signal Processing
// Assignment 4, Task 2 - Room effect cancellation
//
// Author: Ruslan Shakirov, B17-SE-01

function[audio] = loadAudio(name)
	// Loads all .wavs with same sample frequency
	// from 'audio/' directory.

	filename = sprintf('audio/%s.wav', name);
	[x, Fs, bits] = wavread(filename);

	audio = intdec(x, 44100/Fs); // Convert signal to 44100 Hz sample frequency
endfunction;

function[] = saveAudio(name, audio)
	// Saves wav.

	savewave(name+'.wav', audio, 44100);
endfunction;

function rirc = reverseIRC(irc)
	// Make the reverse filter
	ircf = fft(irc);
	rircf = 1 ./ ircf;
	rircf(1, find(isinf(rircf))) = 0; // Eliminte infinities
	rirc = ifft(rircf);

	// Shift the filter
	l = length(rirc);
	rirc = [rirc(floor(l/2)+1:l), rirc(1:floor(l/2))];

	// Apply window to filter
	rirc = rirc .* window('kr', l, 6);
endfunction;

function y = normalize(x)
	// Normalize the audio.
	y = x ./ max(abs(x));
endfunction;


// Load sample track and IRC
audio = loadAudio('sample')(1, :);
irc = loadAudio('irc')(1, :);

// Apply room effects
room = convol(audio, irc);
room = normalize(room);
saveAudio('room', room);

// Make a reverse IRC
rirc = reverseIRC(irc);

// Apply the reverse IRC
cleaned = convol(room, rirc);
cleaned = normalize(cleaned);

// Save echo-free audio
saveAudio('cleaned', cleaned);

kro = convol(irc, rirc);
krof = fft(kro);
amp = abs(krof);
phase = phasemag(krof, 'c');


plot(rirc);
xlabel('Time, n');
ylabel('Amplitude');
title('$\tilde{h}$', 'fontsize', 3);
xgrid(color('red'), 1, 7);

scf();

plot(kro);
xlabel('Time, n');
ylabel('Amplitude');
title('$h\ast\tilde{h}$', 'fontsize', 3);
xgrid(color('red'), 1, 7);

scf();
plot(amp);
xlabel(['Spectrum component, ', '$k$']);
ylabel('Freq amp');
title(['$h\ast\tilde{h}$', 'amplitude spectrum'], 'fontsize', 3);
xgrid(color('red'), 1, 7);

scf();
plot(phase);
xlabel(['Spectrum component, ', '$k$']);
ylabel('Freq phase');
title(['$h\ast\tilde{h}$', 'phase spectrum'], 'fontsize', 3);
xgrid(color('red'), 1, 7);
