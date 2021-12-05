function ker=kern(x)

% procedure to evaluate the quadratic kernel at some value x.

del=6*pi*x/5;
ker=3*(sin(del)/del-cos(del))/(del*del);
