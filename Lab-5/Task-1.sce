function y = omega(n, k)
	y = exp(-2 * %pi * %i * k / n);
endfunction

function y = naiveDFT(x)
	// Naive slow DFT algorithm

	n = length(x);
	am = omega(n, (0 : n-1)' * (0 : n-1));
	y = am * matrix(x, n, 1);
	y = matrix(y, size(x));
endfunction

function y = ctDFT(x)
	// Implementation of the Cooley-Tukey FFT algorithm

	n = length(x);

	if (n <= 1) then
		y = x;
		return;
	end

	if (modulo(n, 2) == 1) then
		// CT-FFT works only with even-length signals
		// so when the odd-length signal met,
		// fall back to naive algorithm
		y = naiveDFT(x);
		return;
	end

	odds = ctDFT(x(1:2:n));
	evens = ctDFT(x(2:2:n));

	y = zeros(1, n);
	for i = 1 : n/2
		omg = omega(n, (i-1)) * evens(i);
		y(i) = odds(i) + omg;
		y(i + n/2) = odds(i) - omg;
	end
endfunction

signal = rand(1, 2^16);

sciRes = fft(signal);
myRes = ctDFT(signal);

difference = sciRes - myRes;
implErr = sqrt(sum(difference .^ 2));

printf("Error difference: %f\n", implErr);
disp(implErr);
