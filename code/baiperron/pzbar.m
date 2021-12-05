function zb=pzbar(zz,m,bb)

% procedure to construct the diagonal partition of z with m break at date
% b.

[nt,q1]=size(zz);

zb=zeros(nt,(m+1)*q1);
zb(1:bb(1,1),1:q1)=zz(1:bb(1,1),:);
i=2;
while i <= m
    zb(bb(i-1,1)+1:bb(i,1),(i-1)*q1+1:i*q1)=zz(bb(i-1,1)+1:bb(i,1),:);
    i=i+1;
end
zb(bb(m,1)+1:nt,m*q1+1:(m+1)*q1)=zz(bb(m,1)+1:nt,:);
