function y = omega(n, k)
	y = exp(-2 * %pi * %i * k / n);
endfunction

function xf=DFT(x, flag);
	n=size(x,'*');
	//Compute the n by n Fourier matrix
	am=exp(-2*%pi*%i*(0:n-1)'*(0:n-1)/n);
	xf=am*matrix(x,n,1);//dft
	xf=matrix(xf,size(x));//reshape
  endfunction

function y = naiveDFT(x)
	n = length(x);
	am = omega(n, (0 : n-1)' * (0 : n-1));
	y = am * matrix(x, n, 1);
	y = matrix(y, size(x));
endfunction

function y = fasterDFT(x)
	n = length(x);

	if (n <= 1) then
		y = x;
		return;
	end

	if (modulo(n, 2) == 1) then
		y = naiveDFT(x);
		return;
	end

	ixEvens = (1 : n/2) * 2;
	ixOdds = ixEvens - 1;
	evens = fasterDFT(x(ixEvens));
	odds = fasterDFT(x(ixOdds));

	y = zeros(1, n);
	for i = 1 : n/2
		omg = omega(n, i);
		y(i) = odds(i) + omg * evens(i);
		y(i + n/2) = odds(i) - omg * evens(i);
	end
endfunction
