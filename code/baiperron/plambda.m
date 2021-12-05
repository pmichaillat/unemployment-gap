function lambda=plambda(b,m,bigt)

% procedure that construct a diagonal matrix of dimension m+1 with ith
% entry (T_i-T_i-1)/T.

lambda=zeros(m+1,m+1);
lambda(1,1)=b(1,1)/bigt;
k=2;
while k <= m
    lambda(k,k)=(b(k,1)-b(k-1,1))/bigt;
    k=k+1;
end
lambda(m+1,m+1)=(bigt-b(m,1))/bigt;
