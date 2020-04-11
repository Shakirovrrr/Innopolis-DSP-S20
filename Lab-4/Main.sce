exec("Filter.sce", -1);

[s, Fs, _] = wavread("audio/signal_with_noise.wav");
s = s(1,:);

// plotAudioSpectrum(s, Fs);

H_l = idealLowpass(256, 0.15, 0.);

// calculate frequencies
h_len = length(H_l);
frequencies = (0:h_len-1)/h_len * Fs;
// plot
// plot2d("nn", frequencies, H_l, color("blue"));

// frequencies(h_len/2:h_len-1) = 0;

h_l = real(ifft(H_l));
h_l = cat(2, h_l(floor(h_len/2)+1:h_len), h_l(1:floor(h_len/2)));

h_l = h_l .* window('kr', length(h_l), 8);

// plot2d('nn', 1:length(h_l), h_l, color("red"));

// plot2d("nl", frequencies, abs(fft(h_l)), color("blue"));

result = conv(s, h_l);
// result = result ./ max(result);


// savewave("result.wav", result, Fs);
