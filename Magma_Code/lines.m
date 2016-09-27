Q := Rationals();
P<x,y,z,w> := ProjectiveSpace(Q,3);
f := 3*x^3+3*y^3+3*z^3+3*w^3;
X := Scheme(P,f);


//We then want enter generic parametrizations of lines, the coefficients of which we want to be able to solve for.  So let's pretend they define some polynomial ring over Q.
poly<alpha,beta,gamma,delta> := PolynomialRing(Q,4);
k<s,t> := PolynomialRing(poly,2);
allParametrizations := [[s,t,alpha*s+beta*t,gamma*s+delta*t],[s,alpha*s,t,beta*s+gamma*t],[s,alpha*s,beta*s,t],[0,s,t,alpha*s+beta*t],[0,s,alpha*s,t],[0,0,s,t]];
for param in allParametrizations do
	g := Evaluate(f,param);
	coefs := Coefficients(g);
	print GroebnerBasis(ideal<poly|coefs>);
end for;
	
//Actually let's be smarter.  We want to find alpha, beta, gamma, delta which are solutions to certain equations.  That's a scheme.  Though the sad thing here is it takes more maneuvering to solve for a,b,c,d in a non-trivial extension of Q.  You can play around with that...
A<a,b,c,d> := AffineSpace(Q,4);
k2<s,t> := PolynomialRing(CoordinateRing(A),2);
allParametrizationsA := [[s,t,a*s+b*t,c*s+d*t],[s,a*s,t,b*s+c*t],[s,a*s,b*s,t],[0,s,t,a*s+b*t],[0,s,a*s,t],[0,0,s,t]];
variablesNotInParams := [[],[d],[c,d],[c,d],[b,c,d],[a,b,c,d]];
for i in [1 .. #allParametrizationsA] do
	g := Evaluate(f,allParametrizationsA[i]);
	coefs := Coefficients(g);
	S := Scheme(A,coefs cat variablesNotInParams[i]);
	assert Dimension(S) eq 0;
	print Points(S);
end for;