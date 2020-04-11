// Coefficients
A = 1
B = -5
C = 4

// Function y = A(x^2) + Bx + C
function [y] = f(x)
	y = A * (x^2) + B * x + C
endfunction

// NewtonRaphson method
//
// x - initial guess of root
// f - function
// eps - precision
function [xn] = NewtonRaphson(x, f, eps)
	h = f(x) / numderivative(f, x)
	i = 0
	i_stop = round(1 / eps)

	while abs(f(x)) >= eps & i < i_stop then
		h = f(x) / numderivative(f, x)
		x = x - h
		i = i + 1
		
		// mprintf("h: %f, x: %f\n", h, x)
	end
	
	if i >= i_stop then
		mprintf("Iterations limit exceeded (%d ops.).\n", i_stop)
	end

	xn = x
endfunction

// Newton Raphson method wrapper
// for finding roots of squared equations
//
// f - function
// eps - precision
function [x1, x2] = NewtonRaphsonRoots(f, eps)
	ver = -B / (2*A)
	disc = B^2 - 4 * A * C
	
	if disc >= 0 then
		guess = [ver-1, ver+1]
		
		x1 = NewtonRaphson(guess(1), f, eps)
		x2 = NewtonRaphson(guess(2), f, eps)
	
		if x1 > x2 then
			t = x2
			x2 = x1
			x1 = t
		end
	else
		guess = [complex(0,ver-1), complex(0,ver+1)]
		
		x1 = NewtonRaphson(guess(1), f, eps)
		x2 = NewtonRaphson(guess(2), f, eps)
		
		if imag(x1) > imag(x2) then
			t = x2
			x2 = x1
			x1 = t
		end
	end
endfunction

// Computes and plots the error
//
// eps - precision
function [err] = plotComputeErrors(eps)
	ver = -B / (2*A)
	guess = [ver-1, ver+1]
	
	roots_ref = roots([A B C])'
	
	errors = list()
	for i = eps:eps:0.1
		roots_algo = NewtonRaphson(guess(1), f, i)
		//roots_algo = [NewtonRaphson(guess(1), f, i), NewtonRaphson(guess(2), f, i)]
		errors($+1) = abs(roots_algo - roots_ref(1))
	end
	
	err = list2vec(errors)
	
	xdata = eps:eps:0.1
	xlabel("eps value")
	ylabel("Error")
	plot(xdata', err)
endfunction
