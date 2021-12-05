function sigmat=psigmq(res,b,q,i,nt)

% procedure that computes a diagonal matrix of dimension i+1 with ith entry
% the estimate of the variance of the residuals for segment i.

sigmat=zeros(i+1,i+1);
sigmat(1,1)=res(1:b(1,1),1)'*res(1:b(1,1),1)/b(1,1);
kk = 2;
while kk <= i
    sigmat(kk,kk)=res(b(kk-1,1)+1:b(kk,1),1)'*res(b(kk-1,1)+1:b(kk,1),1)/(b(kk,1)-b(kk-1,1));
    kk=kk+1;
end

sigmat(i+1,i+1)=res(b(i,1)+1:nt,1)'*res(b(i,1)+1:nt,1)/(nt-b(i,1));
