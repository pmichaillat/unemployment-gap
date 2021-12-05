function vecssr=ssr(start,y,z,h,last)

% this procedure computes recursive residuals from a data set that starts
% at date "start" and ends at date "last". It returns a vector of sum of
% squared residuals (SSR) of length last-start+1 (stored for convenience in
% a vector of length T).

% start: starting entry of the sample used.
% last: ending date of the last segment considered.
% y: dependent variable
% z: matrix of regressors of dimension q
% h: minimal length of a segment

% initialize the vectors

vecssr=zeros(last,1);

% initialize the recursion with the first h data points.

inv1=inv(z(start:start+h-1,:)'*z(start:start+h-1,:));
delta1=inv1*(z(start:start+h-1,:)'*y(start:start+h-1,1));
res=y(start:start+h-1,1)-z(start:start+h-1,:)*delta1;
vecssr(start+h-1,1)=res'*res;

% loop to construct the recursive residuals and update the SSR

r=start+h;
while r <= last
    v=y(r,1)-z(r,:)*delta1;
    invz=inv1*z(r,:)';
    f=1+z(r,:)*invz;
    delta2=delta1+(invz*v)/f;
    inv2=inv1-(invz*invz')/f;
    inv1=inv2;
    delta1=delta2;
    vecssr(r,1)=vecssr(r-1,1)+v*v/f;
    r=r+1;
end

    