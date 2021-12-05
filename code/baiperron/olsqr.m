function b=olsqr(y,x)

b=inv(x'*x)*x'*y;
